//
//  ContactTableViewCell.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit

protocol ContactTableViewCellDelegate {
    func deleteContact(cell: ContactTableViewCell)
    func selectContact(cell: ContactTableViewCell)
}

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var delegate: ContactTableViewCellDelegate?
    var documentID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            delegate?.selectContact(cell: self)
            isSelected = false
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        delegate?.deleteContact(cell: self)
    }
}
