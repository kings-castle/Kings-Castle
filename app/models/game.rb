class Game < ApplicationRecord

  # attr_accessor :id 

  after_create :populate_game  #### Added by Matt Arrick -- 8/30/19

  has_many :players 
  has_many :pieces

  #set association between games and users
  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User', optional: true

  #define a scope so when Games.available is called, a player will only get games with 1 seat open
  scope :available, -> { where(players <2)}

  #define a scope that sets user_id equal to the currently logged in user id
  #scope :available_games, -> { where(user_id == User.current_user.id)}

  #sort available games for user to join
  #call using Game.available_games(user_id)
  def self.available_games(user)
    #for all games with black_player_id of nil and white_player_id of user_id
    #store in array
    #executes all at db level
    #if there is a user available
    if user
      #return a query to sort games where black_player_id is nil and white_player_id is not equal to the user
      where("black_player_id = ? or white_player_id != ?", nil, user)
    #if there is not a user
    else
      #return a query to sort games where black_player_id is nil
      where("black_player_id = ?", nil)
    end
  end

  private
#### Method populate_game
#### Added by Matt Arrick -- 8/30/19

  def populate_game             # Create white pieces and place them in thier inital space
    # Create White Pawns
    (0..7).each do |i|
      Pawn.create(
        piece_type: 'Pawn',
        x_pos: i,         # -- iterate through each space occupied by a pawn (0-7)
        y_pos: 1,         # -- all white pawns start on second row (row 1)
        color: true,      # -- true value means "white" as defined by color_name method in piece controller
        game_id: self.id,
        player_id: self.white_player_id, 
        image: "/assets/pawnw.gif"
        )
    end

    # Create White Rooks -- coordinates are corners on the first row (0,0 and 0,7)
    Rook.create(piece_type: 'Rook', x_pos: 0, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/rookw.gif")
    Rook.create(piece_type: 'Rook', x_pos: 7, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/rookw.gif")

    # Create White Knights -- coordinates are on the first row (0,1 and 0,6)
    Knight.create(piece_type: 'Knight', x_pos: 1, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/knightw.gif")
    Knight.create(piece_type: 'Knight', x_pos: 6, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/knightw.gif")

    # Create White Bishops -- coordinates are on the first row (0,2 and 0,5)
    Bishop.create(piece_type: 'Bishop', x_pos: 2, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/bishopw.gif")
    Bishop.create(piece_type: 'Bishop', x_pos: 5, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/bishopw.gif")

    # Create White Queen and King -- Queen coordinates are 0,3.  King coordinates are 0,4
    Queen.create(piece_type: 'Queen', x_pos: 3, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/queenw.gif")
    King.create(piece_type: 'King', x_pos: 4, y_pos: 0, color: true, game_id: self.id, player_id: self.white_player_id, image: "/assets/kingw.gif")

    # Create Black Pawns
    (0..7).each do |i|
      Pawn.create(
        piece_type: 'Pawn',
        x_pos: i,         # -- iterate through each space occupied by a pawn (0-7)
        y_pos: 6,         # -- all white pawns start on second to last row (row 6)
        color: false,     # -- false value means "black" as defined by color_name method in piece controller
        game_id: self.id,
        player_id: self.black_player_id, #Game.black_player_id
        image: "/assets/pawnb.gif"
        )
    end

    # Create Black Rooks -- coordinates are corners on the last row (7,0 and 7,7)
    Rook.create(piece_type: 'Rook', x_pos: 0, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/rookb.gif")
    Rook.create(piece_type: 'Rook', x_pos: 7, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/rookb.gif")

    # Create Black Knights -- coordinates are on the last row (7,1 and 7,6)
    Knight.create(piece_type: 'Knight', x_pos: 1, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/knightb.gif")
    Knight.create(piece_type: 'Knight', x_pos: 6, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/knightb.gif")

    # Create Black Bishops -- coordinates are on the last row (7,2 and 7,5)
    Bishop.create(piece_type: 'Bishop', x_pos: 2, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/bishopb.gif")
    Bishop.create(piece_type: 'Bishop', x_pos: 5, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/bishopb.gif")

    # Create Black Queen and King -- Queen coordinates are 7,3.  King coordinates are 7,4
    Queen.create(piece_type: 'Queen', x_pos: 3, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/queenb.gif")
    King.create(piece_type: 'King', x_pos: 4, y_pos: 7, color: false, game_id: self.id, player_id: self.black_player_id, image: "/assets/kingb.gif")

  end

  # #update the black_player_id to the current_user id
  # #this method is called in the games#update action
  # def self.assign_player(user)
  #   where(black_player_id: nil).update_all(black_player_id: user.id)
  # end
  
end

