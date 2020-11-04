# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.find(email: "janna@example.com")
  User.create(email: "janna@example.com",
              username: "janna",
              first_name: "Janna",
              last_name: "Dela Cruz",
              password: "password"
             )
end

[
  %{
    type: "gender",
    name: "Female",
  },
  %{
    type: "gender",
    name: "Male"
  },
  %{
    type: "gender",
    name: "Something else"
  }
].each do |type, name|
  unless LookUp.where(type: type, name: name) do
    LookUp.create(type: type, name: name)
  end
end
