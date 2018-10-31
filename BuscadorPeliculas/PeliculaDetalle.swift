//
//  PeliculaDetalle.swift
//  BuscadorPeliculas
//
//  Created by Alumno on 31/10/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PeliculaDetalle : UIViewController {
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblAño: UILabel!
    @IBOutlet weak var lblClasificacion: UILabel!
    @IBOutlet weak var lblDuracion: UILabel!
    @IBOutlet weak var lblGenero: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    
    var pelicula : Pelicula?
    
    var urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&t=god"
    var encontrada : String = ""
    
    override func viewDidLoad() {
        if pelicula != nil{
        urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&t=\(pelicula!.nombre)"
        }
        
        Alamofire.request(urlPelicula).responseJSON { response in
            if let dictRespuesta = response.result.value as? NSDictionary {
                if let respuesta = dictRespuesta.value(forKey: "Response") as? String {
                    self.encontrada = respuesta
                }
                if self.encontrada == "True" {
                    if let nombre = dictRespuesta.value(forKey: "Title") as? String {
                        self.lblNombre.text = nombre
                    }
                    if let año = dictRespuesta.value(forKey: "Year") as? String{
                        self.lblAño.text = año
                    }
                    if let clasificacion = dictRespuesta.value(forKey: "Rated") as? String{
                        self.lblClasificacion.text = clasificacion
                    }
                    if let duracion = dictRespuesta.value(forKey: "Runtime") as? String{
                        self.lblDuracion.text = duracion
                    }
                    if let genero = dictRespuesta.value(forKey: "Genre") as? String{
                        self.lblGenero.text = genero
                    }
                    if let director = dictRespuesta.value(forKey: "Director") as? String{
                        self.lblDirector.text = director
                    }
                }
            }
        }
    }
}
