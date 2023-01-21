10.times do |n|
 User.create!(
   name: "ユーザー#{n+1}",
   email: "user#{n+1}@example.com",
   password: "password00" ,
   password_confirmation: "password00",
   user_discription: "ユーザー#{n+1}です。よろしくお願いします。"
)
end

s1 = Date.parse("2022/09/01")
s2 = Date.parse("2023/01/01")
User.all.each do |user|
  2.times do |n|
    s = Random.rand(s1 .. s2)
    Post.create!(
      user_id: user.id,
      body: "#{user.name}の投稿#{n+1}です" + "こんにちは" + 
      "\n投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります投稿内容が入ります",
      created_at: s
    )
  end
end