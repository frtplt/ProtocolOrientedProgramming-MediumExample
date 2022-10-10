//
//  HomeViewController.swift
//  ProtocolOrientedProgramming Medium Example
//
//  Created by Firat Polat on 10.10.2022.
//

import UIKit

protocol HomeViewControllerInterface: AnyObject {
    func setupUI()
    func showAlert(title: String, message: String)
}

final class HomeViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak private var textFieldName: UITextField!
    @IBOutlet weak private var textFieldPhoneNumber: UITextField!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var buttonSave: UIButton!

    // MARK: - Properties
    private var viewModel: HomeViewModelInterface!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(view: self)
        viewModel.notifyViewDidLoad()
    }

    @IBAction func saveButtonAction() {
        savePerson()
        setupTextFieldEmpty()
        tableView.reloadData()
    }

    // MARK: - Setup textfields empty func

    private func setupTextFieldEmpty() {
        textFieldName.text = ""
        textFieldPhoneNumber.text = ""
    }

    func savePerson() {
        guard let textFieldName = textFieldName.text, let textFieldPhoneNumber = textFieldPhoneNumber.text else { return self.showAlert(title: ConstantsHomeVC.messageCouldntSave, message: ConstantsHomeVC.messageFillLines)}

        viewModel?.textFieldName = textFieldName
        viewModel?.textFieldPhoneNumber = textFieldPhoneNumber

        viewModel?.savePerson(fullname: textFieldName, phoneNumber: textFieldPhoneNumber)
    }
}

//Interface Setup

extension HomeViewController: HomeViewControllerInterface {
    func setupUI() {
        textFieldName.placeholder = ConstantsHomeVC.textFieldFullnamePlaceHolderText
        textFieldName.textFieldCornerRadius()
        textFieldName.textFieldLeftPadding()
        textFieldPhoneNumber.placeholder = ConstantsHomeVC.textFieldPhoneNumberPlaceHolderText
        textFieldPhoneNumber.textFieldCornerRadius()
        textFieldPhoneNumber.textFieldLeftPadding()
        tableView.register(UINib(nibName: ConstantsHomeVC.personCellIdentifier, bundle: nil), forCellReuseIdentifier: ConstantsHomeVC.personCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        buttonSave.setTitle(ConstantsHomeVC.saveButtonTitleText, for: .normal)
        buttonSave.backgroundColor = ConstantsHomeVC.saveButtonBackgroundColor
        buttonSave.setTitleColor(ConstantsHomeVC.saveButtonTitleColor, for: .normal)
        buttonSave.layer.cornerRadius = ConstantsHomeVC.saveButtonCornerRadius
    }

    func showAlert(title: String, message: String) {
        self.showAlertExt(title: title, message: message)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ConstantsHomeVC.personCellHeight
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonCell else { return UITableViewCell() }

        let person = viewModel.getPersonData(with: indexPath.row)
        cell.configure(with: person)

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let person = viewModel.getPersonData(with: indexPath.row)

        if editingStyle == .delete {
            viewModel.deletePerson(id: person.id!, indexpath: indexPath.row)
            tableView.reloadData()
        }
    }
}


