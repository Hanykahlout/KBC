//
//  LocationControllerDelegate.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/9/24.
//



import UIKit
import CoreLocation

protocol LocationControllerDelegate{
    func notDeterminedLocation()
    func getCurrentLocation(currentLocation:CLLocationCoordinate2D)
    func getCurrentLocationLabel(currentLocation:String)
}

extension LocationControllerDelegate{
    func notDeterminedLocation(){}
    func getCurrentLocation(currentLocation:CLLocationCoordinate2D){}
    func getCurrentLocationLabel(currentLocation:String){}
}


typealias LocationControllerVCDelegate = LocationControllerDelegate

class LocationController:NSObject{
    
    var delegate:LocationControllerVCDelegate?
    
    private var locationManager = CLLocationManager()
    private var isChecked = false
    public var currentLocation:CLLocationCoordinate2D?
    
   
    
    // MARK: - Private Functions
    
    private func checkLocationAuthorization(){
        switch locationManager.authorizationStatus{
        case .notDetermined:
            delegate?.notDeterminedLocation()
            
        case .restricted:
            // show message
            break
        case .denied:
            // show message
            break
        case .authorizedWhenInUse, .authorizedAlways:
            /// app is authorized
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    // MARK: - Public Functions
    
    func checkIfLocationServicesIsEnabled(){
        DispatchQueue.global(qos: .background).async {
            if CLLocationManager.locationServicesEnabled(){
                if !self.isChecked{
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.checkLocationAuthorization()
                    self.isChecked = true
                }
            }
        }
    }
    
    
    func requestLocation(){
        locationManager.requestWhenInUseAuthorization()
    }
   
}

// MARK: - Location Manager Delegate

extension LocationController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        currentLocation = location.coordinate
        self.delegate?.getCurrentLocation(currentLocation: currentLocation!)
        locationManager.stopUpdatingLocation()
        AppData.saveCurrentLocation(location: location.coordinate)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

