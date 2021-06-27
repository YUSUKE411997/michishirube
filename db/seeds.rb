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

50.times do |n|
    User.create!(
        email: "#{n + 1}@#{n + 1}",
        password: "aaaaaa",
        name: "村人#{n + 1}号"
        )
    end

50.times do |n|
    Post.create!(
        user_id: n + 1,
        title: "気ままにテスト#{n + 1}",
        body: "これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}",
        type: 0
        )
    Timeline.create!(
        user_id: n + 1,
        post_id: n + 1
        )
    end

50.times do |n|
    Post.create!(
        user_id: n + 1,
        title: "やってみたいテスト#{n + 1}",
        body: "これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}",
        type: 1
        )
    Timeline.create!(
        user_id: n + 1,
        post_id: 50 + (n + 1)
        )
    Plan.create!(
        user_id: n + 1,
        post_id: 50 + (n + 1)
        )

    end

50.times do |n|
    Post.create!(
        user_id: n + 1,
        title: "やってみたテスト#{n + 1}",
        body: "これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}これはテスト投稿です#{n + 1}",
        type: 2
        )
    Timeline.create!(
        user_id: n + 1,
        post_id: 100 + (n + 1)
        )
    Plan.create!(
        user_id: n + 1,
        post_id: 100 + (n + 1),
        start_time: Post.find(100 + (n + 1)).created_at
        )

    end

49.times do |n|
    Relationship.create!(
        following_id: n + 1,
        follower_id: 50 - (n + 1)
        )
    end

 Tag.create!(
        tag_name: "エンジニア"
        )
Tag.create!(
        tag_name: "プログラミング"
        )
Tag.create!(
        tag_name: "Rails"
        )
30.times do |n|
    Like.create!(
        user_id: n + 1,
        post_id: 1
        )
    Like.create!(
        user_id: n + 1,
        post_id: 51
        )
    Like.create!(
        user_id: n + 1,
        post_id: 101
        )
    Repost.create!(
        user_id: 10 + (n + 1),
        post_id: 10
        )
    Timeline.create!(
        post_id: 10,
        user_id: 10 + (n + 1),
        repost_id: n + 1
        )
    Preview.create!(
        user_id: n + 1,
        post_id: 150
        )
   
    TagMap.create!(
        tag_id: 1,
        post_id: n + 1
        )
    end

20.times do |n|
    Like.create!(
        user_id: n + 1,
        post_id: 2
        )
    Like.create!(
        user_id: n + 1,
        post_id: 52
        )
    Like.create!(
        user_id: n + 1,
        post_id: 102
        )
    Repost.create!(
        user_id: 10 + (n + 1),
        post_id: 11
        )
    Timeline.create!(
        post_id: 11,
        user_id: 10 + (n + 1),
        repost_id: 30 + (n + 1)
        )
    Preview.create!(
        user_id: n + 1,
        post_id: 149
        )
    
    TagMap.create!(
        tag_id: 2,
        post_id: 30 + (n + 1)
        )
    end

10.times do |n|
    Like.create!(
        user_id: n + 1,
        post_id: 3
        )
    Like.create!(
        user_id: n + 1,
        post_id: 53
        )
    Like.create!(
        user_id: n + 1,
        post_id: 103
        )
    Repost.create!(
        user_id: 10 + (n + 1),
        post_id: 12
        )
    Timeline.create!(
        post_id: 12,
        user_id: 10 + (n + 1),
        repost_id:  + (n + 1)
        )
    Preview.create!(
        user_id: n + 1,
        post_id: 148
        )
    
    TagMap.create!(
        tag_id: 3,
        post_id: 50 + (n + 1)
        )
    end