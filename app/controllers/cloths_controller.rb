class ClothsController < ApplicationController
  before_action :set_cloth, only: [:show]

  # GET /cloths
  def index
    authorize :cloth, :index?
    @cloths = policy_scope(Cloth).order(updated_at: :desc)
  end

  # GET /cloths/1
  def show
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_cloth
      @cloth = Cloth.find(params[:id])
    	authorize @cloth
    end
end