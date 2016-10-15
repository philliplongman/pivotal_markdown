require 'ostruct'

module FraudulentObjects

  class DishonestClient

    def initialize(options)
      @token = options[:token]
    end

    def me
      if @token == "invalid token"
        raise PhonyError.new "Invalid authentication credentials were presented."
      else
        FakeName.new(
          name: "Brigid O'Shaughnessy",
          email: "misswonderly@gmail.com"
        )
      end
    end

    def project(id)
      if @token == "invalid token"
        raise PhonyError.new "Invalid authentication credentials were presented."
      elsif id == "invalid ID"
        raise PhonyError.new "The object you tried to access could not be found..."
      else
        ShadyJob.new(
          id: "00000",
          name: "Steal the Maltese Falcon"
        )
      end
    end

  end

  class FakeName < OpenStruct
  end

  class ShadyJob < OpenStruct
  end

  class PhonyError < StandardError
    def response
      { body: { "error" => message } }
    end
  end

end
