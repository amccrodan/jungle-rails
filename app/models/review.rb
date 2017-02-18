class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :user, presence: true
  validates :product, presence: true

  validates :user, uniqueness: { scope: :product, message: "has already rated this product." }

  validates :rating, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than: 6
    }

end
