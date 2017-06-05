class User < ApplicationRecord
   
  mount_uploader :image, ImageUploader

   has_many :friendships
   has_many :friends, :through => :friendships

=begin
   has_many :reverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
   has_many :reverse_friends, :through => :reverse_friendships, :source => :user
=end

   has_many :requested_friendships, -> { where(status: "pending")}, :class_name => "Friendship",:foreign_key => "friend_id"
   has_many :requested_friends, :through => :requested_friendships, :source => :user


   has_many :pending_friendships, -> { where(status: "requested")}, :class_name => "Friendship",:foreign_key => "friend_id"
   has_many :pending_friends, :through => :pending_friendships, :source => :user


   has_many :accepted_friendships, -> { where(status: "accepted")}, :class_name => "Friendship",:foreign_key => "friend_id"
   has_many :accepted_friends, :through => :accepted_friendships, :source => :user

  ###################################################
   
    has_many :conversations
    has_many :exchanges, :through => :conversations
  


  ####################################################

   
   

    attr_accessor :remember_token
    has_secure_password
    
      before_save { self.email = email.downcase }
  	validates :firstname, presence: true, length: { maximum: 50 }
        validates :lastname, presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  	validates :password, presence: true, length: { minimum: 6 }


  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
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

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)

    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  
  end
  
   # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end



