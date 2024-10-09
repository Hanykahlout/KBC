//
//  SplashVC.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/9/24.
//

import UIKit
import CoreLocation

class SplashVC: UIViewController {
    
    
    private let locationController = LocationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        HUDManager.shared.animate()
        faceID()
      
        
    }
    
    
    private func faceID(){
        AuthManager.shared.authenticateUser { success in
            if success{
                self.fetchCurrentLocation()
            }
        }
    }
    
    private func fetchCurrentLocation(){
        locationController.delegate = self
        locationController.checkIfLocationServicesIsEnabled()
        initiateAppStateConnect()
    }
    
    private func initiateAppStateConnect(){
        AppManager.shared.initiateAppStateConnect(userHash: "") { result in
            switch result {
            case .success(_):
                let vc = WebViewVC.instantiate()
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print("Error:",error.localizedDescription)
            }
        }
    }
}



extension SplashVC:LocationControllerDelegate{
    func getCurrentLocation(currentLocation: CLLocationCoordinate2D) {
        AppData.saveCurrentLocation(location: currentLocation)
    }
}

// MARK: - Set Storybaord Name
extension SplashVC :Storyboarded{
    static var storyboardName: StoryboardName = .main
}



