//
//  CeldaRutaTableViewCell.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import UIKit

class CeldaRutaTableViewCell: UITableViewCell {
    @IBOutlet weak var nameRuta:UILabel!
    @IBOutlet weak var descriptionRuta:UILabel!
    @IBOutlet weak var imagenRuta:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
