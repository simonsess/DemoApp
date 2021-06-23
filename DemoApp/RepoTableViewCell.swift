//
//  RepoTableViewCell.swift
//  DemoApp
//
//  Created by Simon Skalicky on 23/06/2021.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var modifyLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
