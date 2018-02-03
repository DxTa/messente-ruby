require "rubygems"
require "httparty"

class Messente

  include HTTParty

  base_uri "https://api2.messente.com"

  def initialize(options)
    @defaults = options
  end

  def verify_start(options)
    query = @defaults.merge(options)

    response      = self.class.get("/verify/start/", :query => query)
    items         = response.split(" ")
    error_message = errors[response]
    if items[0] != "ERROR" && error_message.nil?
      return { :id => items[1] }
    else
      return { :error => error_message, :code => response }
    end
  end

  def verify_pin(options)
    query = @defaults.merge(options)

    response = self.class.get("/verify/pin/", :query => query)
    items    = response.split(" ")
    error_message = errors[response]
    if items[0] != "ERROR" && error_message.nil?
      return {}
    else
      return { :error => error_message, :code => response }
    end
  end

  def send(options)
    query = @defaults.merge(options)

    response = self.class.get("/send_sms", :query => query)
    items    = response.split(" ")
    error_message = errors[response.to_s]
    if items[0] != "ERROR" && error_message.nil?
      return true
    else
      return { :error => error_message, :code => response }
    end
  end

  # def balance
  #   response = self.class.get("/get_balance/#{@defaults[:user]}/#{@defaults[:api_key]}")
  #   items    = response.split(" ")
  #   return false if ("ERROR" == items[0])

  #   items[1].to_f
  # end

  # def report(options)
  #   response = self.class.get("/get_dlr_response/#{@defaults[:user]}/#{@defaults[:api_key]}/#{options[:id]}")
  #   pp items = response.split(" ")
  #   return false if ("ERROR" == items[0])

  #   items[1]
  # end

  private
  def errors
    {
      'VERIFIED'   => 'User is logging in from already verified computer, no PIN code verification is required.',
      'ERROR 101'  => 'Access is restricted, wrong credentials. Check the username and password values.',
      'ERROR 102'  => 'Parameters are wrong or missing. Check that all the required parameters are present.',
      'ERROR 103'  => 'Invalid IP address. The IP address you made the request from, is not in the API settings whitelist.',
      'ERROR 111'  => 'Sender parameter "from" is invalid. You have not activated this sender name from Messente.com',
      'ERROR 109'  => 'PIN code field is missing in the template value.',
      'FAILED 209' => 'Server failure, try again after a few seconds or try the api3.messente.com backup server.'
    }
  end

end