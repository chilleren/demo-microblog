# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Post.delete_all

password = 'password'
usernames = ['bort', 'trish', 'rodney']
hashtags = ['#blessed', '#yolo', '#soccer_moms', '#sorry_not_sorry']
file = File.open(File.expand_path(File.join(File.dirname(__FILE__), "hipster_ipsum.txt")), "rb")
file_contents = file.read
hipster_ipsum = file_contents.split('.')
file.close

usernames.each_with_index do |username, i|
  bio = "#{username} is a #{hipster_ipsum.sample(rand(3..5)).join('. ')}"
  profile_pic_url = "profile_pics/#{i+1}.png"
  User.create_with(password: password, bio: bio, profile_pic_url: profile_pic_url).find_or_create_by(username: username)
end

User.all.each do |user|

  10.times do
    #random_user = User.find_by(username: usernames.sample)
    random_content = hipster_ipsum.sample(rand(1..5)).join('. ')
    content = random_content
    #random_hashtag = hashtags.sample
    #content << ' ' << random_hashtag
    random_date = rand(2..30).days.ago
    post = Post.create({ user_id: user.id, content: content, created_at: random_date })

    rand(0..5).times do 
      commentor = User.all.sample()
      Comment.create({user_id: commentor.id, post_id: post.id, content: hipster_ipsum.sample(rand(1..2)).join('. ')})
    end
  end
end