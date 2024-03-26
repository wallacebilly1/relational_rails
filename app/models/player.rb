class Player < ApplicationRecord
  belongs_to :team

  def self.international_only
    self.where(international: true)
  end

  def self.sort_alpha
    self.order(:name)
  end

  def self.filter_older_than_age(years)
    self.where("age > #{years}")
  end
end