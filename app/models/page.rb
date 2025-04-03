class Page < ApplicationRecord
  belongs_to :notebook
  validate :title, presence: true
  validate :content, presence: true
end
