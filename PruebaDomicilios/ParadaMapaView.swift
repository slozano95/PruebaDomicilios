//
//  ParadaMapaView.swift
//  PruebaDomicilios
//
//  Created by Santiago on 13/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import MapKit
/**
 Clase que define el view que se utiliza para mostrar cada parada en el mapa.
 */
class ParadaMapaView: MKAnnotationView {
    /**Contenedor de la imagen de la parada*/
    public var imageView: UIImageView!
    /** Titulo de la parada*/
    public var titulo:UILabel!
 
    /**init annotation*/
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: 80, height: 60)
        self.backgroundColor = UIColor(hexString: Helper.ColorBarraNavegacion)
        self.roundCorners(radius: 10)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.imageView = UIImageView()
        self.titulo = UILabel()
        self.titulo.text = "Parada #"
        self.titulo.textColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        self.titulo.font = UIFont(name: "Helvetica-Neue", size: 15)
        self.titulo.adjustsFontSizeToFitWidth = true
        self.titulo.minimumScaleFactor = 0.5
        self.titulo.textAlignment = .center
        self.addSubview(self.imageView)
        self.addSubview(self.titulo)
        self.addConstraintsWithFormat(format: "V:|-[v0(30)]-[v1(15)]-|", views: imageView,titulo)
        self.addConstraintsWithFormat(format: "H:|-25-[v0(30)]-25-|", views: imageView)
        self.addConstraintsWithFormat(format: "H:|-[v0]-|", views: titulo)
        self.imageView.layer.cornerRadius = 5.0
        self.imageView.layer.masksToBounds = true
    }
    /**Getter y setter de la imagen*/
    override var image: UIImage? {
        get{
            return self.imageView.image
        }
        set{
            self.imageView.image = newValue
        }
    }
    /**init*/
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
