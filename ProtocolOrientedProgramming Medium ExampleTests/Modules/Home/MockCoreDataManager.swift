//
//  MockCoreDataManager.swift
//  ProtocolOrientedProgramming Medium ExampleTests
//
//  Created by Firat Polat on 10.10.2022.
//

import CoreData
@testable import ProtocolOrientedProgramming_Medium_Example

final class MockCoreDataManager: CoreDataManagerInterface {

    var invokedPersistentContainerGetter = false
    var invokedPersistentContainerGetterCount = 0
    var stubbedPersistentContainer: NSPersistentContainer!

    var persistentContainer: NSPersistentContainer {
        invokedPersistentContainerGetter = true
        invokedPersistentContainerGetterCount += 1
        return stubbedPersistentContainer
    }

    var invokedSaveContext = false
    var invokedSaveContextCount = 0

    func saveContext() {
        invokedSaveContext = true
        invokedSaveContextCount += 1
    }

    var invokedInsertPerson = false
    var invokedInsertPersonCount = 0
    var invokedInsertPersonParameters: (fullname: String, phoneNumber: String, id: UUID)?
    var invokedInsertPersonParametersList = [(fullname: String, phoneNumber: String, id: UUID)]()
    var stubbedInsertPersonResult: Person!

    func insertPerson(fullname: String, phoneNumber: String, id: UUID) -> Person? {
        invokedInsertPerson = true
        invokedInsertPersonCount += 1
        invokedInsertPersonParameters = (fullname, phoneNumber, id)
        invokedInsertPersonParametersList.append((fullname, phoneNumber, id))
        return stubbedInsertPersonResult
    }

    var invokedFetchPeople = false
    var invokedFetchPeopleCount = 0
    var stubbedFetchPeopleResult: [Person]!

    func fetchPeople() -> [Person]? {
        invokedFetchPeople = true
        invokedFetchPeopleCount += 1
        return stubbedFetchPeopleResult
    }

    var invokedDelete = false
    var invokedDeleteCount = 0
    var invokedDeleteParameters: (id: UUID, Void)?
    var invokedDeleteParametersList = [(id: UUID, Void)]()
    var stubbedDeleteResult: [Person]!

    func delete(id: UUID) -> [Person]? {
        invokedDelete = true
        invokedDeleteCount += 1
        invokedDeleteParameters = (id, ())
        invokedDeleteParametersList.append((id, ()))
        return stubbedDeleteResult
    }
}
