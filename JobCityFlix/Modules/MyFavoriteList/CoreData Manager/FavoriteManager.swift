import CoreData

protocol FavoriteManagerProtocol {
    
    func save(showName: String, showId: Int, imageURL: String?)
    func fetch() -> [FavoriteEntity]
    func removeFavorite(with id: Int)
    func isFavorited(id: Int) -> Bool
}


final class FavoriteManager: FavoriteManagerProtocol {
    
    static let shared: FavoriteManager = FavoriteManager()
    
    private init() {}
                                
    func save(showName: String, showId: Int, imageURL: String?) {
        let desc = NSEntityDescription.entity(forEntityName: "FavoriteEntity", in: persistentContainer.viewContext)!
        let entity = FavoriteEntity(entity: desc, insertInto: persistentContainer.viewContext)
        entity.showId = Int32(showId)
        entity.imageURL = imageURL
        entity.showName = showName
        saveContext()
    }
    
    func fetch() -> [FavoriteEntity] {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let managedObjectContext = persistentContainer.viewContext
            
            guard let result = try managedObjectContext.fetch(request) as? [FavoriteEntity] else { return [] }
            return result
        } catch {
            return []
        }
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CoredataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func removeFavorite(with id: Int) {
        let managedObjectContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteEntity")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "showId = \(id)")
        
        if let result = try? managedObjectContext.fetch(request) {
            if result.count > 0 {
                if let favorite = result[0] as? FavoriteEntity {
                    managedObjectContext.delete(favorite)
                        try? managedObjectContext.save()
                }
            }
        }
    }
    
    func isFavorited(id: Int) -> Bool {
        let managedObjectContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteEntity")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "showId = \(id)")
        let result = try? managedObjectContext.fetch(request)
        return (result?.count ?? 0) > 0
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
