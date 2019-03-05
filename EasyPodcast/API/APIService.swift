//
//  APIService.swift
//  EasyPodcast
//
//  Created by 钟汇杭 on 2019/3/4.
//  Copyright © 2019 钟汇杭. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    // Singleton
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        let secureFeedUrl = feedUrl.toSecureHTTPS()
        print("secure feed url: ", secureFeedUrl)
        guard let url = URL(string: secureFeedUrl) else { return }
        
        DispatchQueue.global(qos: .background).async {
            print("Before parser")
            let parser = FeedParser(URL: url)
            print("After parser")
            
            parser.parseAsync { (result) in
                print("Successfully parse feed:", result.isSuccess)
                
                if let err = result.error {
                    print("Failed to parse XML feed:", err)
                    return
                }
                
                guard let feed = result.rssFeed else { return }
                
                let episodes = feed.toEpisodes()
                completionHandler(episodes)
            }
        }
    }
    
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
