module Api::V1
  class PassagesController < ApplicationController
    before_action :authenticate_request!

    def index
      @passages = Passage.order("created_at DESC")
      render json: @passages
    end

    def create
      @passage = Passage.new(passage_params)
      if @passage.save
        render json: @passage
      else
        render json: { errors: @passage.errors }, status: :bad_request
      end
    end

    private

    def passage_params
      params.require(:passage).permit(
        :departure_port,
        :arrival_port,
        :departure_date_time,
        :arrival_date_time,
        :description,
        :miles,
        :hours,
        :night_hours,
        :role,
        :overnight,
        :tidal,
        :ocean_passage
      )
    end
  end
end
