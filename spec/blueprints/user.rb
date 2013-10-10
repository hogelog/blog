User.blueprint do
  username { "user #{sn}" }
  password { User.create_password(object.username, "pass") }
end
