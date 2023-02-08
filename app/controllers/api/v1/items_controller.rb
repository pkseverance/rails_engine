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

    def destroy
        @item = Item.find(params[:id])
        destroy_invoice_items
        @item.destroy
    end

    private
    
    def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end

    def destroy_invoice_items
        @item.invoice_items.each do |invoice_item|
            invoice_item.destroy if invoice_item.item == @item
        end
    end
end