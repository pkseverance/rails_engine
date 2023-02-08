require 'rails_helper'

RSpec.describe 'Merchants API' do
    describe 'Merchants Index' do

        it 'returns a list of merchants' do
            create_list(:merchant, 10)

            get '/api/v1/merchants'

            expect(response).to(be_successful)

            merchants = JSON.parse(response.body, symbolize_names: true)

            expect(merchants[:data].count).to eq(10)

            merchants[:data].each do |merchant|
                expect(merchant).to have_key(:id)
                expect(merchant[:id].to_i).to be_an(Integer)

                expect(merchant).to have_key(:type)
                expect(merchant[:type]).to eq('merchant')

                expect(merchant).to have_key(:attributes)
                expect(merchant[:attributes]).to have_key(:name)
                expect(merchant[:attributes][:name]).to be_a(String)
            end
        end
    end

    describe 'Merchant Show' do
        it 'returns a merchant by id' do
            id = create(:merchant).id

            get "/api/v1/merchants/#{id}"

            expect(response).to(be_successful)

            merchant = JSON.parse(response.body, symbolize_names: true)

            expect(merchant.count).to eq(1)

            merchant_data = merchant[:data]

            expect(merchant_data).to have_key(:id)
            expect(merchant_data[:id].to_i).to be_an(Integer)
            expect(merchant_data).to have_key(:type)
            expect(merchant_data).to have_key(:attributes)
            expect(merchant_data[:attributes]).to have_key(:name)
            expect(merchant_data[:attributes][:name]).to be_a(String)
        end
    end

    describe 'Merchant Items Index' do
        it "returns a merchant's items" do
            merchant = create(:merchant)
            
            create_list(:item, 10, merchant: merchant)

            get "/api/v1/merchants/#{merchant.id}/items"

            merchant_items = JSON.parse(response.body, symbolize_names: true)

            expect(response).to(be_successful)
            
            merchant_items[:data].each do |item|
                expect(item).to have_key(:id)
                expect(item[:id].to_i).to be_an(Integer)

                expect(item).to have_key(:type)
                expect(item[:type]).to eq('item')

                expect(item).to have_key(:attributes)
                expect(item[:attributes]).to have_key(:name)
                expect(item[:attributes][:name]).to be_a(String)

                expect(item[:attributes]).to have_key(:description)
                expect(item[:attributes][:description]).to be_a(String)

                expect(item[:attributes]).to have_key(:unit_price)
                expect(item[:attributes][:unit_price]).to be_a(Float)
                
                expect(item[:attributes]).to have_key(:merchant_id)
                expect(item[:attributes][:merchant_id]).to be_an(Integer)

                expect(item[:attributes]).to have_key(:merchant_id)
                expect(item[:attributes][:merchant_id]).to eq(merchant.id)
            end
        end
    end
end