//
//  ParadaMapa.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import MapKit
class ParadaMapa: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let nombreParada: String?
    
    init(nombreParada:String, coordenadas: CLLocationCoordinate2D) {
        self.nombreParada = nombreParada
        self.coordinate = coordenadas
        super.init()
    }
}
