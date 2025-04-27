//
//  FoodItem.swift
//  FoodTrackerApp
//
//  Created by Srivalli Kanchibotla on 4/25/25.
//

import Foundation


//https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json

struct FoodItem: Codable {
    let cuisine: String?
    let name: String
    let photo_url_large: String?
    let photo_url_small: String
    let source_url: String?
    let uuid: String
    let youtube_url: String?
}


//why do we write Codable here?
struct Recipes: Codable {
    let recipes: [FoodItem]
}
