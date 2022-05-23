# frozen_string_literal: true

class RequestsController < ApplicationController
    before_action :set_request, only: %i[show edit update destroy]

    # GET /requests or /requests.json
    def index
        return redirect_to new_user_session_url if current_user.nil?

        @requests = Request.all
    end

    def usuario_requests
        return redirect_to new_user_session_url if current_user.nil?

        @requests = Request.where(turno_id: params[:turno][:id])
    end

    def my_requests
        return redirect_to new_user_session_url if current_user.nil?

        @requests = Request.where(current_user.id == :id)
    end

    # GET /requests/1 or /requests/1.json
    def show; end

    # GET /requests/new
    def new
        return redirect_to new_user_session_url if current_user.nil?

        @turno_id = params[:turno_id]
        @request = Request.new
    end

    # GET /requests/1/edit
    def edit; end

    # POST /requests or /requests.json
    def create
        return redirect_to new_user_session_url if current_user.nil?

        request_params[:turno_id] = params[:turno_id].to_i
        @request = Request.new(request_params)
        @request.user = current_user
        respond_to do |format|
            if @request.save
                format.html { redirect_to request_url(@request), notice: 'Request was successfully created.' }
                format.json { render :show, status: :created, location: @request }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @request.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /requests/1 or /requests/1.json
    def update
        respond_to do |format|
            if @request.update(request_params)
                format.html { redirect_to request_url(@request), notice: 'Request was successfully updated.' }
                format.json { render :show, status: :ok, location: @request }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @request.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /requests/1 or /requests/1.json
    def destroy
        @request.destroy

        respond_to do |format|
            if @request.user.admin
                format.html { redirect_to requests_path, notice: 'Request was successfully destroyed.' }
            else
                format.html do
                    redirect_to homepages_path,
                                notice: 'Request was successfully deleted.'
                end
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_request
        @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
        params.require(:request).permit(:description, :turno_id, :user_id)
    end
end
