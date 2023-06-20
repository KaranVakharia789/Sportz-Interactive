//
//  PlayerCell.swift
//  Sportz-Interactive
//
//  Created by Karan Vakharia on 20/06/23.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var lblPlayer: UILabel!
    @IBOutlet weak var lblKipper: UILabel!
    @IBOutlet weak var lblCaptian: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
