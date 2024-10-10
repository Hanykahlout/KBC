//
//  SplashVC.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/9/24.
//

import UIKit
import CoreLocation

class SplashVC: UIViewController {
    
    
    // MARK: - Private Attributes
    
    
    private var presenter = SplashPresenter()
    
    
    
    
    // MARK: - VC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        presenter.delegate = self
        
        presenter.fetchCurrentLocation()
        
        
    }
    
    
    
    // MARK: - Private Functions
    
    

    
}



// MARK: - Presenter Delegate
extension SplashVC:SplashPresenterDelegate{
    
}




// MARK: - Set Storybaord Name
extension SplashVC :Storyboarded{
    static var storyboardName: StoryboardName = .main
}



