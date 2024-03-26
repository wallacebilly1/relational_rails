class Team < ApplicationRecord
  has_many :players

  def player_count
    self.players.count
  end

  def self.order_by_created_at
    self.order(created_at: :desc)
  end
end