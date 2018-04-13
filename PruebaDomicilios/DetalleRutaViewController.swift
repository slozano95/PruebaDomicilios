//
//  DetalleRutaViewController.swift
//  PruebaDomicilios
//
//  Created by Santiago on 12/04/18.
//  Copyright © 2018 Craneatic. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class DetalleRutaViewController: UIViewController {

    var RutaSeleccionada:Ruta!
    var listaStops:[Stop] = []
    @IBOutlet weak var mapa:MKMapView!
    @IBOutlet weak var nombreRuta:UILabel!
    @IBOutlet weak var descripcionRuta:UILabel!
    @IBOutlet weak var imagenRuta:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreRuta.text = RutaSeleccionada.name
        descripcionRuta.text = RutaSeleccionada.description
        imagenRuta.fromURL(urlString: RutaSeleccionada.img_url)
        // Do any additional setup after loading the view.
        getDatos()
    }
    func getDatos(){
        print("OBTENIENDO DETALLES DE RUTA")
        Alamofire.request(RutaSeleccionada.stops_url).responseJSON{ response in
            if let data = response.data, let text = String(data: data, encoding: .utf8){
                if(response.response?.statusCode == 200){
                    print("\tPARSING JSON")
                    let json = JSON(data: response.data!)
                    for (_,value):(String,JSON) in json["stops"]{
                        var stop:Stop = Stop()
                        stop.lat = value["lat"].double!
                        stop.lng = value["lng"].double!
                        self.listaStops.append(stop)
                    }
                    self.mostrarStops()
                }else{
                    //TODO IMPLEMENTAR ERROR
                }
            }else{
                //TODO IMPLEMENTAR ERROR 
            }
        }
    }
    func mostrarStops(){
        var contador = 1
        for stop in listaStops {
            print("\(stop.lat),\(stop.lng)")
            let parada = ParadaMapa(nombreParada: "Parada \(contador)",
                coordenadas: CLLocationCoordinate2D(latitude: stop.lat, longitude: stop.lng))
            self.mapa.addAnnotation(parada)
            contador += 1
        }
        let tamañoRegionCentrada: CLLocationDistance = 1000
        let regionCentrada = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: listaStops[0].lat, longitude: listaStops[0].lng),tamañoRegionCentrada, tamañoRegionCentrada)
        self.mapa.setRegion(regionCentrada, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
