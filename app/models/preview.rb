class Preview < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :post_id , uniqueness: { scope: :user_id }

  def self.create_preview(post_id, current_user_id)
    current_preview = Preview.find_by(user_id: current_user_id, post_id: post_id)

    if current_preview.blank?
      preview = Preview.new(
        user_id: current_user_id,
        post_id: post_id
        )
      preview.save if preview.valid?
    else
      current_preview.touch
    end
  end
end
