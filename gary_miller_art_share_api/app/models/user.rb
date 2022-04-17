class User < ApplicationRecord
    # ensures users have a name and email
    validates :name, presence: true
    validates :email, presence: true
end