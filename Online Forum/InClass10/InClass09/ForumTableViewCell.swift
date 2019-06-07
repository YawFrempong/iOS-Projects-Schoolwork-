//
//  ForumTableViewCell.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 4/3/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit

protocol ForumTableViewCellDelegate {
    func deleteForum(cell: ForumTableViewCell)
    func selectForum(cell: ForumTableViewCell)
    func likeForum(cell: ForumTableViewCell)
}

class ForumTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    
    var delegate: ForumTableViewCellDelegate?
    var forumID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            delegate?.selectForum(cell: self)
            isSelected = false
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        delegate?.deleteForum(cell: self)
    }
    
    @IBAction func likeBtn(_ sender: Any) {
        delegate?.likeForum(cell: self)
    }
}
