//
//  Services.swift
//  Consume
//
//  Created by រស្មី on 28/10/22.
//

import Foundation
import Alamofire

class Service{
    
    typealias postsCallBack = (_ posts: [Posts]?, _ status: Bool, _ message: String) -> Void
    var callBack: postsCallBack?
    
    func fetchPosts(endPoint: String){
        let request = AF.request(endPoint)
        request.responseData { response in
            guard let data = response.data else {
                self.callBack?(nil, true, "")
                return
            }
            let jsonDecoder = JSONDecoder()
            do{
                let posts = try jsonDecoder.decode([Posts].self, from: data)
                self.callBack?(posts, true, "")
                
            }catch{
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callback: @escaping postsCallBack){
        self.callBack = callback
    }
}

