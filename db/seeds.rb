# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Seed Gender
[
  { group: 'gender', name: 'Female' },
  { group: 'gender', name: 'Male' },
  { group: 'gender', name: 'Something else' }
].each do |look_up|
  unless LookUp.exists?(group: look_up[:group], name: look_up[:name])
    LookUp.create(group: look_up[:group], name: look_up[:name])
  end
end

# Seed user
unless User.find_by(email: 'janna@example.com')
  User.create(email: 'janna@example.com',
              username: 'janna',
              first_name: 'Janna',
              last_name: 'Dela Cruz',
              password: 'password')
end
