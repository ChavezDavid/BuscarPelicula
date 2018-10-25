//
//  ListaPeliculasController.swift
//  BuscadorPeliculas
//
//  Created by Alumno on 25/10/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ListaPeliculasController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tvPeliculas: UITableView!
    @IBOutlet weak var txtPelicula: UITextField!
    
    var urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&s=god"
    var pelicula : String = ""
    var encontrada : String = ""
    
    @IBAction func doTapBuscar(_ sender: Any) {
        pelicula = txtPelicula.text!
        
        urlPelicula = "http://www.omdbapi.com/?apikey=f7ceca1b&s=god"
        
        if pelicula != "" {
            urlPelicula = "http://www.omdbapi.com/?apikey=f7ceca1b&s=\(pelicula)"
        }
        
        Alamofire.request(urlPelicula).responseJSON { response in
            if let dictRespuesta = response.result.value as? NSDictionary {
                if let respuesta = dictRespuesta.value(forKey: "Response") as? String {
                    self.encontrada = respuesta
                }
                if self.encontrada == "True" {
                    if let buscar = dictRespuesta.value(forKey: "Search") as? NSArray {
                        for i in buscar{
                            if let dictResultado = i as? NSDictionary{
                                var nombrePelicula : String = ""
                                var añoPelicula : String = ""
                                var idPelicula : String = ""
                                
                                if let nombre = dictResultado.value(forKey: "Title") as? String{
                                    nombrePelicula = nombre
                                }
                                if let año = dictResultado.value(forKey: "Year") as? String{
                                    añoPelicula = año
                                }
                                if let id = dictResultado.value(forKey: "imdbID") as? String{
                                    idPelicula = id
                                }
                                
                                DatosPeliculas.peliculas.append(Pelicula(nombre: nombrePelicula, id: idPelicula, año: añoPelicula, duracion: "", clasificacion: "", director: "", genero: ""))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
