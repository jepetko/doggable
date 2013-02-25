require 'faker'

namespace :db do
  desc "generate some data for the application"

  task :sample_data => :environment do

    Rake::Task['db:reset'].invoke

    make_users 100
    make_skills 10
    make_dogs User.all, 2
    make_dog_skill_associations Dog.all, Skill.all

  end

  task :sample_users => :environment do |count|
    make_users count
  end

  task :sample_dogs => :environment do |users,count|
    users = [users] if users.instance_of?(User)
    make_dogs users,count
  end

end

def make_users(count)
  count.times do |n|
    name = Faker::Name.name
    email = "u#{n}@domain.com"
    pwd = "s3cr3t"
    usr = User.new( :name => name, :email => email, :password => pwd, :password_confirmation => pwd)
    if n%2 == 0 then
      usr.roles = []
      usr.roles << Role.find_by_name(:admin)
    end
    usr.save!
  end
end

def make_skills(count)
  names = %w{ barking
              running
              loving\ balls
              loving\ sausage
              biting
              playing\ with\ other\ dogs}
  count.times do |n|
    name = names[Random.rand(names.length)]
    str = String.new(name)
    str << ' - ' << n.to_s
    Skill.create!( :name => str )
  end
end

def make_dogs(users,count)
  names = %w{ Spike Diego Romeo Mike Oskar Anna Lucy Kira}
  users.each do |usr|
    count.times do |n|
      dog = Dog.new(:name => names[Random.rand(names.length)])
      dog.user_id = usr.id
      dog.save!
    end
  end
end

def make_dog_skill_associations(dogs, skills)
  dogs.each do |dog|
     (0..3).each do |index|
       pos = Random.rand(skills.length)
       skill = skills[ pos ]
       dog.dog_skill_relationships.build( :skill_id => skill.id )
       dog.save!
     end
  end
end