class Branch < ApplicationRecord
  has_one :address
  has_many :books

  has_many :users
end
