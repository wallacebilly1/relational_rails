class Player < ApplicationRecord
  belongs_to :team

  def self.international_only
    self.where(international: true)
  end
end