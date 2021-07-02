class ArtworksController < ApplicationController
    def index
        if params[:user_id]
            render json: Artwork.artworks_for_user_id(params[:user_id])
        end
    end

    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork, status: :created
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        artwork = Artwork.find(params[:id])
        render json: artwork
    rescue ActiveRecord::RecordNotFound
        render plain: "artwork not found!"
    end

    def update
        artwork = Artwork.find(params[:id])
        
        if artwork.update(artwork_params)
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render plain: "artwork not found!"
    end

    def destroy
        artwork = Artwork.find(params[:id])
        title = artwork.title
        if artwork.destroy
            render plain: "#{title} has been deleted!"
        else
            render json artwork.errors.full_messages, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render plain: "artwork not found!"
    end

    def artwork_params
        params.require(:artwork).permit(:title, :artist_id, :image_url)
    end
end