User.first_or_create! email: "steve@test.com", name: "Steve", password: "topsecret", password_confirmation: "topsecret", demo: true
User.first_or_create! email: "jill@test.com", name: "Jill", password: "topsecret", password_confirmation: "topsecret", demo: true
User.first_or_create! email: "anne@test.com", name: "Anne", password: "topsecret", password_confirmation: "topsecret", demo: true
User.first_or_create! email: "mike@test.com", name: "Mike", password: "topsecret", password_confirmation: "topsecret", demo: true
User.first_or_create! email: "casey@test.com", name: "Casey", password: "topsecret", password_confirmation: "topsecret", demo: true

unless Customer.exists?
  125.times do
    Customer.create! name: Faker::Name.name, email: Faker::Internet.email, company: Faker::Company.name, age: rand(18..70), status: ["Active", "Inactive", "Pending", "Suspended"].sample
  end
end
