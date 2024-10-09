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
    
    func initiateAppStateConnect(userHash:String,completion: @escaping (Result<BaseResponse<DataResponse>, Error>)-> ())
    func getAppIntro(completion: @escaping (Result<BaseResponse<DataResponse>, Error>)-> ())
    
}


class AppManager: AppNetworkable {
    
    
    typealias targetType = AppTarget
    
    var provider: MoyaProvider<AppTarget> = MoyaProvider<AppTarget>(plugins: [NetworkLoggerPlugin()])
    
    public static var shared: AppManager = {
        let generalActions = AppManager()
        return generalActions
    }()
    
    
    func initiateAppStateConnect(userHash: String, completion: @escaping (Result<BaseResponse<DataResponse>, Error>) -> ()) {
        request(target: .initiateAppStateConnect(userHash: userHash), completion: completion)
    }
    
    func getAppIntro(completion: @escaping (Result<BaseResponse<DataResponse>, any Error>) -> ()) {
        request(target: .getAppIntro, completion: completion)
    }
    
    
}
