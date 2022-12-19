class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index 
        render json: Scientist.all, each_serializer: ScientistOnlySerializer, status: :ok
    end

    def show 
        scientist = Scientist.find(params[:id])
        render json: scientist, status: :ok
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, serializer: ScientistOnlySerializer, status: :created
    end

    def update 
        scientist = Scientist.find(params[:id])
        scientist.update!(scientist_params)
        render json: scientist, status: :accepted
    end

    def destroy 
        Scientist.find(params[:id]).destroy
        head :no_content
    end

    private

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_record_not_found
        render json: {error: "Scientist not found"}, status: :not_found
    end

    # def render_unprocessable_entity(invalid)
    #     render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    # end

    #Lindsay's error formatting - with custom serializer
    def render_unprocessable_entity(invalid) 
        render json: {errors: ErrorMessageSerializer.error_messages(invalid.record.errors)}, status: :unprocessable_entity
    end


end
