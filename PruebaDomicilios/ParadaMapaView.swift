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
    
    public var imageView: UIImageView!
    public var label:UILabel!
 
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: 80, height: 60)
        self.backgroundColor = UIColor(hexString: Helper.ColorBarraNavegacion)
        self.roundCorners(radius: 10)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.imageView = UIImageView()
        self.label = UILabel()
        self.label.text = "Parada #"
        self.label.textColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        self.label.font = UIFont(name: "Helvetica-Neue", size: 15)
        self.label.adjustsFontSizeToFitWidth = true
        self.label.minimumScaleFactor = 0.5
        self.label.textAlignment = .center
        self.addSubview(self.imageView)
        self.addSubview(self.label)
        self.addConstraintsWithFormat(format: "V:|-[v0(30)]-[v1(15)]-|", views: imageView,label)
        self.addConstraintsWithFormat(format: "H:|-25-[v0(30)]-25-|", views: imageView)
        self.addConstraintsWithFormat(format: "H:|-[v0]-|", views: label)
        self.imageView.layer.cornerRadius = 5.0
        self.imageView.layer.masksToBounds = true
    }
    
    override var image: UIImage? {
        get{
            return self.imageView.image
        }
        set{
            self.imageView.image = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
