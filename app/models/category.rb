class Category < ActiveRecord::Base
  has_many :products
  attr_accessible :title
  validates :title, presence: true, uniqueness: true, length: {minimum: 3}
end
