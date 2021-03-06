//
//  Ruta.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 Clase que define el objeto que representa cada ruta disponible.
 - Note: Ejemplo del texto en formato JSON esperado **{"id": 1001,"name": "Ruta 01","description": "Colegio Colombia","stops_url": "https://api.myjson.com/bins/do6kx","img_url": "https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Bus-128.png"}**
 */
class Ruta{
    /**ID de la ruta*/
    var id:Int = 0
    /**Nombre de la ruta*/
    var name:String = ""
    /**Descripcion de la ruta*/
    var description:String = ""
    /**URL de las paradas de la ruta*/
    var stops_url:String = ""
    /**URL de la imagen de la ruta*/
    var img_url:String = ""
}
