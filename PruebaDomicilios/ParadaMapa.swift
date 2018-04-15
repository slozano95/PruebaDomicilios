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
    /**Coordenada de la parada*/
    var coordinate: CLLocationCoordinate2D
    /**Nombre de la parada*/
    let nombreParada: String?
    /**Imagen de la parada*/
    let imageURL:String?
    /**init
     Inicializa la parada y asigna su nombre, coordenadas e imagen
     - Parameter nombreParada: nombre de la parada
     - Parameter coordenadas: coordenada de la parada
     - Parameter imageURL: URL de la imagen de la parada
     */
    init(nombreParada:String, coordenadas: CLLocationCoordinate2D,imageURL:String) {
        self.nombreParada = nombreParada
        self.coordinate = coordenadas
        self.imageURL = imageURL
        super.init()
    }
}
