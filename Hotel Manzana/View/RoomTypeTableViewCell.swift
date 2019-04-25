//
//  RoomTypeTableViewCell.swift
//  Hotel Manzana
//
//  Created by Давид on 24/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

class RoomTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var typeRoomLabel: UILabel!
    @IBOutlet weak var priceRoomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
