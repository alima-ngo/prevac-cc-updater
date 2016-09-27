class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :ping_mqi

  MQI_URL = "http://localhost:3001"

  def ping_mqi
    begin
      r = HTTP.get("#{MQI_URL}/ping")
      r = r.code == 200 ? "ok" : "ko"
    rescue
      r = "ko"
    end
    @mqi_status = r
  end
end
