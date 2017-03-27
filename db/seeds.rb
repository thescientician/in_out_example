4.times do |n|
  t = Team.create!(name:"team#{n}")
end

team_list = Team.all << nil

10.times do |n|
  u = User.new(:email => "user#{n}@goclio.com", 
              :first_name => Faker::Name.first_name,
              :last_name => Faker::Name.last_name,
              :password => "testtest",
              :password_confirmation => "testtest", 
              :status => :out, 
              :team => team_list.shuffle.first)

    u.current_sign_in_ip = Faker::Internet.ip_v4_address
    u.last_sign_in_ip = Faker::Internet.ip_v4_address
    u.web_site = Faker::Internet.domain_name
    u.save!
end
