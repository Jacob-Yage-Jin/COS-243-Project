class User < ActiveRecord::Base
        validates :name, presence: true, length: { maximum: 50 }
        validates :email, presence: true, uniqueness: { case_sensitive: false }
        validates :password, presence: true, uniqueness: { case_sensitive: false }
end
