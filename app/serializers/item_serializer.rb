class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  def self.not_found
    {
      "data": 
      {
          "id": "nil",
          "attributes": []
      }
    }
  end
end
