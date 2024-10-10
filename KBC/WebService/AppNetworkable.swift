//
//  AppNetworkable.swift
//  FormApp
//
//  Created by Hany Alkahlout on 18/02/2023.
//

import Foundation
import Moya
import Network
import Alamofire

protocol AppNetworkable:Networkable  {
    
    func initiateAppIntroConnect(completion: @escaping (Result<BaseResponse, Error>)-> ())
    func fetchDomans(url:String,completion: @escaping (Result<DomansData, Error>)-> ())
    func initiateAppStateConnect(userHash:String,completion: @escaping (Result<AppStateData, Error>)-> ())
}


class AppManager: AppNetworkable {
       
    typealias targetType = AppTarget
    
    var provider: MoyaProvider<AppTarget> = MoyaProvider<AppTarget>(plugins: [NetworkLoggerPlugin()])
    
    public static var shared: AppManager = {
        let generalActions = AppManager()
        return generalActions
    }()
    
    
    func initiateAppIntroConnect(completion: @escaping (Result<BaseResponse, Error>) -> ()) {
        request(target: .initiateAppIntroConnect, completion: completion)
    }
    
    func fetchDomans(url:String,completion: @escaping (Result<DomansData, any Error>) -> ()) {
        request(target: .fetchDomans(url: url), completion: completion)
    }
    
    func initiateAppStateConnect(userHash: String, completion: @escaping (Result<AppStateData, any Error>) -> ()) {
        request(target: .initiateAppStateConnect(userHash: userHash), completion: completion)
    }
    
    
}

