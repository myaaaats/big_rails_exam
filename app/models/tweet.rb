class Tweet < ApplicationRecord
  validates :content, presence: true
  validates :content,    length: { in: 1..75 }
  has_many :favorites, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
end
