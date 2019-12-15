json.extract! recipe, :id, :title, :cuisine, :planning_to_cook_on, :tried_before, :instructions, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
