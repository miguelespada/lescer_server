json.array!(@fruits) do |fruit|
  json.extract! fruit, :id, :texto
  json.url fruit_url(fruit, format: :json)
end
