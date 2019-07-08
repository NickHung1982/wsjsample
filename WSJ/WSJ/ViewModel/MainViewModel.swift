//
//  MainViewModel.swift
//  WSJ
//
//  Created by Nick on 5/13/19.
//  Copyright © 2019 NickOwn. All rights reserved.
//

import Foundation
import UIKit


class MainViewModel: NSObject {
    let isLoading = Observable<Bool>(value: false)
    let isTableViewHidden = Observable<Bool>(value: false)
    let rssItems = Observable<[RSS]>(value: [])
    let title = Observable<String>(value: "")
    let service = DataNetWorking<WSJRSSSource>()
    
    var sourceType: WSJRSSSource
    init(Source: WSJRSSSource) {
        self.sourceType = Source
        super.init()
    }
    
}

extension MainViewModel {
    
    //First loading
    func start() {
        self.isLoading.value = true
        self.isTableViewHidden.value = true
        self.title.value = self.sourceType.pathName
      
        service.request(ep: WSJRSSSource.Business, completion: { data, res, err in
            self.isLoading.value = false
            self.isTableViewHidden.value = false
            if let data = data {
                let parserss = ParseWSJRSS()
                if let values = parserss.parserData(data: data) {
                    self.rssItems.value = values
                }
            }
            
        })
    }
    //When user change click change source
    func changeSource(source: WSJRSSSource) {
        self.isLoading.value = true
        self.sourceType = source
        service.request(ep: source, completion: { data, res, err in
            self.isLoading.value = false
            self.title.value = source.pathName
            
            if let data = data {
                let parserss = ParseWSJRSS()
                if let values = parserss.parserData(data: data) {
                    self.rssItems.value = values
                }
            }
        })
    }
    
   
}
