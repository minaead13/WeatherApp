//
//  ContentView.swift
//  Weather
//
//  Created by Mina on 03/04/2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherMnager = WeatherManager()
    @State var weather: weatther?
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if  let weather = weather {
                    WeatherView(weather: weather)
                    
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherMnager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather:\(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
