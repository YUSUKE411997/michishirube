class Users::TimelinesController < ApplicationController

  def index
    @timelines = Timeline.timeline_posts(current_user)

  end
end
