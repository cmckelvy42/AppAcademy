class ArtworkSharesController < ApplicationController

    def create
        artwork_share = ArtworkShare.new(artwork_share_params)
        if artwork_share.save
            render json: artwork_share, status: :created
        else
            render json: artwork_share.errors.full_messages, status: :unprocessable_entity
        end
    end


    def destroy
        artwork_share = ArtworkShare.find(params[:id])
        if artwork_share.destroy
            render json: artwork_share
        else
            render json artwork_share.errors.full_messages, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render plain: "artwork_share not found!"
    end

    def artwork_share_params
        params.require(:artwork_share).permit(:artwork_id, :viewer_id)
    end
end