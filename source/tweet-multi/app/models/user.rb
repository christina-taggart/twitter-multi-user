class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :username, presence: true
end