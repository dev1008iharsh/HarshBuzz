//
//  ApiManager.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 14/02/24.
//

import Foundation
 
enum DataError : Error {
    case invalidRepsonse
    case invalidURL
    case invalidData
    case network(Error?)
}
 
typealias Handler<T> = (Result<T, DataError>) -> Void
 
class ApiManager{
    
    static let shared = ApiManager()
    private init(){}
   
    func request< T:Decodable >(modelType : T.Type, type : EndPointType, completion : @escaping Handler<T>) {
       
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~=  response.statusCode else {
                completion(.failure(.invalidRepsonse))
                return
            }
          
            do{
                let model = try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(model))
            }catch{
                completion(.failure(.network(error)))
            }
            
            
        }.resume()
    }
    
}
 
