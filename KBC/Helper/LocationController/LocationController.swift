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
    func finishCheck()
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
    private var isFinish = false
    
    
    // MARK: - Private Functions
    
    private func checkLocationAuthorization(){
        
        switch locationManager.authorizationStatus{
        case .notDetermined:
            self.requestLocation()
            delegate?.notDeterminedLocation()
            
        case .restricted:
            // show message
            delegate?.finishCheck()
            break
        case .denied:
            // show message
            delegate?.finishCheck()
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
        if isFinish == false{
            delegate?.finishCheck()
            isFinish = true
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

