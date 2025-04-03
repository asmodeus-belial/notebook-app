class Notebook < ApplicationRecord
  has_many :pages, dependent: :destroy
  validates :title, presence: true
end
