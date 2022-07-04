//
//  WeatherManager.swift
//  WeatherDemo
//
//  Created by Roy Aiyetin on 28/04/2022.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    // HTTP request to get the current weather depending on the coordinates we got from LocationManager
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=6.7568557965102976&lon=6.066986379049781&appid=506d43fa2eca2c94dc9c913682d99e5e&units=metric")
        else { fatalError("Missing URL!")}
        
        let urlRequest = URLRequest(url: url) // URLRequest only represents information about the request
        
        // URLSession sends request to the server
        let (data, response) = try await URLSession.shared.data(for: urlRequest) //Since this is a network call, it can take some time to fetch the data. So we'll need to add the await keyword in front of the URLSession
    
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
                
                let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data) // decode the JSON from our URL data into the Response model we creeated below
                
                return decodedData
            }
    }
    
    // Model of the response body we get from calling the OpenWeather API
    struct ResponseBody: Decodable {
        var coord: CoordinatesResponse
        var weather: [WeatherResponse]
        var main: MainResponse
        var name: String
        var wind: WindResponse

        struct CoordinatesResponse: Decodable {
            var lon: Double
            var lat: Double
        }

        struct WeatherResponse: Decodable {
            var id: Double
            var main: String
            var description: String
            var icon: String
        }

        struct MainResponse: Decodable {
            var temp: Double
            var feels_like: Double
            var temp_min: Double
            var temp_max: Double
            var pressure: Double
            var humidity: Double
        }
        
        struct WindResponse: Decodable {
            var speed: Double
            var deg: Double
        }
    }

    extension ResponseBody.MainResponse {
        var feelsLike: Double {return feels_like }
        var tempMin: Double { return temp_min }
        var tempMax: Double { return temp_max }
}
