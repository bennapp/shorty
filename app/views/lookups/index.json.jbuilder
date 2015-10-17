json.array!(@lookups) do |lookup|
  json.extract! lookup, :id, :token, :url
  json.url lookup_url(lookup, format: :json)
end
