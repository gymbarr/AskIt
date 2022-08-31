RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  sequence :number do |n|
    n
  end

  sequence :string do |n|
    "string#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end
end
