//
//  Helper.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import Foundation
import UIKit
/**
Clase con variables y métodos estáticos reutilizables en toda la aplicación.
*/
class Helper: NSObject {
    
    static var urlRutas = "https://api.myjson.com/bins/10yg1t"
    
    static let ColorBarraNavegacion:String = "05477F"
    static let ColorTextoBarraNavegacion:String = "FFF"
    /**
     # setNavBar
     Permite definir la barra de navegación con una imagen, colores y tinte de la barra de navegación
     - Parameter view: ViewController sobre el cual se cargará la configuración de la barra de navegación
     - Parameter hideBackButton: booleano que define si se muestra o no el botón de navegación hacia atrás
     */
    static func setNavBar(_ view:UIViewController,hideBackButton:Bool){
        let imageView = UIImageView(image: UIImage(named: "logo_banner"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: 35))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        view.navigationItem.titleView = titleView
        view.navigationItem.hidesBackButton = hideBackButton
        view.navigationController!.navigationBar.barTintColor = UIColor(hexString: Helper.ColorBarraNavegacion)
    }
    /**
     # setNavBar
     Permite definir la barra de navegación con un texto, colores y tinte de la barra de navegación
     - Parameter view: ViewController sobre el cual se cargará la configuración de la barra de navegación
     - Parameter hideBackButton: booleano que define si se muestra o no el botón de navegación hacia atrás
     - Parameter texto: titulo que se mostrará en la barra de navegación
     */
    static func setNavBarCustom(_ view:UIViewController,hideBackButton:Bool,texto:String){
        view.navigationItem.title = texto
        view.navigationItem.hidesBackButton = hideBackButton
        view.navigationController?.navigationBar.barTintColor = UIColor(hexString: Helper.ColorBarraNavegacion)
        view.navigationController!.navigationBar.tintColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        view.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    /**
     # pulzo
     Permite dar animación de efecto pulzo sobre cualquier view.
     - Parameter view: View sobre el cual se generará la animación
     - Parameter duration: número de segundos que durará la animación
     - Parameter start: factor de escala inicail de la animación
     - Parameter end: factor de escala final de la animación
     - Parameter autoreverse: booleano que define si la animación se rebobina
     - Parameter repeatCount: número de veces que se repetirá la animación
     */
    static func pulzo(view: UIView,duration:Float,start:Float,end:Float,autoreverse:Bool,repeatCount:Float){
        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = CFTimeInterval(duration)
        pulseAnimation.fromValue = NSNumber(value: start)
        pulseAnimation.toValue = NSNumber(value: end)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = autoreverse
        pulseAnimation.repeatCount = repeatCount
        view.layer.add(pulseAnimation, forKey: "pulzo")
    }
}
/**
Extensión de UIImageView con método auxiliar
- Note: Tomado de https://gist.github.com/KyleGoslan/cd84969ee6c247955741b4af2e6b5ee2
*/
extension UIImageView {
    /**
     # fromURL
     Permite obtener una imagen desde una url de modo asincrono y cargarla en un UIImageView
     - Parameter urlString: url de la cual se obtendrá la imagen
     */
    public func fromURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil { return }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
/**
Extensión de UIColor con método auxiliar
- Note: Tomado de https://gist.github.com/benhurott/d0ec9b3eac25b6325db32b8669196140
 */
extension UIColor {
    /**
     # init
     Permite crear un UIColor a partir de su código de color en formato HEX
     - Parameter hexString: String del color en formato HEX
     */
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
/**
Extensión de UIView con métodos auxiliares
*/
extension UIView{
    /**
     # addConstraintsWithFormat
     Permite añadir constraints a views creados mediante código
     - Parameter format: formato base en que se definen los constraints
     - Parameter views: lista de views sobre los cuales se aplicarán los constraints
     */
    func addConstraintsWithFormat(format:String, views:UIView...){
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    /**
     # roundCorners
     Permite añadir esquinas redondeadas con un radio definido
     - Parameter radius: radio que se generará
     */
    func roundCorners(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    /**
     # withBorder
     Genera un borde sobre un view con un ancha y un color
     - Parameter borderWidth: ancho del borde
     - Parameter borderColor: color del borde
     */
    func withBorder(borderWidth:CGFloat,borderColor:UIColor){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    /**
     # roundCorners
     Permite cambiar la forma de cualquier view a forma circular
     */
    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}
