class Tag < ApplicationRecord

  has_many :tag_maps, dependent: :destroy
  has_many :posts, through: :tag_maps

  # タグのランキング機能（週間ランキング）
  def self.create_ranks_tag
  # tag_week = Tag.where(created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday))
  # byebug
  # tag_week.find(TagMap.group(:tag_id).order('count(tag_id)desc').limit(3).pluck(:tag_id))

  tag_day = Tag.find(TagMap.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).group(:tag_id).order('count(tag_id)desc').limit(3).pluck(:tag_id))
  end
end
