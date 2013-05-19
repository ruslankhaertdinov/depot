#coding=utf-8

class Category < ActiveRecord::Base
  has_many :products
  attr_accessible :title
  validates :title, presence: true, uniqueness: true, length: {minimum: 3}

  def self.available
    Category.joins(:products).uniq
  end

  def formatted_title
    title.gsub(/\W/, ' ').capitalize
  end
end
