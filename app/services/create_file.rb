class CreateFile

  include Service

  attr_reader :content, :file_name

  def initialize(attr = {})
    params = attr[:params] 
    @src_lang_code  = params[:document][:src_lang_code] 
    @trgt_lang_code = params[:document][:trgt_lang_code] 
    @trgt_file_name = params[:document][:trgt_file_name] 
    @trgt_is_draft  = 'true'.include?(params[:document][:trgt_is_draft]) 
    @src_array      = params[:src_array]
    @trgt_array     = params[:trgt_array]

    reset_error
    creation
  end

  def creation
    src_hash = { @src_lang_code => @src_array.to_hash.values.first }
    trgt_hash = { @trgt_lang_code => @trgt_array.to_hash.values.first }
    @trgt_file_name.gsub!(/\.yml|\.json\Z/, '') if @trgt_file_name.presence
    if @trgt_is_draft
      @trgt_file_name = "#{@src_lang_code}-#{@trgt_lang_code}-draft" unless @trgt_file_name.presence
      content = { 'source' => src_hash, 'target' => trgt_hash }.to_json

    else  
      @trgt_file_name = @trgt_lang_code unless @trgt_file_name.presence
      content = trgt_hash.to_yaml(options = {:line_width => -1})
    end
    @trgt_file_name << (@trgt_is_draft ? '.json' : '.yml')

    @file_name = @trgt_file_name
    @content = content
    @success
  end

end