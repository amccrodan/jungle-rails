class ReceiptMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def receipt_email(order)
    @order = order
    mail(to: @order.email, subject: "Your receipt for Order \##{@order.id}")
  end
end
