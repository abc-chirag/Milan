//
//  PostViewModel.swift
//  Milan
//
//  Created by mac on 14/10/21.
//

import Foundation

class PostViewModel : NSObject {
    //MARK:- Properties
    var arrResult = [Posts]()

    //MARK:- Functions
    func getAllData(completionHandeler:@escaping ((_ success:Bool, _ message:String)->()) ){
        let utility = HttpUtility.shared 
        let requestUrl = URL(string: "https://app.unikwork.com/instagram/api/get_data.php")
        let request = HURequest(withUrl: requestUrl!, forHttpMethod: .get)
        
        utility.request(huRequest: request, resultType: [Posts].self) { (response) in
            switch response {
            
            case .success(let data):
                guard let results = data else {
                    completionHandeler(false, "")
                    return
                }
                
                self.arrResult = results
                
                completionHandeler(true, "")
                
            case .failure(let error):
                print(error)
                completionHandeler(false, error.localizedDescription)
            }
        }
    }
}


