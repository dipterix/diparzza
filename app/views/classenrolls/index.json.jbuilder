json.array!(@classenrolls) do |classenroll|
  json.extract! classenroll, :id, :user_id, :classroom_id, :ista
  json.url classenroll_url(classenroll, format: :json)
end
