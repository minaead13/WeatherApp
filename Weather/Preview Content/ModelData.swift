//
//  ModelData.swift
//  Weather
//
//  Created by Mina on 04/04/2023.
//

import Foundation
var previewWeather: weatther = load("WeatherData.json")
func load<T:Decodable> (_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
        
    }catch {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
}
