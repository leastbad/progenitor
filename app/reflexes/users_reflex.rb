# frozen_string_literal: true

class UsersReflex < ApplicationReflex
  def search(name)
    users = User.where(demo: true).where("name ILIKE :prefix", prefix: "#{name}%")
    self.payload = users.map { |user| {text: user.name, value: user.id} }
    morph :nothing
  end
end
