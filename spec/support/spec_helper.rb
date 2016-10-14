module SpecHelper

  def stub_pivotal_tracker_api
    api = TrackerApi::Client

    allow(api).to receive(:new).with(token: "valid token") {
      DishonestClient.new
    }

    allow(api).to receive(:new).with(token: "invalid token") {
      raise PhonyAuthenticationError.new
    }
  end

end
