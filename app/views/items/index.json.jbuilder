json.array!(@items) do |item|
  json.extract! item, :id, :name, :ad_type, :description, :category_id, :price, :phone
  json.url item_url(item, format: :json)
end
