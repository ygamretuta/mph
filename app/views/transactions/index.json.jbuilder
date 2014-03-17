json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :seller_id_id, :buyer_id_id, :item_id_id
  json.url transaction_url(transaction, format: :json)
end
