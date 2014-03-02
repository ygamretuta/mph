class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_filter :authenticate_user!, except:[:show]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def profile
  end

  # GET '/edit_profile'
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @user = User.find(current_user.id)
      if  @user.update(user_params)
        format.html { redirect_to current_user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email)
    end
end
