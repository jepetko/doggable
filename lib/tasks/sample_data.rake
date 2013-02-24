require 'faker'

namespace :db do
  desc "generate some data for the application"

  task :sample_data => :environment do

    Rake::Task['db:reset'].invoke

    make_users
    make_skills
    make_dogs User.all
    make_dog_skill_associations Dog.all, Skill.all

  end

end

def make_users
  100.times do |n|
    name = Faker::Name.name
    email = "u#{n}@domain.com"
    pwd = "s3cr3t"
    usr = User.create!( :name => name, :email => email, :password => pwd, :password_confirmation => pwd)
    #if n == 0 then
    #  usr.can :manage, :all
    #end
  end
end

def make_skills
  names = ['barking', 'running', 'loving balls', 'loving sausage', 'biting', 'playing with other dogs']
  names.each do |name|
    Skill.create!( :name => name )
  end
end

def make_dogs(users)
  names = ['Spike', 'Diego', 'Romeo', 'Mike', 'Oskar', 'Anna', 'Lucy', 'Kira']
  users.each do |usr|
    dog = Dog.new(:name => names[Random.rand(names.length)])
    dog.user_id = usr.id
    dog.save!
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