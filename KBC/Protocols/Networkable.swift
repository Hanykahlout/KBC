//
//  Networkable.swift
//  FormApp
//
//  Created by Hany Alkahlout on 27/08/2022.
//
//
import Foundation
import Moya
import Network
import Alamofire



protocol Networkable{
    
    associatedtype targetType:TargetType
    var provider: MoyaProvider<targetType> { get }
    func request<T:Decodable>(isWithProgress:Bool,
                              progressTitle:String?,
                              target:targetType,completion: @escaping (Result<T, Error>) -> ())
    
}


extension Networkable{
    
    func request<T: Decodable>(isWithProgress:Bool = true,progressTitle:String? = nil,target: targetType, completion: @escaping (Result<T, Error>) -> ()) {
        
        print("""
              \n\n\n\n\n
              Request BaseURL: \(target.baseURL)
              \n
              Request Path: \(target.path)
              \n
              Request Method: \(target.method)
              \n
              Request Header: \(target.headers ?? [:])
              \n
              Request Task: \(target.task)
              \n
              """)
        
        if isWithProgress{
            HUDManager.shared.animate(progressTitle)
        }
        
        provider.request(target) { result in
            if isWithProgress{
                HUDManager.shared.dismiss()
            }
            switch result
            {
            case let .success(response):
                
                print("""
                    Request Response:
                    \(String(data: response.data, encoding: .utf8) ?? "Faild to Convert response to String")
                    \n\n
                    
                    """)
                
              if response.statusCode == 503 || response.statusCode == 500 {
                    
                    completion(.failure(MyError.serverError))
                    
                } else {
                    
                    do {
                        
                        let results = try JSONDecoder().decode(T.self, from: response.data)
                        completion(.success(results))
                        
                    } catch let error {
                        
                        print(error)
                        completion(.failure(MyError.customError))
                        
                    }
                    
                }
                
                
            case let .failure(error):
                print(error)
                completion(.failure(MyError.customError))
            }
            
        }
        
    }
    
    
}


public enum MyError: Error {
    case customError
    case serverError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError:
            return NSLocalizedString("Something went wrong try again", comment: "")
        case .serverError:
            return NSLocalizedString("Server Error !!", comment: "")
        }
    }
}



