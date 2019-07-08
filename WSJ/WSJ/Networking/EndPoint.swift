//
//  EndPointType.swift
//  AppleRss
//
//  Created by Nick on 5/13/19.
//  Copyright © 2019 NickOwn. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var pathName: String { get }
    var envir: WSJRSSSource { get }
}



public enum WSJRSSSource: String, CaseIterable {
    case Opinion, WorldNews, Business, Markets, Lifestyle
    
}

extension WSJRSSSource : EndPointType {
    var baseURL: URL {
        switch self {
        case .Business:
            return URL(string: "https://feeds.a.dj.com/rss/WSJcomUSBusiness.xml")!
        case .Lifestyle:
            return URL(string: "https://feeds.a.dj.com/rss/RSSLifestyle.xml")!
        case .Markets:
            return URL(string: "https://feeds.a.dj.com/rss/RSSMarketsMain.xml")!
        case .Opinion:
            return URL(string: "https://feeds.a.dj.com/rss/RSSOpinion.xml")!
        default:
            return URL(string: "https://feeds.a.dj.com/rss/RSSWorldNews.xml")!
        }
    }
    
    var pathName: String {
        switch self {
        case .Business:
            return "Business"
        case .Lifestyle:
            return "Lifestyle"
        case .Markets:
            return "US Markets"
        case .Opinion:
            return "Opinion"
        default:
            return "World News"
        }
    }
    
    var envir: WSJRSSSource {
        return self
    }
}

