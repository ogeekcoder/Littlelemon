import Foundation
import CoreData

@MainActor
class MenuModel: ObservableObject {
    
    @Published var menuItems = [MenuItem]()
    
    func getMenuData(_ coreDataContext:NSManagedObjectContext) async {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(JSONMenu.self, from: data) {
                    DispatchQueue.main.async {
                        // update good data for UI in main thread
                        self.menuItems = decodedResponse.menuList
                        
                        Dish.deleteAll(coreDataContext)
                        Dish.createDishesFrom(menuItems: self.menuItems, coreDataContext)
                    }

                    // everything is good, so we can exit
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
