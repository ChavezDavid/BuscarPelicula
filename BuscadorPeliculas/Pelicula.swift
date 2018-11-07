//
//  Pelicula.swift
//  BuscadorPeliculas
//
//  Created by Alumno on 25/10/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit

class Pelicula {
    var nombre : String
    var año : String
    var id : String
    var duracion : String
    var clasificacion : String
    var director : String
    var genero : String
    var urlPoster : String
    
    init(nombre : String, id : String, año : String, duracion : String, clasificacion : String, director : String, genero : String, urlPoster : String){
        self.nombre = nombre
        self.id = id
        self.año = año
        self.duracion = duracion
        self.clasificacion = clasificacion
        self.director = director
        self.genero = genero
        self.urlPoster = urlPoster
    }
}
