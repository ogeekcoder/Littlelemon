import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var image: String?
    @NSManaged public var dishDescription: String?
    @NSManaged public var category: String?
}

extension Dish : Identifiable {
    
    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    static func save(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    class func readAll(_ context: NSManagedObjectContext) -> [Dish]? {
        let request = Dish.request()
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count > 0 else { return nil }
            return results
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
    }
    
    class func deleteAll(_ context: NSManagedObjectContext) {
        let request = Dish.request()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
            //save(context)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    static func exists(name: String, _ context: NSManagedObjectContext) -> Bool {
        let request = Dish.request()
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        request.predicate = predicate
        
        do {
            guard let result = try context.fetch(request) as? [Dish] else {
                return false
            }
            return result.count > 0
        } catch(let error) {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func createDishesFrom(menuItems: [MenuItem], _ context: NSManagedObjectContext) {
        for menuItem in menuItems {
            if !exists(name: menuItem.title, context) {
                let dishItem = Dish(context: context)
                dishItem.name = menuItem.title
                dishItem.price = menuItem.price
                dishItem.image = menuItem.image
                dishItem.dishDescription = menuItem.description
                dishItem.category = menuItem.category
            }
        }
      
    }
}
