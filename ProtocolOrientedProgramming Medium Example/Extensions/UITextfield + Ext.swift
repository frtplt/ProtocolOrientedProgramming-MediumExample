//
//  UITextfield + Ext.swift
//  Matey
//
//  Created by Firat Polat on 30.08.2022.
//

import UIKit

extension UITextField {

    func textFieldCornerRadius() {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0
    }

    func textFieldLeftPadding() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
    }
}
