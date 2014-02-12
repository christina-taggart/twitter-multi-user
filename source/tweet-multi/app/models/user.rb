class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :oauth_token, :oauth_secret, presence: true
end
