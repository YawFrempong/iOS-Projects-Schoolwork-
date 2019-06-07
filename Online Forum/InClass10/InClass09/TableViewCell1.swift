//
//  TableViewCell1.swift
//  InClass09
//
//  Created by Frempong, Yaw on 4/8/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit

protocol TableViewCell1Delegate {
    func deleteComment(cell: TableViewCell1)
    func selectComment(cell: TableViewCell1)
}

class TableViewCell1: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rubbishButton: UIButton!
    
    
    var delegate: TableViewCell1Delegate?
    var commentID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            delegate?.selectComment(cell: self)
            isSelected = false
        }
    }
    
    @IBAction func rubbishBtn(_ sender: Any) {
        delegate?.deleteComment(cell: self)
    }
}
