class CustomerFilter < ApplicationFilter
  attribute :search, :string
  attribute :state, :string
  attribute :items, :integer, default: 10
  attribute :page, :integer, default: 1
  attribute :order, :string, default: "name"
  attribute :direction, :string, default: "asc"

  def scope
    Customer.with_state(state).order(order => direction).search_for(search)
  end
end