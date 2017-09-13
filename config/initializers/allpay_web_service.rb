require "allpay-web-service"
if Rails.env.development?
client = AllpayWebService::Client.new(
  merchant_id: "2000132",
  hash_key: "5294y06JbISpM5x9",
  hash_iv: "v77hoKGq4kWxNNIS"
)
end
