class Document
  
  include ActiveAttr::Model
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment  
  include ActiveAttr::QueryAttributes
 
  attribute :src_file_name 
#  attribute :src_content 
  attribute :trgt_file_name 
  attribute :trgt_lang_code 
#  attribute :src_is_draft 
  attribute :trgt_is_draft 
  attribute :document_row

  attr_accessor  :src_lang_code, :trgt_file_name, :trgt_lang_code, 
    :trgt_is_draft, :document_row
# :src_content,  :src_is_draft,


# def save
#   if @src_is_draft
#     src_content = @src_content['source']
#     trgt_content = @src_content['target']
#   else
#     src_content = @src_content
#   end
#   @src_lang_code, src_hash_content = src_content.first
#   @trgt_lang_code, trgt_hash_content = trgt_content.first if !trgt_content.nil? 
#   plain_content = plain_hash({ 'lang_code' => src_hash_content }, { 'lang_code' => trgt_hash_content } || {})
#   i = -1
#   plain_content.map { |k, v| plain_content[k].merge!(id: i+=1) }
#
#   @document_row ||= []
#   plain_content.each do |key, value|
#     @document_row.push(DocumentRow.new(value))
#   end
#   @trgt_is_draft = false
#   valid?
# end
  
  def document_row_attributes=(attributes)
    @document_row ||= []
    attributes.each do |i, row_params|
      @document_row.push(Row.new(row_params))
    end
  end
  
# def plain_hash(h, h2, level = 0, t_id = "", t_path = "", r = {})
#   h.each_pair do |key, value|
#     id = (!t_id.empty? ? "#{ t_id }_" : t_id) + "#{ key }"
#     path = t_path + "[#{ key }]"
#     r[id] = { key: key, path: path, is_group: true, level: level }
#     if h[key].class == Hash
#       plain_hash(h[key], h2[key]||{}, level + 1, id, path, r)
#     else
#       r[id][:src_value] = value
#       r[id][:trgt_value] = h2[key] || ''
#       r[id][:is_group] = false
#     end
#   end
#   return r
# end

end