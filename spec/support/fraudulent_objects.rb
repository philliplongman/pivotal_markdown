require 'ostruct'

module FraudulentObjects

  class DishonestClient

    def me
      FakeName.new(
        name: "Brigid O'Shaughnessy",
        email: "misswonderly@gmail.com"
      )
    end

    def project(id)
      if id == '00000'
        ShadyJob.new(id: "00000", name: "Steal the Maltese Falcon")
      else
        raise PhonyBadProjectError.new
      end
    end

  end

  class FakeName < OpenStruct
  end

  class ShadyJob < OpenStruct
  end

  class PhonyAuthenticationError < StandardError
    def message
      "Invalid API token."
    end

    def response
      { body: { "code" => "invalid_authentication" } }
    end
  end

  class PhonyBadProjectError < StandardError
    def message
      "Project ID not found."
    end

    def response
      { body: { "code" => nil } }
    end
  end
end
