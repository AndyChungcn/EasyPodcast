//
//  RSSFeed.swift
//  EasyPodcast
//
//  Created by 钟汇杭 on 2019/3/4.
//  Copyright © 2019 钟汇杭. All rights reserved.
//

import FeedKit

extension RSSFeed {
    func toEpisodes() -> [Episode] {
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        
        var episodes = [Episode]()
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            
            if episode.imageUrl == nil {
                episode.imageUrl = imageUrl
            }
            
            episodes.append(episode)
        })
        return episodes
    }
}
