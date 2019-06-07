//
//  ForumPostTableViewCell.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 4/8/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit

protocol ForumPostTableViewCellDelegate {
    func likeForum(cell: ForumPostTableViewCell)
}

class ForumPostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var delegate: ForumPostTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeBtn(_ sender: Any) {
        delegate?.likeForum(cell: self)
    }
}
