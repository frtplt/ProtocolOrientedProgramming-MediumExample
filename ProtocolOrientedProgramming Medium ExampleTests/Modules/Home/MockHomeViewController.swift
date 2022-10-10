//
//  MockHomeViewController.swift
//  ProtocolOrientedProgramming Medium ExampleTests
//
//  Created by Firat Polat on 10.10.2022.
//

@testable import ProtocolOrientedProgramming_Medium_Example

final class MockHomeViewController: HomeViewControllerInterface {

    var invokedSetupUI = false
    var invokedSetupUICount = 0

    func setupUI() {
        invokedSetupUI = true
        invokedSetupUICount += 1
    }

    var invokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedShowAlertParameters: (title: String, message: String)?
    var invokedShowAlertParametersList = [(title: String, message: String)]()

    func showAlert(title: String, message: String) {
        invokedShowAlert = true
        invokedShowAlertCount += 1
        invokedShowAlertParameters = (title, message)
        invokedShowAlertParametersList.append((title, message))
    }
}
