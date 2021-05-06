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
unless User.find_by(email: 'testuser@example.com')
  User.create(email: 'testuser@example.com',
              username: 'testuser',
              first_name: 'Test',
              last_name: 'User',
              password: 'testpassword',
              confirmed_at: DateTime.current)
end
