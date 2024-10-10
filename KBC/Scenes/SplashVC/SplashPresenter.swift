//
//  SplashPresenter.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/10/24.
//



import UIKit
import CoreLocation

protocol SplashPresenterDelegate{
    
}

typealias SplashPresenterVCDelegate = SplashPresenterDelegate & UIViewController


class SplashPresenter{
    
    weak var delegate:SplashPresenterVCDelegate?
    private let locationController = LocationController()
    
    func fetchDomans(){
        AppManager.shared.fetchDomans { result in
            switch result {
            case .success(let response):
                return
            case .failure(let error):
                Alerts.shared.show(title: "Error!", message: error.localizedDescription)
            }
        }
    }
    
    func fetchCurrentLocation(){
        locationController.delegate = self
        locationController.checkIfLocationServicesIsEnabled()
        initiateAppStateConnect()
    }
    

    private func initiateAppStateConnect(){
        AppManager.shared.initiateAppStateConnect(userHash: "") { result in
            switch result {
            case .success(_):
                let vc = WebViewVC.instantiate()
                self.delegate?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print("Error:",error.localizedDescription)
            }
        }
    }
    
    
    
}



extension SplashPresenter:LocationControllerDelegate{
    func getCurrentLocation(currentLocation: CLLocationCoordinate2D) {
        AppData.saveCurrentLocation(location: currentLocation)
    }
}
