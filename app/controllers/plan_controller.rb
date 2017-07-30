class PlanController < ApplicationController
  def index
    @plans = current_user.plans
  end

  def show
    if params[:id].to_s == "plan_add" then
      user = current_user
      z = PlansUsers.create(user_id: user.id, plan_id: params[:pid])
      # redirect_to Plan.find(params[:id])
      @plan = z.plan
      redirect_to @plan
    else
      @plan = Plan.find_by_id(params[:id])
    end
  end

  def plan_add

  end

  def create
  end

  def new
    @plan = Plan.new
  end
end
