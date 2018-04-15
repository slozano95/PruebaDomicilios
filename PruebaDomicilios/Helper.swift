//
//  Helper.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import Foundation
import UIKit

class Helper: NSObject {
    
    static var urlRutas = "https://api.myjson.com/bins/10yg1t"
    
    static let ColorBarraNavegacion:String = "05477F"
    static let ColorTextoBarraNavegacion:String = "FFF"
    
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
    static func setNavBarCustom(_ view:UIViewController,hideBackButton:Bool,texto:String){
        view.navigationItem.title = texto
        view.navigationItem.hidesBackButton = hideBackButton
        view.navigationController?.navigationBar.barTintColor = UIColor(hexString: Helper.ColorBarraNavegacion)
        view.navigationController!.navigationBar.tintColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        view.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
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
//Tomado de https://gist.github.com/KyleGoslan/cd84969ee6c247955741b4af2e6b5ee2
extension UIImageView {
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

//Tomado dehttps://gist.github.com/benhurott/d0ec9b3eac25b6325db32b8669196140
extension UIColor {
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
extension UIView{
    func addConstraintsWithFormat(format:String, views:UIView...){
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    func roundCorners(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func withBorder(borderWidth:CGFloat,borderColor:UIColor){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}
