class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :payments
    
    has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy

    has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy

    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest

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
        digest = self.send("remember_digest")
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password? remember_token 
    end

    def forget 
        update_attribute :remember_digest, nil
    end
    

    # Returns true if the given token matches the digest.
    def authenticated? attribute, token
        digest = send ("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password? token
    end

    # Activates an account.
    def activate 
        update_columns activated: true, activated_at: Time.zone.now 
    end
    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now 
    end


    # Password resets
    def create_reset_digest
        self.reset_token = User.new_token
        update_columns reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
       
    # Microposts
    def feed
        # microposts
        # Micropost.where user_id: (following_ids << id) 
        following_ids = "SELECT followed_id FROM relationships
            WHERE follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids})
            OR user_id = :user_id", user_id: id)

    end

    # Follow
    def follow other_user #Follows a user.
        following << other_user
    end
    def unfollow other_user #Unfollows a user.
        following.delete other_user
    end
    def following? other_user #Returns if the current user is following the other_user or not
        following.include? other_user
    end


    private
    def downcase_email
        self.email = email.downcase
    end

    # Account-activation 
    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end

    
end
