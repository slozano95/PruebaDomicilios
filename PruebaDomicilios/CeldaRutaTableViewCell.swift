//
//  CeldaRutaTableViewCell.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import UIKit
/**
 Clase que define la celda que se utiliza para mostrar los datos de la lista de rutas.
 */
class CeldaRutaTableViewCell: UITableViewCell {
    /**Nombre de la ruta*/
    @IBOutlet weak var nameRuta:UILabel!
    
    /**Descripcion de la ruta*/
    @IBOutlet weak var descriptionRuta:UILabel!
    
    /**Imagen de la ruta*/
    @IBOutlet weak var imagenRuta:UIImageView!
    
    /**Se asignan los colores a los IBOutlets*/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameRuta.textColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        descriptionRuta.textColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        self.backgroundColor = UIColor(hexString: Helper.ColorBarraNavegacion)
    }
    
    /**setSelected*/
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
