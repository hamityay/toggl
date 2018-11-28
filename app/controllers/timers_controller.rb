class TimersController < ApplicationController
  before_action :check_user
  before_action :check_admin, only: :reports
  before_action :set_timer, only: [:show, :edit, :update, :destroy]

  # GET /timers
  # GET /timers.json
  def index
    @timers = Timer.all
  end

  # GET /timers/1
  # GET /timers/1.json
  def show
  end

  # GET /timers/new
  def new
    @timer = Timer.new
  end

  # GET /timers/1/edit
  def edit
  end

  # POST /timers
  # POST /timers.json
  def create
    @timer = Timer.new(timer_params)
    @timer.user_id = current_user.id

    respond_to do |format|
      if @timer.save
        format.html { redirect_to timers_path, notice: 'Timer was successfully created.' }
        format.json { render :show, status: :created, location: @timer }
      else
        format.html { render :new }
        format.json { render json: @timer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timers/1
  # PATCH/PUT /timers/1.json
  def update
    respond_to do |format|
      if @timer.update(timer_params)
        format.html { redirect_to @timer, notice: 'Timer was successfully updated.' }
        format.json { render :show, status: :ok, location: @timer }
      else
        format.html { render :edit }
        format.json { render json: @timer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timers/1
  # DELETE /timers/1.json
  def destroy
    @timer.destroy
    respond_to do |format|
      format.html { redirect_to timers_url, notice: 'Timer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def insight
    @user_time= current_user.timers.pluck(:duration).sum
    total_time = Timer.all.pluck(:duration).sum
    @user_percentage = ((@user_time / total_time) * 100).round 2
    types = current_user.timers.group(:type).sum(:duration)
    types = types.sort_by {|_key, value| _key}.reverse.to_h
    @types_rate = {}
    types.keys.each do |type|
      @types_rate[type.name] = ((types[type] / @user_time) * 100).round 2
    end
    all_types = Timer.all.group(:type).sum(:duration)
    all_types = all_types.sort_by {|_key, value| _key}.reverse.to_h
    @all_types_rate = {}
    all_types.keys.each do |type|
      @all_types_rate[type.name] = ((all_types[type] / total_time) * 100).round 2
    end
  end

  def reports

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timer
      @timer = Timer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timer_params
      params.require(:timer).permit(:info, :start, :finish, :type_id, :user_id)
    end

  def check_user
    unless user_signed_in?
      redirect_to new_user_registration_path, alert: "Before to access this page, you shuld sign up."
    end
  end

  def check_admin
    unless current_user.is_admin
      redirect_to timers_path, notice: "You do not have a permission to access this page."
    end
  end
end
