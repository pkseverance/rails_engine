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

    def create
        if Item.create(item_params).valid?
            render json: ItemSerializer.new(Item.create(item_params)),
            status: 201
        else
            render status: 422
        end
    end

    def update
        item = Item.find(params[:id])
        if item.update(item_params)
            render json: ItemSerializer.new(item)
        else
            render status: 400
        end
    end

    def destroy
        begin
            Item.find(params[:id]).destroy
        rescue StandardError => error
            render json: error,
            status: 404
        end
    end

    private
    
    def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end