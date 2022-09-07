# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 10.times do
#   name = Faker::Hobby.activity
#   Category.create(name: name)
# end

# all_category_ids = Category.all.ids

# 10.times do
#   title = Faker::Hipster.sentence(word_count: 3)
#   body = Faker::Hipster.paragraph(sentence_count: 2)
#   user = User.all.sample

#   category_ids = all_category_ids.sample(1 + rand(all_category_ids.count))
#   Question.create(title: title, body: body, user: user, category_ids: category_ids)
# end

# Question.all.each do |question|
#   5.times do
#     answer = question.answers.build
#     answer.body = Faker::Hipster.sentence(word_count: 3)
#     answer.user = User.all.sample

#     answer.save
#   end
# end

# 20.times do
#   reply = Reply.all.sample
#   comment = reply.comments.build
#   comment.body = Faker::Hipster.sentence(word_count: 3)
#   comment.user = User.all.sample

#   comment.save
# end
