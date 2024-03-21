class Team < ApplicationRecord
  has_many :players

  def player_count
    self.players.count
  end
end