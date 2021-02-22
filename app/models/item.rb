class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many_attached :images
  belongs_to :category
  belongs_to :status
  belongs_to :charges
  belongs_to :area
  belongs_to :day
  belongs_to :user
  has_one    :management

  with_options presence: true do
    validates :name
    validates :text
    validates :images
    validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000 }
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :charges_id
      validates :area_id
      validates :day_id
    end
  end
end
