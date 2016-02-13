require 'api_callers/http_request'
require 'api_callers/http_requester'

class MeetupApi
  BASE_URL = 'http://api.meetup.com/2/'

  def method_request(method, params)
    params = params.merge( { key: ::MeetupClient.config.api_key } )
    request = ApiCallers::HttpRequest.new("#{BASE_URL}#{method}?#{query_string(params)}")
    requester = ApiCallers::HttpRequester.new(request)
    requester.execute_request
  end

  def method_missing(method, *args, &block)
    self.method_request(method, args[0])
  end

  private

  def query_string(params)
    params.map { |k,v| "#{k}=#{v}" }.join("&")
  end
end
