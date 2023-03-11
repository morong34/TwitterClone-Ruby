# frozen_string_literal: true

class UserNamesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user_name, only: %i[ show edit update destroy ]
  skip_before_action :redirect_to_username_form

  # GET /user_names or /user_names.json
  def index
    @user_names = UserName.all
  end

  # GET /user_names/1 or /user_names/1.json
  def show; end

  # GET /user_names/new
  def new
    # @user_name = UserName.new
  end

  # GET /user_names/1/edit
  def edit; end

  # POST /user_names or /user_names.json
  def create
    @user_name = UserName.new(user_name_params)

    respond_to do |format|
      if @user_name.save
        format.html { redirect_to user_name_url(@user_name), notice: 'User name was successfully created.' }
        format.json { render :show, status: :created, location: @user_name }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_names/1 or /user_names/1.json
  def update
    if user_name_params[:username].present? && current_user.update(user_name_params)
      flash[:notice] = 'Username successful updated'
      redirect_to dashboard_path
    else
      flash[:alert] = if user_name_params[:username].blank?
                        'Please insert a username'
                      else
                        current_user.errors.full_messages.join(', ')
                      end
      redirect_to new_user_name_path
    end
  end

  # DELETE /user_names/1 or /user_names/1.json
  def destroy
    @user_name.destroy

    respond_to do |format|
      format.html { redirect_to user_names_url, notice: 'User name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_user_name
  #   @user_name = UserName.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def user_name_params
    params.require(:user).permit(:username)
  end
end
