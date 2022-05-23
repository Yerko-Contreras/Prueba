# frozen_string_literal: true

class ReviewsController < ApplicationController
    before_action :set_review, only: %i[show edit update destroy]

    # GET /reviews or /reviews.json
    def index
        return redirect_to new_user_session_url if current_user.nil?

        @reviews = Review.all
    end

    def mis_resenas
        @reviews = Review.all
    end

    # GET /reviews/1 or /reviews/1.json
    def show; end

    # GET /reviews/new
    def new
        return redirect_to new_user_session_url if current_user.nil?

        @user_id = params[:user_id]
        @receiver_id = params[:receiver_id]
        @review = Review.new
        @turno_id = params[:turno_id]
    end

    # GET /reviews/1/edit
    def edit; end

    # POST /reviews or /reviews.json
    def create
        return redirect_to new_user_session_url if current_user.nil?

        review_params[:user_id] = params[:user_id].to_i
        review_params[:receiver_id] = params[:receiver_id].to_i
        @review = Review.new(review_params)

        respond_to do |format|
            if @review.save
                format.html { redirect_to turnos_path, notice: 'Review was successfully created.' }
                format.json { render :show, status: :created, location: @review }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @review.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /reviews/1 or /reviews/1.json
    def update
        respond_to do |format|
            if @review.update(review_params)
                format.html { redirect_to turnos_path, notice: 'Review was successfully updated.' }
                format.json { render :show, status: :ok, location: @review }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @review.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /reviews/1 or /reviews/1.json
    def destroy
        @review.destroy

        respond_to do |format|
            if @review.user.admin
                format.html { redirect_to reviews_path, notice: 'Review was successfully destroyed.' }
            else
                format.html { redirect_to mis_resenas_path, notice: 'Review was successfully destroyed.' }
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_review
        @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
        params.require(:review).permit(:score, :content, :receiver_id, :user_id)
    end
end
