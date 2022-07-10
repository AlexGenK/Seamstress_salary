class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true
  validates :team, presence: true

  def is_last_admin?
    (self.admin_role?) && (User.where(admin_role: true).count <= 1)
  end

  def self.get_worker_names
    User.where({worker_role: true}).order(:name).pluck(:name)
  end
end
