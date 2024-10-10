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
    private var urlFull = ""
    private var attemptCallUrl = 1
    
    func fetchCurrentLocation(){
        locationController.delegate = self
        locationController.checkIfLocationServicesIsEnabled()
        
    }
    
    private func fetchDomans(url:String){
        
        AppManager.shared.fetchDomans(url: url){ result in
            switch result {
            case .success(let response):
                let domainURL = "https://" + (response.resultData?.domainURL ?? "")
                AppConfig.tagUrlDomain = domainURL
                AppConfig.tagUrlHomeDomain = domainURL
                self.initiateAppIntroConnect()
            case .failure(let error):
                self.executeGetDomainCheck()
            }
        }
        
    }
    
    private func executeGetDomainCheck(){
        attemptCallUrl = attemptCallUrl + 1;
        if attemptCallUrl == 2 {
            let url = AppConfig.STG_KBC_main_domain2 + AppConfig.url_app_domain + AppConfig.agent_site_seq
            fetchDomans(url:url)
        } else if (attemptCallUrl == 3) {
            let url = AppConfig.STG_KBC_main_domain3 + AppConfig.url_app_domain + AppConfig.agent_site_seq
            fetchDomans(url:url)
        } else {
            Alerts.shared.show(title: "Error!", message: "Error: Check App Domin Failed")
        }
    }
    
    
    
    private func initiateAppIntroConnect(){
        AppManager.shared.initiateAppIntroConnect { result in
            self.checkHashValue()
            switch result {
            case .success(_):
                break
            case .failure(let error):
                Alerts.shared.show(title: "Error!", message: error.localizedDescription)
            }
        }
    }
    
    private func checkHashValue(){
        if AppData.userHash.isEmpty == false{
            initiateAppStateConnect(userHash: AppData.userHash)
        }else{
            chechAuth()
        }
    }
    
    private func initiateAppStateConnect(userHash:String){
        AppManager.shared.initiateAppStateConnect(userHash: userHash) { result in
            switch result {
            case .success(let response):
                if response.resultST != AppConfig.status_response_success{
                    self.clearData()
                }
            case .failure(let error):
                Alerts.shared.show(title: "Error!", message: error.localizedDescription)
                self.clearData()
            }
            self.chechAuth()
        }
    }
    
    private func chechAuth(){
        
        urlFull = AppConfig.tagUrlDomain
        
        if (AppData.vipUrl.isEmpty == false) {
            
            urlFull =
            "\(AppData.vipUrl)\(AppConfig.url_success_login_url)?user_hash=\(AppData.userHash)&isPwaSignIn=Y";
            
        } else {
            
            urlFull =
            "\(urlFull + AppConfig.url_success_login_url)?user_hash=\(AppData.userHash)&isPwaSignIn=Y";
            
        }
        
        if AppData.isBiometricSet{
            
            authorization()
            
        }else{
            goToHome(url: self.urlFull)
        }
        
        
    }
    
    private  func authorization(){
        AuthManager.shared.authenticateUser { success in
            if success{
                self.goToHome(url: self.urlFull)
            }
        }
    }
    
    private func goToHome(url:String){
        let vc = WebViewVC.instantiate()
        vc.url = url
        delegate?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func clearData(){
    
        AppData.vipUrl = "";
        AppData.isBiometricSet = false;
        AppData.userHash = "";
        AppData.isLoginRememberMe = "N";
        AppData.isLoginBiometric = "";
        
    }
    
    
}



extension SplashPresenter:LocationControllerDelegate{
    func getCurrentLocation(currentLocation: CLLocationCoordinate2D) {
        AppData.saveCurrentLocation(location: currentLocation)
        
    }
    
    func finishCheck() {
        let url = AppConfig.STG_KBC_main_domain + AppConfig.url_app_domain + AppConfig.agent_site_seq
        fetchDomans(url: url)
    }
}
