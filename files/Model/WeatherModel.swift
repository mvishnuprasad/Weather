//
//  WeatherModel.swift
//  Weather
//
//  Created by VISHNU PRASAD M on 13/06/22.
//

import Foundation

struct WeatherDataModel : Codable {
    let id : Int
    let weather : [Weather]
    let main : Main
    let visibility : Int
}

struct Weather : Codable{
    let id : Int
    let main : String
    let description : String
    let icon : String
}

struct Main : Codable{
    let temp : Double
    let pressure : Int
    let humidity : Int
    
    
}
