class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :management
  belongs_to :area

  validates :management_id,presence: true
end
