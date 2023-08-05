class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }

  # 検索方法分岐
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @book = Book.where("title LIKE?", "#{word}")
  #   elsif search == "foward_match"
  #     @book = Book.where("title LIKE?", "#{word}%")
  #   elsif search == "backword_match"
  #     @book = Book.where("title LIKE?", "%#{word}")
  #   elsif search == "partial_match"
  #     @book = Book.where("title LIKE?", "%#{word}%")
  #   else
  #     @book = Book.all
  #   end
  # end

  def self.look_for(word, method)
    if method == "perfect"
      @book = Book.where("title LIKE ?", "#{word}")
    elsif method == "forward"
      @book = Book.where("title LIKE ?", "#{word}%")
    elsif method == "backward"
      @book = Book.where("title LIKE ?", "%#{word}")
    elsif method == "partial"
      @book = Book.where("title LIKE ?", "%#{word}%")
    end
  end

end
