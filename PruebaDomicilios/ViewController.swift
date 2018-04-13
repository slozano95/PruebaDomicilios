//
//  ViewController.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var listaRutas:[Ruta] = []
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getDatos(){
        print("OBTENIENDO RUTAS")
        Alamofire.request("https://api.myjson.com/bins/10yg1t").responseJSON{ response in
            if let data = response.data, let text = String(data: data, encoding: .utf8){
                if(response.response?.statusCode == 200){
                    print("\tPARSING JSON")
                    let json = JSON(data: response.data!)
                    for (_,value):(String,JSON) in json["school_buses"]{
                        var ruta:Ruta = Ruta()
                        ruta.id = value["id"].int!
                        ruta.name = value["name"].string!
                        ruta.description = value["description"].string!
                        ruta.img_url = value["img_url"].string!
                        ruta.stops_url = value["stops_url"].string!
                        self.listaRutas.append(ruta)
                    }
                    self.tableView.reloadData()
                }else{
//                    Helper.anerrorocurred_pleasetryagainlater()
                }
            }else{
//                Helper.anerrorocurred_pleasetryagainlater()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("CONTEO RUTAS \(self.listaRutas.count)")
        return self.listaRutas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaRuta", for: indexPath) as! CeldaRutaTableViewCell
        cell.nameRuta.text = listaRutas[indexPath.row].name
        cell.descriptionRuta.text = listaRutas[indexPath.row].description
        return cell
    }
}

