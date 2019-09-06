class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #set association between games and users
  has_many :games
  has_many :pieces

  # after_create :create_player

  # private

  # def create_player
  #   Player.create(email: self.email, password: self.password)
  # end
end
