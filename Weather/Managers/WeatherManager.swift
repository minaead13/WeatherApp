//
//  WeatherManager.swift
//  Weather
//
//  Created by Mina on 03/04/2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> weatther {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=cfc0d450ef67c59b9f8222d14b96479e") else { fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(weatther.self, from: data)
        return decodedData
        
    }
}

struct weatther: Decodable {
    let coord : Cord
    let weather : [Weather]
    let base: String
    var main: Main
    let name : String
    let wind : Wind
}
struct Cord :Decodable{
    let lon: Double
    let lat : Double
}
struct Weather:Decodable {
    let id : Double
    let main: String
    let description: String
    let icon: String
}
struct Main :Decodable{
    let temp : Double
    let feels_like: Double
    let temp_min:Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}
struct Wind: Decodable {
    let speed : Double
    let deg: Double
}
