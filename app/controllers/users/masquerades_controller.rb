# frozen_string_literal: true

class Users::MasqueradesController < Devise::MasqueradesController
  def show
    cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(session.id)
    super
  end

  def back
    cable_ready[SessionChannel].dispatch_event(name: "reconnect").broadcast_to(session.id)
    super
  end

  def after_masquerade_path_for(resource)
    request.referer
  end

  def after_back_masquerade_path_for(resource)
    request.referer
  end
end
