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
