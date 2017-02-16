class ReceiptMailerPreview < ActionMailer::Preview
  def receipt_email
    ReceiptMailer.receipt_email(Order.last)
  end
end
