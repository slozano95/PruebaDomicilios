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
import SwiftSpinner
import CoreLocation

/**
 Clase que controla la interacción de la vista de detalles de ruta.
 - Note: la variable RutaSeleccionada se debe asignar desde el prepare del segue que invoca esta clase
*/

class DetalleRutaViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    var RutaSeleccionada:Ruta!
    var listaStops:[Stop] = []
    var locationManager: CLLocationManager!
    
    var nombreRuta:UILabel = UILabel()
    var descripcionRuta:UILabel = UILabel()
    var imagenRuta:UIImageView = UIImageView()
    var viewSuperior:UIView = UIView()
    var ultimaParada:String = ""
    
    @IBOutlet weak var mapa:MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        Helper.setNavBarCustom(self, hideBackButton: false, texto: "Detalles de Ruta")
        getDatos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSuperior.frame = CGRect(x: 10, y: -100, width: self.mapa.frame.width-20, height:100)
        viewSuperior.backgroundColor = UIColor(hexString: Helper.ColorBarraNavegacion)
        viewSuperior.roundCorners(radius: 10)
        viewSuperior.layer.borderColor = UIColor.white.cgColor
        viewSuperior.layer.borderWidth = 2
        view.addSubview(viewSuperior)
        
        nombreRuta.text = RutaSeleccionada.name
        nombreRuta.textColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        nombreRuta.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        nombreRuta.adjustsFontSizeToFitWidth = true
        nombreRuta.minimumScaleFactor = 0.5
        viewSuperior.addSubview(nombreRuta)
        
        descripcionRuta.text = RutaSeleccionada.description
        descripcionRuta.textColor = UIColor(hexString: Helper.ColorTextoBarraNavegacion)
        descripcionRuta.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        descripcionRuta.adjustsFontSizeToFitWidth = true
        descripcionRuta.minimumScaleFactor = 0.5
        viewSuperior.addSubview(descripcionRuta)
        
        imagenRuta.fromURL(urlString: RutaSeleccionada.img_url)
        viewSuperior.addSubview(imagenRuta)
        
        viewSuperior.addConstraintsWithFormat(format: "V:|-15-[v0(70)]-15-|", views: imagenRuta)
        viewSuperior.addConstraintsWithFormat(format: "V:|-15-[v0(30)]-5-[v1]", views: nombreRuta,descripcionRuta)
        viewSuperior.addConstraintsWithFormat(format: "H:|-10-[v0(70)]-[v1]-|", views: imagenRuta,nombreRuta)
        viewSuperior.addConstraintsWithFormat(format: "H:|-10-[v0]-[v1]-|", views: imagenRuta,descripcionRuta)
        
        self.mapa.isRotateEnabled = true
        self.mapa.showsUserLocation = true
        self.mapa.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        UIView.animate(withDuration: 1.5) {
            self.viewSuperior.frame = CGRect(x: 10, y: 100, width: self.mapa.frame.width-20, height:100)
        }
    }
    
    /**
     # getDatos
     Mediante Alamofire se genera la petición get a la url obtenida desde el objeto recibido por el segue invocado en la tabla de ViewControllerse espera recibir texto en formato JSON, se decodifica utilizando SwiftyJSON y se carga en memoria local.
     Se utiliza SwiftSpinner para mostrar views de carga de datos y errores, permite hacer mejor la UX.
 
     - Requires: Alamofire, SwiftyJSON, SwiftySpinner
     - SeeAlso: mostrarStops()
     - SeeAlso: crearRuta()
     */
    func getDatos(){
        SwiftSpinner.show("Cargando Datos...")
        self.listaStops.removeAll()
        Alamofire.request(RutaSeleccionada.stops_url).responseJSON{ response in
            if let data = response.data, let text = String(data: data, encoding: .utf8){
                if(response.response?.statusCode == 200){
                    let json = JSON(data: response.data!)
                    for (_,value):(String,JSON) in json["stops"]{
                        var stop:Stop = Stop()
                        stop.lat = value["lat"].double!
                        stop.lng = value["lng"].double!
                        self.listaStops.append(stop)
                    }
                    self.mostrarStops()
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
    /**
     # mostrarStops
     Se obtienen las coordenadas a partir de las paradas cargados en memoria, se añaden al mapa mediante la cola principal de UI.
     Se define ultimaParada para animarla en crearRuta
     - SeeAlso: crearRuta()
     */
    func mostrarStops(){
        var contador = 1
        for stop in listaStops {
            let parada = ParadaMapa(nombreParada: "Parada \(contador)",
                coordenadas: CLLocationCoordinate2D(latitude: stop.lat, longitude: stop.lng),imageURL:RutaSeleccionada.img_url)
            DispatchQueue.main.async {
                self.mapa.addAnnotation(parada)
            }
            contador += 1
        }
        let tamañoRegionCentrada: CLLocationDistance = 200
        let regionCentrada = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: listaStops[contador-2].lat, longitude: listaStops[contador-2].lng),tamañoRegionCentrada, tamañoRegionCentrada)
        ultimaParada = "Parada \(contador-1)"
        self.mapa.setRegion(regionCentrada, animated: true)
        crearRuta()
    }
    
    func crearRuta(){
        var coords:[CLLocationCoordinate2D] = []
        for puntos in listaStops{
            var coord = CLLocationCoordinate2D(latitude: puntos.lat, longitude: puntos.lng)
            coords.append(coord)
        }
        let linea = MKPolyline(coordinates: coords, count: coords.count)
        mapa.add(linea)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        if !annotation.isKind(of: ParadaMapa.self){
            var pinAnnotationView = mapa.dequeueReusableAnnotationView(withIdentifier: "DefaultPinView")
            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "DefaultPinView")
            }
            return pinAnnotationView
        }
        var viewParada: ParadaMapaView? = mapa.dequeueReusableAnnotationView(withIdentifier: "Parada") as? ParadaMapaView
        if viewParada == nil {
            viewParada = ParadaMapaView(annotation: annotation, reuseIdentifier: "Parada")
        }
        let annotation = annotation as! ParadaMapa
        viewParada?.imageView.fromURL(urlString: RutaSeleccionada.img_url)
        viewParada?.label.text = annotation.nombreParada
        if(annotation.nombreParada == ultimaParada){
            Helper.pulzo(view: viewParada!, duration: 0.8, start: 0.8, end: 1, autoreverse: true, repeatCount: 500)
        }
        viewParada?.annotation = annotation
        return viewParada
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let testlineRenderer = MKPolylineRenderer(polyline: polyline)
            testlineRenderer.strokeColor = UIColor(hexString: Helper.ColorBarraNavegacion)
            testlineRenderer.lineWidth = 2.0
            return testlineRenderer
        }
        return MKPolylineRenderer()
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
