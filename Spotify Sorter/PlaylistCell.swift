//
//  PlaylistCell.swift
//  Spotify Sorter
//
//  Created by CSUDH on 5/15/21.
//

import UIKit

class PlaylistCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UIView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var playlistImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
