class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # 1use が1book に対して1favorite のみ作成可能、という意味
  validates_uniqueness_of :book_id, scope: :user_id
end
