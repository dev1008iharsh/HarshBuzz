//
//  QuestionEndPointItem.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 13/02/24.
//

import Foundation

enum MatchEndPointItem {
    case matchDataFirstMatch
    case matchDataSecondMatch
}

//https://demo.sportz.io/nzin01312019187360.json
extension MatchEndPointItem : EndPointType {
 
    var path: String {
        switch self{
        case .matchDataFirstMatch :
            return "nzin01312019187360.json"
        case .matchDataSecondMatch :
            return "sapk01222019186652.json"
        }
        
    }
    
    var baseUrl: String {
        return Constant.BASE_URL
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HttpMehtod {
        return .get 
    }
    
    
}
