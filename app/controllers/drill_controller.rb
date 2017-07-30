class DrillController < ApplicationController
  def index
    @plans = current_user.plans
  end

  def show
    @drill = Drill.find(params[:id])
    @users = @drill.drill_users
    @plan = Plan.find_by_id(@drill.plan_id)
  end

  def finish
    @drill = Drill.find_by_id(params[:drill_id])
    DrillUsers.all.where(user_id: current_user.id, drill_id: @drill.id).first.end_time = DateTime.current
    # redirect_to drill(Drill.find_by_id(params[:drill_id]))
    redirect_to "drill/show?id=#{params[:drill_id]}"
  end

  def create
    drill = Drill.create(plan_id: params[:plan_id], start_time: DateTime.current)
    plan = Plan.find_by_id(params[:plan_id])
    plan.users.each do |user|
        DrillUsers.create(drill_id: drill.id, user_id: user.id)
    end
    redirect_to drill_show_path(id: drill.id)
  end
  
  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def drill_params
      params.require(:drill_id).permit(:drill_user_id)
    end
end
