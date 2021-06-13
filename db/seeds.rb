# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
    email: "admin@test.com",
    password: "admintest"
  )

10.times do |n|
    User.create!(
        email: "#{n + 1}@#{n + 1}",
        password: "aaaaaa",
        name: "a#{n + 1}号"
        )
    end

10.times do |n|
    Post.create!(
        user_id: n + 1,
        title: "テスト#{n + 1}",
        body: "これはテスト投稿です#{n + 1}版",
        type: 1
        )
    end
