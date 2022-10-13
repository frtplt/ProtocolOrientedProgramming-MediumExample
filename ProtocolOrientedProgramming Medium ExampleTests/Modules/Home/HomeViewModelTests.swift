//
//  HomeViewModelTests.swift
//  ProtocolOrientedProgramming Medium ExampleTests
//
//  Created by Firat Polat on 10.10.2022.
//

import XCTest
@testable import ProtocolOrientedProgramming_Medium_Example

final class HomeViewModelTests: XCTestCase {

    private var viewModel: HomeViewModel!
    private var view: MockHomeViewController!
    private var coreDataManager: MockCoreDataManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = MockHomeViewController()
        coreDataManager = MockCoreDataManager()
        viewModel = HomeViewModel(view: view, coreDataManager: coreDataManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        view = nil
    }

    func test_viewDidLoad_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedSetupUI)
        XCTAssertFalse(coreDataManager.invokedFetchPeople)

        viewModel.notifyViewDidLoad()

        XCTAssertEqual(view.invokedSetupUICount, 1)
        XCTAssertEqual(coreDataManager.invokedFetchPeopleCount, 1)
    }

    func test_fetchPeople_InvokesFetchPeople() {
        XCTAssertFalse(coreDataManager.invokedFetchPeople)

        viewModel.fetchPeople()

        XCTAssertEqual(coreDataManager.invokedFetchPeopleCount, 1)
    }

    func test_savePerson_whenInputFalse() {
        XCTAssertFalse(view.invokedShowAlert)
        XCTAssertTrue(view.invokedShowAlertParametersList.isEmpty)

        viewModel.savePerson(fullname: "Test", phoneNumber: "Test")

        XCTAssertEqual(view.invokedShowAlertCount, 2)
        XCTAssertEqual(view.invokedShowAlertParameters.map(\.message), ConstantsHomeVC.messageError)
        XCTAssertEqual(view.invokedShowAlertParameters.map(\.title), ConstantsHomeVC.messageError)
    }

    func test_savePerson_whenInputTrue() {
        XCTAssertFalse(view.invokedShowAlert)
        XCTAssertTrue(view.invokedShowAlertParametersList.isEmpty)

        viewModel.savePerson(fullname: "Test", phoneNumber: "5334000000")

        XCTAssertEqual(view.invokedShowAlertCount, 1)
        XCTAssertEqual(view.invokedShowAlertParameters.map(\.message), ConstantsHomeVC.messagePersonSuccessfully)
        XCTAssertEqual(view.invokedShowAlertParameters.map(\.title), ConstantsHomeVC.messagePersonSaved)
    }

    func test_deletePerson_InvokesRequiredMethods() {
        XCTAssertFalse(coreDataManager.invokedDelete)
        XCTAssertFalse(view.invokedSetupUI)
        XCTAssertFalse(coreDataManager.invokedFetchPeople)
        XCTAssertTrue(view.invokedShowAlertParametersList.isEmpty)

        viewModel.deletePerson(id: UUID(), indexpath: 1)

        XCTAssertEqual(coreDataManager.invokedDeleteCount, 1)
        XCTAssertEqual(view.invokedSetupUICount, 1)
        XCTAssertEqual(coreDataManager.invokedFetchPeopleCount, 1)
        XCTAssertEqual(view.invokedShowAlertParameters.map(\.message), ConstantsHomeVC.messagePersonSuccessfullyDeleted)
        XCTAssertEqual(view.invokedShowAlertParameters.map(\.title), ConstantsHomeVC.messagePersonDeleted)
    }
}
