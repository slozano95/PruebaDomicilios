//
//  Stop.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 Clase que define el objeto que representa cada parada disponible.
 - Note: Ejemplo del texto en formato JSON esperado **{"lat": 4.678737,"lng": -74.066001}**
 */
class Stop{
    /**Latitud de la parada*/
    var lat:Double = 0.0
    /**Longitud de la parada*/
    var lng:Double = 0.0
}
