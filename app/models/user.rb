class User < ApplicationRecord
    validates :email,{presence: true}
    validates :password,{presence: true}
    validates :name,{presence: true}

    def posts
        return Post.where(user_id: self.id)
    end
end
