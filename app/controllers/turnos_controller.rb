# frozen_string_literal: true

class TurnosController < ApplicationController
    before_action :set_turno, only: %i[show edit update destroy]

    # GET /turnos or /turnos.json
    def index
        @turnos = Turno.all
    end

    # GET /turnos/1 or /turnos/1.json
    def show
        return redirect_to new_user_session_url if current_user.nil?
    end

    # GET /turnos/new
    def new
        return redirect_to new_user_session_url if current_user.nil?
        return redirect_to turnos_url if current_user.banned

        @turno = Turno.new
    end

    def turnos_inscribed
        return redirect_to new_user_session_url if current_user.nil?

        @turnos = Turno.all
    end

    # GET /turnos/1/edit
    def edit
        return redirect_to new_user_session_url if current_user.nil?
    end

    def add_member
        return redirect_to new_user_session_url if current_user.nil?

        @turno = Turno.find(params[:parametros][:turno].to_i)
        @new_member = User.find(params[:parametros][:new_member].to_i)
        @request = Request.find(params[:parametros][:request].to_i)
        @turno.users << @new_member
        @turno.update_attribute(:cupos_ocupados, @turno.cupos_ocupados + 1)
        @request.destroy
        redirect_to turnos_path
    end

    def remove_member
        return redirect_to new_user_session_url if current_user.nil?

        @turno = Turno.find(params[:parametros][:turno].to_i)
        @member = User.find(params[:parametros][:member].to_i)
        @turno.users.delete(@member)
        @turno.update_attribute(:cupos_ocupados, @turno.cupos_ocupados - 1)
        redirect_to turnos_url
    end

    # POST /turnos or /turnos.json
    def create
        return redirect_to new_user_session_url if current_user.nil?

        @turno = Turno.new(turno_params)
        @turno.owner = current_user
        @turno.users << User.find(current_user.id)

        respond_to do |format|
            if @turno.save
                format.html { redirect_to turno_url(@turno), notice: 'Turno was successfully created.' }
                format.json { render :show, status: :created, location: @turno }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @turno.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /turnos/1 or /turnos/1.json
    def update
        return redirect_to new_user_session_url if current_user.nil?

        respond_to do |format|
            if @turno.update(turno_params)
                format.html { redirect_to turno_url(@turno), notice: 'Turno was successfully updated.' }
                format.json { render :show, status: :ok, location: @turno }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @turno.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /turnos/1 or /turnos/1.json
    def destroy
        return redirect_to new_user_session_url if current_user.nil?

        @turno.users.each do |user|
            @turno.users.delete(user)
        end
        @turno.destroy

        respond_to do |format|
            format.html { redirect_to turnos_url, notice: 'Turno was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_turno
        @turno = Turno.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turno_params
        params.require(:turno).permit(:address_in, :address_out, :capacity, :route, :day, :hour, :inscribed)
    end
end
