json.array!(@classannounces) do |classannounce|
  json.extract! classannounce, :id, :user_id, :classroom_id, :content
  json.url classannounce_url(classannounce, format: :json)
end
