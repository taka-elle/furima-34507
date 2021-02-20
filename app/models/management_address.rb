class ManagementAddress
  include ActiveModel::Model
  attr_accessor :add_num,:area_id,:city,:add_line,:add_build,
                :tel_num,:item_id,:user_id,:management_id,:token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :add_num, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :area_id, numericality: { other_than: 1 }
    validates :city
    validates :add_line
    validates :tel_num, length:{maximum: 11},format: {with: /\A[0-9]+\z/}
    validates :token
  end

  def save
    management = Management.create(user_id: user_id, item_id: item_id)
    Address.create(add_num: add_num, area_id: area_id, city: city, add_line: add_line, add_build: add_build, tel_num: tel_num, management_id: management.id)
  end
end