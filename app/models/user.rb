class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains

  attr_accessible :name, :password, :password_confirmation, :email
  validates :name, :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/

  has_secure_password

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
