#coding=utf-8

class Category < ActiveRecord::Base
  has_many :products
  attr_accessible :title
  validates :title, presence: true, uniqueness: true, length: {minimum: 3}

  def self.available
    Category.joins(:products).uniq
  end

  def title_ru
    case title
      when 'eye-shadow'
        'Тени'
      when 'lip balms'
        'Помада'
      when 'mascara'
        'Тушь'
      when 'moisturizing cream'
        'Увлажняющие крема'
      when 'scrub'
        'Скраб'
      when 'low-fat cream'
        'Нежирные крема'
      when 'tonic'
        'Тоники'
      when 'lotions'
        'Лосьоны'
      else
        'Категория на оформлении'
    end
  end
end
