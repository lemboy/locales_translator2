class DocumentRow
  include ActiveAttr::Model
  include ActiveAttr::MassAssignment

  attribute :id
  attribute :key 
  attribute :path 
  attribute :is_group 
  attribute :level 
  attribute :src_value 
  attribute :trgt_value
      
end