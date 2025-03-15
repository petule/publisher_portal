class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :publisher, optional: true
  enum :role, { user: 0, data_master: 1, owner: 2, publisher_admin: 3, admin: 4 }, default: :user, suffix: true

end
