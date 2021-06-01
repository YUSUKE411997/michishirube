class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  
  attachment :profile_image

  validates :name, presence: true

  def active_for_authentication?   #ログイン時にバリデーションを足したい場合(今回退会済みのユーザーを弾く)
    super && (self.is_valid == true)
  end
end
