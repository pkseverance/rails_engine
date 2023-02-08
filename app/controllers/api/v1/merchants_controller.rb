class Api::V1::MerchantsController < ApplicationController
    def index
        render json: MerchantSerializer.new(Merchant.all)
    end

    def show
        if Merchant.where(id: params[:id]).exists? 
            render json: MerchantSerializer.new(Merchant.find(params[:id]))
        else
            render json: MerchantSerializer.not_found,
            status: 404
        end
    end
end