# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email: 'g-barr@mail.ru') do |user|
  user.username = 'Andrey'
  user.password = 'password'
end

User.find_or_create_by(email: 'andryuh2a@mail.ru') do |user|
  user.username = 'Andryuh2a'
  user.password = 'password'
end

User.find_or_create_by(email: 'andrewtoms@mail.ru') do |user|
  user.username = 'Andrew Toms'
  user.password = 'password'
end

3.times do
  FactoryBot.create(:category)
end

all_categories = Category.all

10.times do
  user = User.all.sample
  categories = all_categories.sample(1 + rand(all_categories.count))
  FactoryBot.create(:question, user: user, categories: categories)
end

Question.all.each do |question|
  5.times do
    user = User.all.sample
    FactoryBot.create(:answer, user: user, repliable: question)
  end
end

100.times do
  repliable = Reply.all.sample
  comment_type = repliable.type == 'Answer' ? :for_answer : :for_comment
  user = User.all.sample

  FactoryBot.create(:comment, comment_type, user: user, repliable: repliable)
end
