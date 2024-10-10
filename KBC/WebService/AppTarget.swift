//
//  AppTarget.swift
//  FormApp
//
//  Created by Hany Alkahlout on 18/02/2023.
//

import Foundation
import Moya

enum AppTarget:TargetType{
    
    case initiateAppIntroConnect
    case fetchDomans(url:String)
    case initiateAppStateConnect(userHash:String)
    
    var baseURL: URL {
        switch self{
        case .fetchDomans(let url):
            return URL(string:url)!
        default:
            return URL(string: "\(AppConfig.tagUrlDomain)")!
        }
        
    }
    
    
    var path: String {
        switch self {
        case .initiateAppIntroConnect: AppConfig.url_app_intro
        case .initiateAppStateConnect: AppConfig.url_app_status_check
        default: ""
        }
    }
    
    
    var method: Moya.Method {
        switch self{
            
        case.fetchDomans,.initiateAppStateConnect:
            return .post
        default:
            return .get
        }
        
    }
    
    
    var task: Task{
        
        switch self{
            
            
        case .fetchDomans,.initiateAppStateConnect:
            
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        default:
            return .requestPlain
            
        }
        
    }
    
    
    var headers: [String : String]?{
        switch self{
            
        case .initiateAppIntroConnect:
            return ["accept":"application/json",
                    "Content-Type":"application/json",
                    "deviceInfo":AppData.getDeviceInfoJSON()]
        case .fetchDomans,.initiateAppStateConnect:
            return ["Accept-Charset":"UTF-8",
                    "Content-Type": "application/x-www-form-urlencoded"]
            
        }
        
    }
    
    
    
    var param: [String : Any]{
        switch self {
        case .fetchDomans:
            return ["agent_site_seq_app":AppConfig.agent_site_seq]
        case .initiateAppStateConnect(let userHash):
            return ["user_hash":userHash]
        default:
            return [ : ]
        }
        
    }
    
    
}


