if @favorite.persisted?
  json.form render(partial: "favorites/form", formats: [:html])
end
