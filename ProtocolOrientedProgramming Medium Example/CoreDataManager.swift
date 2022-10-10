//
//  CoreDataManager.swift
//  ProtocolOrientedProgramming Medium Example
//
//  Created by Firat Polat on 10.10.2022.
//

import CoreData

protocol CoreDataManagerInterface: AnyObject {
    func saveContext()
    func insertPerson(fullname: String, phoneNumber: String, id: UUID) -> Person?
    func fetchPeople() -> [Person]?
    func delete(id: UUID) -> [Person]?
}

final class CoreDataManager: CoreDataManagerInterface {

    static let shared = CoreDataManager()

    var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ProtocolOrientedProgramming_Medium_Example")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
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

    func insertPerson(fullname: String, phoneNumber: String, id: UUID) -> Person? {

        let managedContext = persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                      in: managedContext) else { return Person() }

        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)

        person.setValue(fullname, forKeyPath: "fullname")
        person.setValue(phoneNumber, forKeyPath: "phoneNumber")
        person.setValue(id, forKeyPath: "id")

        //  You commit your changes to person and save to disk by calling save on the managed object context. Note save can throw an error, which is why you call it using the try keyword within a do-catch block.

        do {
            try managedContext.save()
            return person as? Person
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }

    func fetchPeople() -> [Person]? {
        /*Before you can do anything with Core Data, you need a managed object context. */
        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [Person]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }

    func delete(id: UUID) -> [Person]? {
        /*get reference to appdelegate file*/

        /*get reference of managed object context*/
        let managedContext = persistentContainer.viewContext

        /*init fetch request*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")

        /*pass your condition with NSPredicate. We only want to delete those records which match our condition*/
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,id as CVarArg)
        do {

            /*managedContext.fetch(fetchRequest) will return array of person objects [personObjects]*/
            let item = try managedContext.fetch(fetchRequest)
            var arrRemovedPeople = [Person]()
            for person in item {

                /*call delete method(aManagedObjectInstance)*/
                /*here i is managed object instance*/
                managedContext.delete(person)

                /*finally save the contexts*/
                try managedContext.save()

                /*update your array also*/
                arrRemovedPeople.append(person as? Person ?? Person())
            }
            return arrRemovedPeople

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}

