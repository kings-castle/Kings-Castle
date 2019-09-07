require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

   factory :game do 
    white_player_id { "1" }
    black_player_id { "2" }
    game_id         { "3" }
  end

  factory :player do 
    player_id {|n| n} 
  end
end

# {|n| n}