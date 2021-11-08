class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :following


  def follow(user_id)
    relationships.create(follower_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'front'
      User.where('name LIKE ?', '%'+content)
    elsif method == 'back'
      User.where('name LIKE ?', content+'%')
    else
      User.where('name LIKE ?', '%'+content+'%')
    end
  end

end

