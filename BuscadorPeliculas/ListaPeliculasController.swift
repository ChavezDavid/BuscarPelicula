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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatosPeliculas.peliculas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "cellPelicula") as! CeldaPeliculaController
        celda.lblNombre.text = DatosPeliculas.peliculas[indexPath.row].nombre
        celda.lblAño.text = DatosPeliculas.peliculas[indexPath.row].año
        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func doTapBuscar(_ sender: Any) {
        pelicula = txtPelicula.text!
        
        urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&s=god"
        
        if pelicula != "" {
            urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&s=\(pelicula)"
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
                        self.tvPeliculas.reloadData()
                    }
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
