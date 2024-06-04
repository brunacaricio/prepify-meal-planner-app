require "json"
require "open-uri"

puts "Starting to generate"



array_of_ids =[
  642539,663050,663357,651190,635657,67308,639234,639167,649850,647501,663659,663638,663588
]




array_of_ids.each do |id|
  api_key = ENV['SPOONACULAR_API_KEY']
  base_url= "https://api.spoonacular.com/recipes/#{id}/information?apiKey=#{api_key}&includeNutrition=true."

  recipe_serialized = URI.open(base_url).read
  data = JSON.parse(recipe_serialized)


  recipe = Recipe.new(
    title: data["title"],
    description: data["summary"],
    instructions: data["instructions"],
    total_time: data["readyInMinutes"],
    servings: data["servings"],
    image: data["image"],
    score: data["spoonacularScore"].floor
  )

  if data["cuisines"].nil?
    recipe.category = ""
  else
    recipe.category = data["cuisines"].join(", ")
  end

  if data["diets"].nil?
    recipe.diet = ""
  else
    recipe.diet = data["diets"].join(", ")
  end

  recipe.save

  data["extendedIngredients"].each do |ingredient|

    if Ingredient.exists?(name: ingredient["nameClean"])
      ing = Ingredient.find_by(name: ingredient["nameClean"])
    else
      ing = Ingredient.create!(
          name: ingredient["nameClean"],
          aisle: ingredient["aisle"]
        )
    end

  recipe_ingredient = RecipeIngredient.new(
    unit: ingredient["measures"]["metric"]["unitShort"],
    quantity: ingredient["measures"]["metric"]["amount"].to_i
  )


    recipe_ingredient.ingredient_id = ing.id
    recipe_ingredient.recipe_id = recipe.id
    recipe_ingredient.save
  end
  puts "one recipe done"
end

puts "done :)"
