class Page < ApplicationRecord
  belongs_to :notebook
  validates :title, presence: true
  validates :context, presence: true
end
