module Api::V1
  class PassagesController < ApplicationController
    def index
      @passages = Passage.all
      render json: @passages
    end
  end
end
