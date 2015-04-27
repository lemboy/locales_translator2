class UploadSource
  
  include Service

  attr_accessor :document, :src_file

  def initialize(attr = {})
    @document = attr[:document]
    @source_file = attr[:src_file].tempfile
    @is_draft = !(attr[:src_file].content_type.include?('application/x-yaml'))
    @source_filename = attr[:src_file].original_filename
    reset_error
    fill if upload
  end

  private 

    def upload
      begin
        source = @is_draft ? JSON.load(File.new(@source_file)) : YAML.load(@source_file)
      rescue Psych::SyntaxError => e
        return result(false, I18n.t('service.error.invalid_syntax_yml'))
      rescue JSON::ParserError => e
        return result(false, I18n.t('service.error.invalid_syntax_json'))
      else
        return result(false, I18n.t('service.error.invalid_file')) unless source.is_a?(Hash)
        @src_content = source
      ensure
        @file.close if @file
        @file.unlink if @file
      end
    end
    
    def fill
      if @is_draft
        src_content = @src_content['source']
        trgt_content = @src_content['target']
      else
        src_content = @src_content
      end
      @document.src_lang_code, src_hash_content = src_content.first
      @document.trgt_lang_code, trgt_hash_content = trgt_content.first if !trgt_content.nil? 
      plain_content = plain_hash({ 'lang_code' => src_hash_content }, { 'lang_code' => trgt_hash_content } || {})
      i = -1
      plain_content.map { |k, v| plain_content[k].merge!(id: i+=1) }
      @document.document_row ||= []
      plain_content.each do |key, value|
        @document.document_row.push(DocumentRow.new(value))
      end
      @document.src_file_name = @source_filename
      @document.trgt_is_draft = false
    end

    def plain_hash(h, h2, level = 0, t_id = "", t_path = "", r = {})
      h.each_pair do |key, value|
        id = (!t_id.empty? ? "#{ t_id }_" : t_id) + "#{ key }"
        path = t_path + "[#{ key }]"
        r[id] = { key: key, path: path, is_group: true, level: level }
        if h[key].class == Hash
          plain_hash(h[key], h2[key]||{}, level + 1, id, path, r)
        else
          r[id][:src_value] = value
          r[id][:trgt_value] = h2[key] || ''
          r[id][:is_group] = false
        end
      end
      return r
    end    

end