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
    product1 = Product.create!(name: "Sữa chua Vinamilk có đường",
            price: 25000
        )
    product1.image.attach(io: File.open(Rails.root.join('app/assets/images/co-duong.png')), filename: 'co-duong.png')
    
    product2 = Product.create!(name: "Sữa chua uống Kefir ",
            price: 6000
        )
    product2.image.attach(io: File.open(Rails.root.join('app/assets/images/SCU-kefir.png')), filename: 'SCU-kefir.png')

    product3 = Product.create!(name: "Sữa tười Farm có đường",
            price: 30000
        )
    product3.image.attach(io: File.open(Rails.root.join('app/assets/images/sugar-180ml.png')), filename: 'sugar.png')

    product4 = Product.create!(name: "Nước nha đam V-fresh",
            price: 8000
        )
    product4.image.attach(io: File.open(Rails.root.join('app/assets/images/vfresh.png')), filename: 'vfresh.png')
    