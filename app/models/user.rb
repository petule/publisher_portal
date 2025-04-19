class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :publisher, optional: true
  enum :role, { user: 0, data_master: 1, owner: 2, publisher_admin: 3, admin: 4 }, default: :user, suffix: true
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :publisher_id, presence: true, unless: :admin_role?

  scope :by_role, ->(role) { where(role: role) }
  scope :ordered_by, ->(column, direction = 'asc') {
    allowed_columns = column_names.map(&:to_s) # Získá seznam povolených sloupců

    column = allowed_columns.include?(column.to_s) ? column.to_sym : 'id' # Ověření sloupce
    direction = %w[asc desc].include?(direction) ? direction : 'asc' # Ověření směru

    order(column => Arel.sql(direction)) # Použití Arel.sql() jen pro směrování
  }
  scope :search, ->(query) {
    left_joins(:publisher)
      .where("LOWER(first_name) LIKE unaccent(:query) OR LOWER(last_name) LIKE unaccent(:query) OR LOWER(users.email) LIKE unaccent(:query) OR LOWER(publishers.title) LIKE unaccent(:query)", query: "%#{query.downcase}%")
  }
end
