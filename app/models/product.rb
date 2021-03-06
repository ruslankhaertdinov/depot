class Product < ActiveRecord::Base
  mount_uploader :image_url, ProductImageUploader
  has_many :line_items
  belongs_to :category
  before_destroy :ensure_not_referenced_by_any_line_item

  attr_accessible :title, :price, :description, :image_url, :category_id

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: {minimum: 3}
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png|jpeg|bmp)\z}i,
      message: 'must be a URL for GIF, JPG, JPEG, BMP or PNG image.'
  }

  scope :sorted, -> { order('created_at DESC') }

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'Line Items present')
      false
    end
  end
end
