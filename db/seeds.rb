faith = User.create(first_name: "faith", diet_preference: "vegetarian")
mei = User.create(first_name: "mei", diet_preference: "vegetarian")
brittany = User.create(first_name: "brittany", diet_preference: "vegetarian")
buford = User.create(first_name: "buford", diet_preference: "non-vegetarian")
grant = User.create(first_name: "grant", diet_preference: "non-vegetarian")
heidi = User.create(first_name: "heidi", diet_preference: "vegetarian")
rachel = User.create(first_name: "rachel", diet_preference: "vegetarian")
mason = User.create(first_name: "mason", diet_preference: "non-vegetarian")
yinning = User.create(first_name: "yinning", diet_preference: "vegetarian")
adrian = User.create(first_name: "adrian", diet_preference: "non-vegetarian")

smoothie_ingredient1 = Recipe.create(name: "Smoothie", ingredient: "1 banana", cost: 0.5)
smoothie_ingredient2 = Recipe.create(name: "Smoothie", ingredient: "1 tbsp of honey", cost: 0.5)

Meal.create(user_id: mei.id, recipe_id: smoothie_ingredient1.id)
Meal.create(user_id: mei.id, recipe_id: smoothie_ingredient2.id)

