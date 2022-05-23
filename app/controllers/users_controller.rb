# frozen_string_literal: true

class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    # GET /users or /users.json
    def index
        return redirect_to new_user_session_url unless current_user.admin

        @users = User.all
    end

    def ban_user
        @user = User.find_by(id: params[:user][:user_id].to_i)
        @user.banned = true
        @user.save
        @user.turnos.each(&:destroy)
        respond_to do |format|
            format.html { redirect_to users_url, notice: "Usuario Id:#{@user.id} baneado exitosamente" }
            format.json { head :no_content }
        end
    end

    def admin_user_reviews
        @reviews = Review.where(receiver_id: params[:user][:user_id].to_i)
    end

    def unban_user
        @user = User.find_by(id: params[:user][:user_id].to_i)
        @user.banned = false
        @user.save
        respond_to do |format|
            format.html { redirect_to users_url, notice: "Ban de usuario Id:#{@user.id} removido exitosamente" }
            format.json { head :no_content }
        end
    end

    # DELETE /users/1 or /users/1.json
    def destroy
        return redirect_to new_user_session_url unless current_user.admin

        @user_reviews = Review.where(receiver_id: @user.id.to_i)
        @user_reviews.each(&:destroy)

        turnos = Turno.where(user_id: @user)
        turnos.each(&:destroy)
        @user.destroy
        redirect_to users_path
        # @user.destroy

        # respond_to do |format|
        #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        #     format.json { head :no_content }
        # end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.fetch(:user, {})
    end
end
