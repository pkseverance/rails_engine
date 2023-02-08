class Api::V1::MerchantsController < ApplicationController
    def index
        render json: MerchantSerializer.new(Merchant.all)
    end

    def show
        render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end

    def items
        render json: ItemSerializer.new(Merchant.find(params[:id]).items)
    end
end