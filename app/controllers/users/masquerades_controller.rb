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
    # return user_path(resource) if resource.has_role? :chef
    # root_path
  end

  def after_back_masquerade_path_for(resource)
    request.referer
  end

  # def find_resource
  #   masqueraded_resource_class.friendly.find(params[:id])
  # end
end