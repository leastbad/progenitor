User.create! email: "steve@test.com", name: "Steve", password: "topsecret", password_confirmation: "topsecret", demo: true
User.create! email: "jill@test.com", name: "Jill", password: "topsecret", password_confirmation: "topsecret", demo: true
User.create! email: "anne@test.com", name: "Anne", password: "topsecret", password_confirmation: "topsecret", demo: true
User.create! email: "mike@test.com", name: "Mike", password: "topsecret", password_confirmation: "topsecret", demo: true
User.create! email: "casey@test.com", name: "Casey", password: "topsecret", password_confirmation: "topsecret", demo: true

45.times do
  Customer.create! name: Faker::Name.name, email: Faker::Internet.email, company: Faker::Company.name, position: Faker::Job.position, state: ["Active", "Inactive", "Pending", "Suspended"].sample
end