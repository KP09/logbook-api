module Api::V1
  class PassagesController < ApplicationController
    def index
      @passages = Passage.order("created_at DESC")
      render json: @passages
    end

    def create
      @passage = Passage.create!(passage_params)
      render json: @passage
    end

    private

    def passage_params
      params.require(:passage).permit(:departure_port,
        :arrival_port, :departure_date, :arrival_date, :description, :miles,
        :hours, :night_hours, :role, :overnight, :tidal, :ocean_passage)
    end
  end
end
