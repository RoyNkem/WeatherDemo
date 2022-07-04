//
//  LocationManager.swift
//  WeatherDemo
//
//  Created by Roy Aiyetin on 28/04/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager() //NSobject
    
    @Published var location: CLLocationCoordinate2D? //observableobject protocol
    @Published var isLoading = false
    
    override init() {
        super.init() // from the parent class
        manager.delegate = self // CLLocationManagerDelegate
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location,\(error)")
        isLoading = false
    }
}
