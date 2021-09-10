require 'dotenv/load' # gem dotenv
require 'twilio-ruby'

class TwilioText
  def send_text
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    @client.messages.create(
    from: ENV['TWILIO_NUM'],
    to: ENV['PHONE_NUM'],
    body: "Thank you! Your order was placed and will be delivered before #{delivery_time}"
    )
  end

  private
  
  def delivery_time
    estimate = Time.now + (60 * 60)
    estimate.strftime('%H:%M')
  end
end
