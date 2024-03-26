class Player < ApplicationRecord
  belongs_to :team

  # def international_only
  #   self.where(international: true)
  # end
end