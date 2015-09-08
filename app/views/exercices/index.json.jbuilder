json.array!(@exercices) do |exercice|
  json.extract! exercice, :id, :name
  json.url exercice_url(exercice, format: :json)
end
