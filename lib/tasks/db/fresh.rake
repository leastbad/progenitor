namespace :db do
  desc "Recreate and remigrate the database from scratch"
  task fresh: [:drop, :create, :migrate, :seed] do
    puts "Refreshed database"
  end
end