class Users::PlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @plan = Plan.new
    @plans = current_user.plans
    plans_post_ids = current_user.plans.where(start_time: nil).pluck(:post_id)
    @posts_new = Post.where(id: plans_post_ids, type: 1).order(created_at: :desc)
    plans_post_done_ids = current_user.plans.where.not(start_time: nil).pluck(:post_id)
    @posts_done = Post.where(id: plans_post_done_ids, type: 1).order(created_at: :desc)
    @notification_plans = Plan.where(user_id: current_user.id, start_time: Time.zone.now.end_of_day..Time.current.weeks_since(1))
  end

  def create
    plan = Plan.new(plan_params)
    plan_check = current_user.plans.find_by(user_id: plan.user_id, post_id: plan.post_id)
    if plan.start_time.blank?
      flash[:notice] = "※日付を設定してください"
      redirect_to plans_path
    else
      if plan_check.present?
        plan_check.destroy
        plan.save
      else
        plan.save
      end
      redirect_to plans_path
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:start_time, :post_id, :user_id)
  end
end
