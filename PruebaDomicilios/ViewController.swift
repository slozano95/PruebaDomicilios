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
import SwiftSpinner
/**
  Clase que controla la interacción de la vista que muestra la lista de rutas.
 */
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var listaRutas:[Ruta] = []
    var rutaSeleccionada:Ruta!
    
    @IBOutlet weak var tableView:UITableView!
    /* Previo a mostrar el view, se define la barra de navegación y se definen colores de la UI.
     - See also: Helper.setNavBar()*/
    override func viewWillAppear(_ animated: Bool) {
        Helper.setNavBar(self, hideBackButton: true)
        self.view.backgroundColor = UIColor(hexString: Helper.ColorBarraNavegacion)
        self.tableView.backgroundColor = UIColor(hexString: Helper.ColorBarraNavegacion)
        self.tableView.separatorColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        getDatos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    /**
     # getDatos
     Mediante Alamofire se genera la petición get a la url definida en Helper, se espera recibir texto en formato JSON, se decodifica utilizando SwiftyJSON y se carga en memoria local, se recarga la tabla para mostrar los datos si toda la operación fue exitosa.
     Se utiliza SwiftSpinner para mostrar views de carga de datos y errores, permite hacer mejor la UX.
     - Requires: Alamofire, SwiftyJSON, SwiftySpinner
     - SeeAlso: Helper.urlRutas
     */
 
    func getDatos(){
        SwiftSpinner.show("Cargando Datos...")
        self.listaRutas.removeAll()
        Alamofire.request(Helper.urlRutas).responseJSON{ response in
            if let data = response.data, let text = String(data: data, encoding: .utf8){
                if(response.response?.statusCode == 200){
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
                    SwiftSpinner.hide()
                }else{
                    SwiftSpinner.show("Error decodificando JSON.",animated:false).addTapHandler({
                        SwiftSpinner.hide()
                        self.getDatos()
                    })
                }
            }else{
                SwiftSpinner.show("Ha ocurrido un error en la comunicación con el servidor.",animated:false).addTapHandler({
                    SwiftSpinner.hide()
                    self.getDatos()
                })
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaRutas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaRuta", for: indexPath) as! CeldaRutaTableViewCell
        cell.nameRuta.text = listaRutas[indexPath.row].name
        cell.descriptionRuta.text = listaRutas[indexPath.row].description
        cell.imagenRuta.fromURL(urlString: listaRutas[indexPath.row].img_url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rutaSeleccionada = listaRutas[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "Segue_VerRuta", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Segue_VerRuta"){
            var viewDestino = segue.destination as! DetalleRutaViewController
            viewDestino.RutaSeleccionada = rutaSeleccionada
        }
    }
}

