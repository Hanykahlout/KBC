//
//  BaseResponse.swift
//  FormApp
//
//  Created by Hany Alkahlout on 18/02/2023.
//

import Foundation


class BaseResponse: Decodable{
    
    let status: Bool?
    let code: Int?
    let message: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case  status, code ,message
    }
}


class BaseObjectResponse<T:Decodable>: BaseResponse{
    
    let data: T?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent(T.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}



class BaseArrayResponse<T:Decodable>: BaseResponse{
    
    let data: [T]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([T].self, forKey: .data)
        try super.init(from: decoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
