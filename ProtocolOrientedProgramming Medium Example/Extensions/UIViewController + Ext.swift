//
//  UIViewController + Ext.swift
//  Matey
//
//  Created by Firat Polat on 30.08.2022.
//

import UIKit

extension UIViewController {

    //alert controller
    func showAlertExt(title: String?, message: String?, buttonName: String = "Done", completion: (()-> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: buttonName, style: UIAlertAction.Style.default) { (action) in
            completion?()
        }
        alertController.addAction(doneAction)
        alertController.view.tintColor = UIColor.black
        self.present(alertController, animated: true, completion: nil)
    }
}
