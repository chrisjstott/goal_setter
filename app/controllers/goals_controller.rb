class GoalsController < ApplicationController

  before_action :require_logged_in, only: [:create, :new, :edit, :update, :destroy]

  def index
    goals = Goal.all
    public_goals = goals.where(privacy: :public)
    if logged_in?
      users_private_goals = goals.where(privacy: :private, user_id: current_user.id)
    else
      users_private_goals = []
    end
    @goals_shown = public_goals + users_private_goals
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.status = "incomplete"
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    Goal.find(params[:id]).destroy
    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:content, :privacy, :status)
  end

end
