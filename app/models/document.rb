class Document < ApplicationRecord
  has_one :paper
  has_one :schedule
end
