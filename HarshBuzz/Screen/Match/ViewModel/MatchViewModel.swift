//
//  MatchViewModel.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 13/02/24.
//

import UIKit
 
final class MatchViewModel{
  
    var matchResponce1 : MatchModel!
    var matchResponce2 : MatchModel!
    
    var eventHandler : ((_ event : Event) -> Void)?
 
    func fetchFirstMatchDataApi(){
         
        eventHandler?(.loading)

        ApiManager.shared.request(modelType: MatchModel.self, type: MatchEndPointItem.matchDataFirstMatch) { [ weak self ] response in
            
            guard let self else { return }
            
            eventHandler?(.stopLoading)
             
            switch response{
            case .success(let dataFromApi):
                
                print("dataFromApi1",dataFromApi)
                
                matchResponce1 = dataFromApi
                
                self.fetchSecondMatchDataApi()
             
            case .failure(let error):
                
                eventHandler?(.network(error))
                
            }
        }
    }
    func fetchSecondMatchDataApi(){
         
        eventHandler?(.loading)

        ApiManager.shared.request(modelType: MatchModel.self, type: MatchEndPointItem.matchDataSecondMatch) { [ weak self ] response in
            
            guard let self else { return }
            
            eventHandler?(.stopLoading)
             
            switch response{
            case .success(let dataFromApi):
                
                print("dataFromApi2",dataFromApi)
                
                matchResponce2 = dataFromApi
                
                eventHandler?(.dataLoaded)
                
            case .failure(let error):
                eventHandler?(.dataLoaded)// for first one
                eventHandler?(.network(error))
                
            }
        }
    }
    
}


extension MatchViewModel{
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case network(Error?)
    }

}
