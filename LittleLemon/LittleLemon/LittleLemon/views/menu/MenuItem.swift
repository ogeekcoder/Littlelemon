import Foundation

struct MenuItem: Codable, Identifiable {
    let id = UUID()
    
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
}
