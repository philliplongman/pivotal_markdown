require 'ostruct'

module FraudulentObjects

  class UnreliableUser
    def name
      "Holden Caulfield"
    end

    def email
      "catcher@therye.com"
    end
  end

  class UntrustworthyProject
    def project_id
      "000"
    end

    def project_name
      "Help that Nigerian Prince"
    end
  end

  class DishonestClient

    def me
      OpenStruct.new(name: "Brigid O'Shaughnessy", email: "misswonderly@gmail.com")
    end

    def project(id)
      case id
      when 'valid id'   then OpenStruct.new(name: "Steal the Maltese Falcon")
      when 'invalid id' then raise FakeBadProjectError.new
      end
    end
  end

  class FakeAuthenticationError < StandardError
    def message
      "Invalid API token."
    end

    def response
      { body: { "code" => "invalid_authentication" } }
    end
  end

  class FakeBadProjectError < StandardError
    def message
      "Project ID not found."
    end

    def response
      { body: { "code" => nil } }
    end
  end
end
