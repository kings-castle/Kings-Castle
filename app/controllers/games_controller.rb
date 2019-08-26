class GamesController < ApplicationController
	def index
	end

	def new
    @game = Game.new
	end

	def create
    @game = games.create(game_params)
	end

	def show
	end
end
