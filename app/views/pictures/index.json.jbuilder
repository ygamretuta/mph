json.array!(@pictures) do |picture|
  json.extract! picture, :id, :item_id, :path
  json.url picture_url(picture, format: :json)
end
