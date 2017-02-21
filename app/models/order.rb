class Order < ActiveRecord::Base

  after_create :update_quantities

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  private
    def update_quantities
      self.line_items.each do |item|
        product = Product.find(item.product_id)
        product.quantity -= item.quantity
        product.save!
      end
    end
end
