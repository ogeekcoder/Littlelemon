import Foundation

struct JSONMenu: Codable {
    let menuList: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menuList = "menu"
    }
}
