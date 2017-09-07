require "offsite_payments/action_view_helper"
ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)

# initializers/allpay.rb
# ActiveMerchant::Billing::Integrations::Allpay
OffsitePayments::Integrations::Allpay.setup do |allpay|
  if Rails.env.development?
    # default setting for stage test
    allpay.merchant_id = '2000132'
    allpay.hash_key    = '5294y06JbISpM5x9'
    allpay.hash_iv     = 'v77hoKGq4kWxNNIS'
  else
    # change to yours
    allpay.merchant_id = '7788520'
    allpay.hash_key    = 'adfas123412343j'
    allpay.hash_iv     = '123ddewqerasdfas'
  end

  def notify
  notification = OffsitePayments::Integrations::Allpay::Notification.new(request.raw_post)

  order = Order.find_by_number(notification.merchant_trade_no)

  if notification.status && notification.checksum_ok?
    # payment is compeleted
  else
    # payment is failed
  end

  render text: '1|OK', status: 200
  end
end
