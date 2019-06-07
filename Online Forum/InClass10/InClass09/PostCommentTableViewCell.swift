//
//  PostCommentTableViewCell.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 4/8/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit

protocol PostCommentTableViewCellDelegate {
    func postComment(cell: PostCommentTableViewCell)
}

class PostCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentField: UITextField!
    
    var delegate: PostCommentTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        delegate?.postComment(cell: self)
    }
}
