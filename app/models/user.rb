class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :planned_meals, dependent: :destroy
  has_many :grocery_lists, dependent: :destroy

  has_one_attached :photo

  validates :username, presence: true, uniqueness: true

  validate :correct_photo_mime_type

  private

  def correct_photo_mime_type
    if photo.attached? && !photo.content_type.in?(%w(image/jpeg image/png image/gif))
      errors.add(:photo, 'must be a JPEG, PNG, or GIF')
    end
  end
end
