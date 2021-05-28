class CustomFailure < Devise::FailureApp
  include CableReady::Broadcaster

  def redirect_url
    new_user_session_path
  end

  def respond
    if http_auth?
      cable_ready[OptimismChannel]
        .add_css_class(selector: "#form_errors", name: "d-flex")
        .remove_css_class(selector: "#form_errors", name: "d-none")
        .text_content(selector: "#error_message", text: http_auth_body)
        .broadcast_to(session.id)
      self.status = 401
      self.content_type = "text/plain"
    else
      redirect
    end
  end
end