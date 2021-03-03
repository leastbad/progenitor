# frozen_string_literal: true

class UsersReflex < ApplicationReflex
  def search(name)
    users = User.where(demo: true).where("name ILIKE :prefix", prefix: "#{name}%")
    result = users.map { |user| { text: user.name, value: user.id }}
    cable_ready.dispatch_event(name: "data", detail: {options: result}).broadcast
    morph :nothing
  end
end