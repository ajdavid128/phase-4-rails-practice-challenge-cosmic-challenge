class MissionsController < ApplicationController
    # rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def create 
        mission = Mission.create!(mission_params)
        render json: mission, serializer: CreateMissionPlanetDataSerializer, status: :created
    end

    private

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end

    # def render_record_not_found
    #     render json: {error: "Mission not found"}, status: :not_found
    # end

    def render_unprocessable_entity(invalid) 
        render json: {errors: ErrorMessageSerializer.error_messages(invalid.record.errors)}, status: :unprocessable_entity
    end

end
