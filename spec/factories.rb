FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

 factory :game do 
    white_player_id {|n| n}
    black_player_id {|n| n}
    game_id         {|n| n}
  end

 factory :player do 
  player_id {|n| n}
 end

end