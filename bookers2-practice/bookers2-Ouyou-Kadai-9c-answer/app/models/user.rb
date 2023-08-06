class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :group_users, dependent: :destroy

  # has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # # user.following_users　で、フォロー中のユーザーを全部取りたい
  # has_many :following_users, through: :followers, source: :followed
  # has_many :follower_users, through: :followeds, source: :follower

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # def follow(user_id)
  #   followers.create(followed_id: user_id)
  # end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  # def unfollow(user_id)
  #   followers.find_by(followed_id: user_id).destroy
  # end

  def unfollow(user)
    relatinoships.find_by(followed_id: user.id).destroy
  end

  # def following?(user)
  #   following_users.include?(user)
  # end

  def following?(user)
    followings.include?(user)
  end

  # # 検索方法の分岐
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @user = User.where("name LIKE?", "#{word}")
  #   elsif search == "foward_match"
  #     @user = User.where("name LIKE?", "#{word}%")
  #   elsif search == "backword_match"
  #     @user = User.where("name LIKE?", "%#{word}")
  #   elsif search == "partial_match"
  #     @user = User.where("name LIKE?", "%#{word}%")
  #   else
  #     @user = User.all
  #   end
  # end

  def self.look_for(word, method)
    if method == "perfect"
      @user = User.where("name LIKE ?", "#{word}")
    elsif method == "forward"
      @user = User.where("name LIKE ?", "#{word}%")
    elsif method == "backward"
      @user = User.where("name LIKE ?", "%#{word}")
    elsif method == "partial"
      @user = User.where("name LIKE ?", "%#{word}%")
    end
  end

end
