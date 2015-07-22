# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  bio             :text
#  profile_pic_url :string
#

class User < ActiveRecord::Base
  has_secure_password

  before_save :default_values

  has_many :posts
  has_many :comments

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true

  def default_values
    self.profile_pic_url ||= "profile_pics/profile.png"
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

end
