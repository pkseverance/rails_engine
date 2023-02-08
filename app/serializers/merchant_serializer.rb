class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

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
