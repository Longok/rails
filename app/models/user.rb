class User < ApplicationRecord
    attr_accessor :remember_token
    has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length: {minimum: 4}
    validates :email, uniqueness: true, length: {minimum: 6}, format: {with: VALID_EMAIL_REGEX}
    validates :password, presence: true, length: {minimum: 6}


    def User.digest string
        cost = if ActiveModel::SecurePassword.min_cost
                    BCrypt::Engine::MIN_COST
                else
                    BCrypt::Engine.cost
                end
        BCrypt::Password.create string, cost: cost
    end
    
      # Returns a random token.
    def User.new_token
    SecureRandom.urlsafe_base64
    end
    
      # Remembers a user in the database for use in persistent sessions.
    def remember 
        self.remember_token = User.new_token 
        update_attribute(:remember_digest, User.digest(remember_token))
    end
     
    def authenticated? remember_token 
        BCrypt::Password.new(remember_digest).is_password? remember_token 
    end

    def forget 
        update_attribute :remember_digest, nil
    end
       

    # paginate
    self.per_page = 10
end
