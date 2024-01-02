# frozen_string_literal: true

class LocalTrain < ApplicationRecord
  belongs_to :yard
  has_many :customers
end
