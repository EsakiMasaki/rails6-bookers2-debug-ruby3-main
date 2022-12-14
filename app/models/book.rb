class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites ,dependent: :destroy
  has_many :book_comments ,dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorite_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search,word)
    if search == "完全一致"
      Book.where("title LIKE?", "#{word}")
    elsif search == "前方一致"
      Book.where("title LIKE?", "#{word}%")
    elsif search == "後方一致"
      Book.where("title LIKE?", "%#{word}")
    elsif search == "部分一致"
      Book.where("title LIKE?", "%#{word}%")
    else
      Book.all
    end
  end

end
