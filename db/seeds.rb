# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

first_user = User.find_or_create_by(email: 'g-barr@mail.ru') do |user|
  user.username = 'Andrey'
  user.password = 'password'
end

unless first_user.has_role?(Role.admin_user_role)
  first_user.add_role(Role.admin_user_role)
  first_user.remove_role(Role.basic_user_role)
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

Question.all.each do |question|
  5.times do
<<<<<<< HEAD
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
=======
    answer = question.answers.build
    answer.body = Faker::Hipster.sentence(word_count: 3)
    answer.user = User.all.sample

    answer.save

    20.times do
      comment = Comment.new
      comment.repliable_id = answer.id
      comment.repliable_type = answer.type
      comment.type = 'Comment'
      comment.parent = comment.repliable
      comment.body = Faker::Hipster.sentence(word_count: 3)
      comment.user = User.all.sample

      comment.save
    end
  end
end
>>>>>>> 32c2b3a ( modify seeds, modify questions controller)
