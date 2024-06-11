require "json"
require "open-uri"
require "roo"

puts 'cleaning'
GroceryListItem.destroy_all
GroceryList.destroy_all
PlannedMeal.destroy_all
User.destroy_all
Ingredient.destroy_all
RecipeIngredient.destroy_all
Recipe.destroy_all

puts "Starting to generate"
puts 'importing xlsx file'

latest_file = Dir[Rails.root.join('exports', '*.xlsx')].max_by { |f| File.mtime(f) }

# Generate each recipe in the first spreadsheet based on the schema
if latest_file

  workbook = Roo::Excelx.new(latest_file)

  puts "importing recipe"

  recipe_sheet = workbook.sheet(0)

  (2..recipe_sheet.last_row).each do |row|

    Recipe.create(
      title: recipe_sheet.cell(row, 2),
      category: recipe_sheet.cell(row, 3) ,
      description: recipe_sheet.cell(row, 4),
      instructions: recipe_sheet.cell(row, 5),
      total_time: recipe_sheet.cell(row, 6).to_i,
      servings: recipe_sheet.cell(row, 7).to_i,
      score: recipe_sheet.cell(row, 8).to_i,
      image: recipe_sheet.cell(row, 9),
      diet: recipe_sheet.cell(row, 10)
    )
  end


  ingredient_sheet = workbook.sheet(1)

  (2..ingredient_sheet.last_row).each do |row|

    i = Ingredient.new(
      name: ingredient_sheet.cell(row,2),
    )
    ingredient_sheet.cell(row,3) == "" ? i.aisle = "Common ingredients" : i.aisle = ingredient_sheet.cell(row,3)
    i.save!
  end

  ingredient_recipe_sheet = workbook.sheet(2)

  (2..ingredient_recipe_sheet.last_row).each do |row|
    new_recipe_ingredient = RecipeIngredient.new(
    )

    if ingredient_recipe_sheet.cell(row, 3) == 'Tbsps' || ingredient_recipe_sheet.cell(row, 3) == "Tbs" ||ingredient_recipe_sheet.cell(row, 3) == "Tbsp"
      new_recipe_ingredient.unit = "ml"
      new_recipe_ingredient.quantity = (ingredient_recipe_sheet.cell(row, 2)*15).ceil

    elsif ingredient_recipe_sheet.cell(row, 3) == "tsps" ||  ingredient_recipe_sheet.cell(row, 3) == "tsp"
      new_recipe_ingredient.unit = "ml"
      new_recipe_ingredient.quantity = (ingredient_recipe_sheet.cell(row, 2)*5).ceil

    elsif ingredient_recipe_sheet(row, 3) == "servings" || ingredient_recipe_sheet(ro w, 3) == "serving"
      new_recipe_ingredient.unit = "cups"
      new_recipe_ingredient.quantity = ingredient_recipe_sheet.cell(row, 2).ceil

    else
      new_recipe_ingredient.unit = ingredient_recipe_sheet.cell(row, 3)
      new_recipe_ingredient.quantity = ingredient_recipe_sheet.cell(row, 2)
    end
    recipe = Recipe.find_by(title: ingredient_recipe_sheet.cell(row,8))
    new_recipe_ingredient.recipe = recipe
    new_recipe_ingredient.recipe_title = recipe.title

    ingredient = Ingredient.find_by(name: ingredient_recipe_sheet.cell(row,9))
    new_recipe_ingredient.ingredient = ingredient
    new_recipe_ingredient.ingredient_name = ingredient.name

    new_recipe_ingredient.save!
  end

else
  puts "no file to be imported"
end
puts "done with excel"
puts 'Now Importing with the api'


array_of_ids = [
]

count = 0

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

  if data["cuisines"].join(" ") == ""
    recipe.category = "italian"
  else
    recipe.category = "#{data["cuisines"].join(", ")}"
  end

  if data["diets"].join(" ") == ""
    recipe.diet = "healthy"
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
    quantity: ingredient["measures"]["metric"]["amount"].ceil
  )


    recipe_ingredient.ingredient_id = ing.id
    recipe_ingredient.ingredient_name = ing.name


    recipe_ingredient.recipe_id = recipe.id
    recipe_ingredient.recipe_title = recipe.title
    recipe_ingredient.save
  end
  puts "one recipe done"
  count += 1
end

puts "You just generated #{count} recipes ;)"

puts 'generating a user'

user = User.new(username: "ObamaUSA", email: "obama@usa.com", password: "123456")
file = URI.open("https://openclipart.org/image/800px/313668")
user.photo.attach(io: file, content_type: "image/png", filename: "obama picture")

user.save!
date = Time.now
3.times do
  recipe = Recipe.all.sample
  PlannedMeal.create!(recipe: recipe, user: user, date: date)
end

puts "done :)"
