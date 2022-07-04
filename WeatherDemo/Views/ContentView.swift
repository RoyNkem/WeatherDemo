//
//  ContentView.swift
//  WeatherDemo
//
//  Created by Roy Aiyetin on 28/04/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State private var weather: ResponseBody?
    
    var body: some View {
        VStack {
    // if i can get the location show the weather info, otherwise
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingVIew()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")}
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingVIew()
                } else { WelcomeView()
                    .environmentObject(locationManager)}
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
