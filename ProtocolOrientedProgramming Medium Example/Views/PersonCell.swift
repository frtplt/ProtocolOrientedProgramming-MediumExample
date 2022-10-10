//
//  PersonCell.swift
//  ProtocolOrientedProgramming Medium Example
//
//  Created by Firat Polat on 10.10.2022.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with person: Person) {
        labelName.text = person.fullname
        labelName.textColor = .secondaryLabel
        labelPhoneNumber.text = person.phoneNumber

        selectionStyle = .none
    }
}
