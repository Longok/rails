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

    # micropost
    users = User.order(:created_at).take(6)
    30.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.microposts.create!(content: content) }
    end

    # follow
    # Following relationships
    users = User.all 
    user = users.first 
    following = users[2..20]
    followers = users[3..15]
    following.each{|followed| user.follow(followed)}
    followers.each{|follower| follower.follow(user)}

    #products
    # Product.create!(name: "Sua chua co duong",
    #         price: 25000)

    #     Product.image.attach(io: File.open("app/assets/images/co-duong.png"), filename: 'co-duong.png')
    