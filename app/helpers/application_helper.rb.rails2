# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Detect iphone/ipod touch requests
  def iphone_request?
    (agent = request.env["HTTP_USER_AGENT"]) && agent[/(Mobile\/.+Safari)/]
  end
end
