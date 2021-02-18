class ManagementAddress
  include ActiveModel::Model
  attr_accessor :token,:add_num,:area_id,:city,:add_line,:add_build,:tel_num,:item_id,:user_id,:management_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :add_num
    validates :area_id,numericality: { other_than: 1 }
    validates :city
    validates :add_line
    validates :tel_num
    validates :management_id
  end

  def save
    management = Management.create(user_id: user_id, item_id: item_id)
    Address.create(add_num: add_num, area_id: area_id, city: city, add_line: add_lime, add_build: add_build, tel_num: tel_num, management_id: management.id)
  end
end