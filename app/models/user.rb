class User < ActiveRecord::Base
  acts_as_token_authenticatable

  has_many :albums

  devise :database_authenticatable, :trackable, :validatable
end
