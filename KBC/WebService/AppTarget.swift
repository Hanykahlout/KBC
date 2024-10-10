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
    case fetchDomans
    
    //    AppUrls.STG_KBC_main_domain +
    //        AppUrls.url_app_domain +
    //        AppUrls.agent_site_seq;
    
    
    var baseURL: URL {
        switch self{
            
        default:
            return URL(string: "\(AppConfig.STG_KBC_main_domain)")!
        }
        
    }
    
    
    var path: String {
        switch self {
        case .initiateAppStateConnect: "/app/user/state/check/xhr"
        case .getAppIntro: "/app/intro"
        case .fetchDomans: AppConfig.url_app_domain + AppConfig.agent_site_seq
        }
    }
    
    
    var method: Moya.Method {
        switch self{
            
        case .initiateAppStateConnect,.fetchDomans:
            return .post
        default:
            return .get
        }
        
    }
    
    
    var task: Task{
        
        switch self{
            
            
        case .initiateAppStateConnect,.fetchDomans:
            
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
                    "deviceInfo":AppData.getDeviceInfoJSON()]
        case .fetchDomans:
            return ["Accept-Charset":"UTF-8"]
        }
        
    }
    
    
    
    var param: [String : Any]{
        switch self {
        case .initiateAppStateConnect(let userHash):
            return ["user_hash":userHash]
        case .fetchDomans:
            return ["agent_site_seq_app":AppConfig.agent_site_seq]
        default:
            return [ : ]
        }
        
    }
    
    
}


