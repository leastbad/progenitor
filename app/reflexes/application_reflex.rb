# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  class IdentityError < RuntimeError; end
  delegate :current_user, :session_id, to: :connection
  include Pagy::Backend

  before_reflex do
    raise IdentityError.new("invalid user") if connection.env["warden"].user && invalid_user?
  end

  private

  def invalid_user?
    connection.connection_identifier.exclude?(connection.env["warden"].user.to_gid_param) || connection.connection_identifier.exclude?(request.session.id)
  end
end
