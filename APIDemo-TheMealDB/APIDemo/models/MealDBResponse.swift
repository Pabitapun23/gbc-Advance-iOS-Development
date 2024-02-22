import Foundation
// In this example we demonstrate how to update the
// default API property names to our own custom values
struct Recipe: Codable{
    // property names you want to keep
    var idMeal:String
    // property names to rename
    var recipeName:String          // should correspond to strMeal in API
    var recipeType:String      // should correspond to strCategory in API
    var instructions:String  // should correspond to strInstructions in API
    var image:String     // should correspond to strMealThumb in API
    
    // CodingKeys is used to match the default API property name
    // to your new name
    enum CodingKeys:String, CodingKey {
        // properties in the recipe
        // properties you want to rename
        case recipeName = "strMeal"
        case recipeType = "strCategory"
        case instructions = "strInstructions"
        case image = "strMealThumb"
        // properties you want to keep the same
        case idMeal
    }
}
struct MealsReponseObj:Decodable {
    var meals:[Recipe]
}
