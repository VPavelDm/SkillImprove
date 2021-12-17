//
//  Persistence.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    private let modelName = "Skillmprove"
    let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Skillmprove")
        mainContext = container.viewContext
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            seedCoreDataContainerIfFirstLaunch()
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

extension PersistenceController {
    func seedCoreDataContainerIfFirstLaunch() {
        
        let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
        if !previouslyLaunched {
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
            
            let directory = NSPersistentContainer.defaultDirectoryURL()
            let url = directory.appendingPathComponent(modelName + ".sqlite")
            
            // 1: Copying the SQLite file
            let seededDatabaseURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite")!
            _ = try? FileManager.default.removeItem(at: url)
            do {
                try FileManager.default.copyItem(at: seededDatabaseURL, to: url)
            } catch let nserror as NSError {
                fatalError("Error: \(nserror.localizedDescription)")
            }
            
            // 2: Copying the SHM file
            let seededSHMURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite-shm")!
            let shmURL = directory.appendingPathComponent(modelName + ".sqlite-shm")
            _ = try? FileManager.default.removeItem(at: shmURL)
            do {
                try FileManager.default.copyItem(at: seededSHMURL, to: shmURL)
            } catch let nserror as NSError {
                fatalError("Error: \(nserror.localizedDescription)")
            }
            
            // 3: Copying the WAL file
            let seededWALURL = Bundle.main.url(forResource: modelName, withExtension: "sqlite-wal")!
            let walURL = directory.appendingPathComponent(modelName + ".sqlite-wal")
            _ = try? FileManager.default.removeItem(at: walURL)
            do {
                try FileManager.default.copyItem(at: seededWALURL, to: walURL)
            } catch let nserror as NSError {
                fatalError("Error: \(nserror.localizedDescription)")
            }
            
        }
    }
    
}
