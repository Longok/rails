User.create!(name: "HP Long",
    email:"admin@gmail.com",
    password: "123123",
    password_confirmation: "123123",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

50.times do |n|
    name = Faker::Name.name 
    email = "example-#{n+1}@railstutorial.org"
    password = "password"

    User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end