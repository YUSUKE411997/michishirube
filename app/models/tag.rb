class Tag < ApplicationRecord

  has_many :tag_maps, dependent: :destroy
  has_many :posts, through: :tag_maps
  
  validates :tag_name, uniqueness: true

  # タグのランキング機能（週間ランキング）
  def self.create_ranks_tag
  Tag.find(TagMap.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).group(:tag_id).limit(10).order('count(tag_id)desc').pluck(:tag_id))
  end

end
