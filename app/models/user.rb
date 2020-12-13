class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  has_and_belongs_to_many :comments, autosave: true
 end
