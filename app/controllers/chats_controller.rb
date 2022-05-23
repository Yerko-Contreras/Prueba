# frozen_string_literal: true

class ChatsController < ApplicationController
    before_action :set_chat, only: %i[show edit update destroy]

    # GET /chats or /chats.json
    def index
        return redirect_to new_user_session_url if current_user.nil?

        @chats = Chat.all
    end

    # GET /chats/1 or /chats/1.json
    def show; end

    # GET /chats/new
    def new
        return redirect_to new_user_session_url if current_user.nil?

        @chat = Chat.new
    end

    def chat_room
        @turno = Turno.find_by(id: params[:turno][:id])
        @chats = Chat.where(turno_id: params[:turno][:id])
    end

    # GET /chats/1/edit
    def edit; end

    # POST /chats or /chats.json
    def create
        return redirect_to new_user_session_url if current_user.nil?

        chat_params[:turno_id] = params[:chat][:turno_id].to_i
        chat_params[:turno_id] = params[:chat][:turno_id].to_i
        @chat = Chat.new(chat_params)
        respond_to do |format|
            if @chat.save
                if @chat.user.admin
                    format.html { redirect_to chat_room_path(turno: { id: @chat.turno.id }) }
                else
                    format.html do
                        redirect_to chat_room_path(turno: { id: @chat.turno.id }),
                                    notice: 'Chat was successfully created.'
                    end
                end
                format.json { render :show, status: :created, location: @chat }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @chat.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /chats/1 or /chats/1.json
    def update
        respond_to do |format|
            if @chat.update(chat_params)
                format.html do
                    redirect_to chat_room_path(turno: { id: @chat.turno.id }),
                                notice: 'Chat was successfully updated.'
                end
                format.json { render :show, status: :ok, location: @chat }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @chat.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /chats/1 or /chats/1.json
    def destroy
        @chat.destroy

        respond_to do |format|
            format.html do
                redirect_to chat_room_path(turno: { id: @chat.turno.id }),
                            notice: 'Chat was successfully destroyed.'
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_chat
        @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
        params.require(:chat).permit(:content, :turno_id, :user_id)
    end
end
