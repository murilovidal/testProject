class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :comments, autosave: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
 end
