//
//  APIService.swift
//  EasyPodcast
//
//  Created by 钟汇杭 on 2019/3/4.
//  Copyright © 2019 钟汇杭. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    // Singleton
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        
        print("Searching for podcasts...")
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            if let err = response.error {
                print("failed to connect to yahoo", err)
                return
            }
            
            guard let data = response.data else {return}
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode ", decodeErr)
            }
            
        }
    }
}

struct SearchResults: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
