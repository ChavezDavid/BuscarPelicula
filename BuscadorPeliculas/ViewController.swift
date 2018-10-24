//
//  ViewController.swift
//  BuscadorPeliculas
//
//  Created by Alumno on 24/10/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var txtPelicula: UITextField!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblAño: UILabel!
    @IBOutlet weak var lblClasificacion: UILabel!
    @IBOutlet weak var lblDuracion: UILabel!
    @IBOutlet weak var lblGenero: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var aiCargar: UIActivityIndicatorView!
    @IBOutlet weak var lblEncontrada: UILabel!
    
    var urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&t=i"
    var pelicula : String = ""
    var encontrada : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doTapBuscar(_ sender: Any) {
        aiCargar.startAnimating()
        
        pelicula = txtPelicula.text!
        
        urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&t=i"
        
        if pelicula != ""{
            urlPelicula = "https://www.omdbapi.com/?apikey=f7ceca1b&t=\(pelicula)"
        }
        
        Alamofire.request(urlPelicula).responseJSON { response in
            self.lblEncontrada.text = ""
            self.lblNombre.text = ""
            self.lblAño.text = ""
            self.lblClasificacion.text = ""
            self.lblDuracion.text = ""
            self.lblGenero.text = ""
            self.lblDirector.text = ""
            
            if let dictRespuesta = response.result.value as? NSDictionary {
                if let respuesta = dictRespuesta.value(forKey: "Response") as? String {
                    self.encontrada = respuesta
                }
                if self.encontrada == "True" {
                    if let nombre = dictRespuesta.value(forKey: "Title") as? String {
                        self.lblNombre.text = nombre
                    }
                    if let año = dictRespuesta.value(forKey: "Year") as? String {
                        self.lblAño.text = año
                    }
                    if let clasificacion = dictRespuesta.value(forKey: "Rated") as? String {
                        self.lblClasificacion.text = clasificacion
                    }
                    if let duracion = dictRespuesta.value(forKey: "Runtime") as? String {
                        self.lblDuracion.text = duracion
                    }
                    if let genero = dictRespuesta.value(forKey: "Genre") as? String {
                        self.lblGenero.text = genero
                    }
                    if let director = dictRespuesta.value(forKey: "Director") as? String {
                        self.lblDirector.text = director
                        self.pelicula = ""
                        self.aiCargar.stopAnimating()
                    }
                } else {
                    self.lblEncontrada.text = "Pelicula no encontrada"
                    self.pelicula = ""
                    self.aiCargar.stopAnimating()
                }
            }
        }
    }
    
}

