//
//  AppStateData.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/10/24.
//



struct AppStateData:Decodable{
    
    var resultST:String?
    
    
    enum CodingKeys: String, CodingKey {
        case resultST = "RESULT_ST"
    }
    
}
