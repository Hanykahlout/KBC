//
//  AppTarget.swift
//  FormApp
//
//  Created by Hany Alkahlout on 18/02/2023.
//

import Foundation
import Moya

enum AppTarget:TargetType{
    
    case initiateAppStateConnect(userHash:String)
    case getAppIntro
    
    
    
    var baseURL: URL {
        switch self{
        default:
            return URL(string: "\(AppConfig.MAIN_DOMAIN)")!
        }
        
    }
    
    
    var path: String {
        switch self {
        case .initiateAppStateConnect: "/app/user/state/check/xhr"
        case .getAppIntro: "/app/intro"
        }
    }
    
    
    var method: Moya.Method {
        switch self{
            
        case .initiateAppStateConnect:
            return .post
        default:
            return .get
        }
        
    }
    
    
    var task: Task{
        
        switch self{
            
            
        case .initiateAppStateConnect:
            
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        default:
            return .requestPlain
            
        }
        
    }
    
    
    var headers: [String : String]?{
        switch self{
            
        case .initiateAppStateConnect:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .getAppIntro:
            var locationController = LocationController()
            return ["accept":"application/json",
                    "Content-Type":"application/json",
                    "deviceInfo":locationController.getDeviceInfoJSON()]
        }
        
    }
    
    
    
    var param: [String : Any]{
        switch self {
        case .initiateAppStateConnect(let userHash):
            return ["user_hash":userHash]
        default:
            return [ : ]
        }
        
    }
    
    
}


