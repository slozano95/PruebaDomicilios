//
//  ParadaMapa.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import MapKit
/**
 Clase que define el objeto que representa las paradas del mapa.
 */

class ParadaMapa: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let nombreParada: String?
    let imageURL:String?
    
    init(nombreParada:String, coordenadas: CLLocationCoordinate2D,imageURL:String) {
        self.nombreParada = nombreParada
        self.coordinate = coordenadas
        self.imageURL = imageURL
        super.init()
    }
}
