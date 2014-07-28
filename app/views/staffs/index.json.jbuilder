json.array!(@staffs) do |staff|
  json.extract! staff, :id, :isactive, :issuper, :isadmin
  json.url staff_url(staff, format: :json)
end
