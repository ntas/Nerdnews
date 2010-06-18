module ApplicationHelper
  # Detect iphone/ipod touch requests
  def iphone_request?
    (agent = request.env["HTTP_USER_AGENT"]) && agent[/(Mobile\/.+Safari)/]
  end
end
