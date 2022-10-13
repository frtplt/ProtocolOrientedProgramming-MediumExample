//
//  HomeViewModel.swift
//  ProtocolOrientedProgramming Medium Example
//
//  Created by Firat Polat on 10.10.2022.
//

import Foundation

protocol HomeViewModelInterface: AnyObject {
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    func savePerson(fullname: String, phoneNumber: String)
    func notifyViewDidLoad()
    func fetchPeople() -> [Person]?
    func getPersonData(with index: Int) -> Person
    func deletePerson(id: UUID, indexpath: Int)
}

final class HomeViewModel {

    private weak var view: HomeViewControllerInterface?
    var coreDataManager: CoreDataManagerInterface?

    var people: [Person]?

    init(view: HomeViewControllerInterface?, coreDataManager: CoreDataManagerInterface? = CoreDataManager.shared) {
        self.view = view
        self.coreDataManager = coreDataManager
    }

    private func isValidTextFields(textFieldName: String, textFieldPhoneNumber: String) -> Bool {
        if textFieldName.isEmpty || !textFieldName.isValid(.name) {
            view?.showAlert(title: ConstantsHomeVC.messageWarning, message: ConstantsHomeVC.messagePersonNameNotValid)
            return false
        } else if textFieldPhoneNumber.isEmpty || !textFieldPhoneNumber.isValid(.phoneNumber) {
            view?.showAlert(title: ConstantsHomeVC.messageWarning, message: ConstantsHomeVC.messagePhoneNumberNotValid)
            return false
        }
        return true
    }
}

// MARK: - Interface Setup

extension HomeViewModel: HomeViewModelInterface {

    func fetchPeople() -> [Person]? {
        people = coreDataManager?.fetchPeople()
        return people
    }

    func notifyViewDidLoad() {
        fetchPeople()
        view?.setupUI()
    }

    func getPersonData(with index: Int) -> Person {
        people?[index] ?? Person()
    }

    var numberOfSections: Int {
        1
    }

    var numberOfRows: Int {
        people?.count ?? 0
    }

    func deletePerson(id: UUID, indexpath: Int) {
        people?.remove(at: indexpath)
        coreDataManager?.delete(id: id)
        self.view?.showAlert(title: ConstantsHomeVC.messagePersonDeleted, message: ConstantsHomeVC.messagePersonSuccessfullyDeleted)
        notifyViewDidLoad()
    }

    func savePerson(fullname: String, phoneNumber: String) {
        if isValidTextFields(textFieldName: fullname, textFieldPhoneNumber: phoneNumber) {
            coreDataManager?.insertPerson(fullname: fullname, phoneNumber: phoneNumber, id: UUID())
            self.view?.showAlert(title: ConstantsHomeVC.messagePersonSaved, message: ConstantsHomeVC.messagePersonSuccessfully)
            fetchPeople()
        }
        else {
            self.view?.showAlert(title: ConstantsHomeVC.messageError, message: ConstantsHomeVC.messageError)
        }
    }
}

