class Api::V1::ItemsController < ApplicationController
    def index
        render json: ItemSerializer.new(Item.all)
    end

    def show
        if Item.where(id: params[:id]).exists?
            render json: ItemSerializer.new(Item.find(params[:id]))
        else
            render json: ItemSerializer.not_found,
            status: 404
        end
    end
end