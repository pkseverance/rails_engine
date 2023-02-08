require 'rails_helper'

RSpec.describe 'Items Endpoint' do
    describe 'Items Index' do
        it 'returns a JSON response containing a list of items and their attributes' do
            merchant = create(:merchant)
            create_list(:item, 10, merchant: merchant)

            get '/api/v1/items'
            expect(response).to(be_successful)

            items = JSON.parse(response.body, symbolize_names: true)
            expect(items[:data].count).to eq(10)

            items[:data].each do |item|
                expect(item).to have_key(:id)
                expect(item[:id]).to be_a(String)

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
                expect(item[:attributes][:merchant_id]).to eq(merchant.id)
            end
        end
    end

    describe 'Item Show' do
        it "returns a JSON response containing one item and it's attributes" do
            merchant = create(:merchant)
            item = create(:item, merchant: merchant)

            get "/api/v1/items/#{item.id}"
            expect(response).to(be_successful)

            item_response = JSON.parse(response.body, symbolize_names: true)
            expect(item_response.count).to eq(1)
            item_data = item_response[:data]

            expect(item_data).to have_key(:id)
            expect(item_data[:id]).to be_a(String)

            expect(item_data).to have_key(:type)
            expect(item_data[:type]).to eq('item')

            expect(item_data).to have_key(:attributes)
            
            expect(item_data[:attributes]).to have_key(:name)
            expect(item_data[:attributes][:name]).to be_a(String)

            expect(item_data[:attributes]).to have_key(:description)
            expect(item_data[:attributes][:description]).to be_a(String)

            expect(item_data[:attributes]).to have_key(:unit_price)
            expect(item_data[:attributes][:unit_price]).to be_a(Float)

            expect(item_data[:attributes]).to have_key(:merchant_id)
            expect(item_data[:attributes][:merchant_id]).to eq(merchant.id)
        end
    end
end