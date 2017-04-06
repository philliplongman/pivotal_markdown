require 'ostruct'

module Mocks

  class FakeTrackerApiClient

    attr_reader :token

    def initialize(options)
      @token = options[:token]
    end

    def me
      if token == "invalid token"
        raise InvalidTokenError.new
      else
        OpenStruct.new(name: "Brigid O'Shaughnessy", email: "misswonderly@gmail.com")
      end
    end

    def project(id)
      if token == "invalid token"
        raise InvalidTokenError.new
      elsif id == "invalid ID"
        raise InvalidProjectError.new
      else
        OpenStruct.new(id: "00000", name: "Steal the Maltese Falcon")
      end
    end

  end

  class InvalidTokenError < StandardError
    def response
      { body: { "error" => "Invalid authentication credentials were presented." } }
    end
  end

  class InvalidProjectError < StandardError
    def response
      { body: { "error" => "The object you tried to access could not be found..." } }
    end
  end
  
end
