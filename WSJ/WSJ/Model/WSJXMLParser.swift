//
//  WSJXMLParser.swift
//
//
//  Created by Nick on 5/12/19.
//  Copyright © 2019 NickOwn. All rights reserved.
//

import Foundation

struct RSS {
    var title: String
    var link: String
    var description: String
}

class ParseWSJRSS: NSObject, XMLParserDelegate {
    private var rssData: Data?
    private var currentElement: String?
    private var items: [RSS]
    private var item: RSS
    private var inItem: Bool
    var isReady: Bool
    
    override init() {
        inItem = false
        item = RSS(title: "", link: "", description: "")
        items = []
        isReady = false
    }
    
    func parserData(data: Data?) -> [RSS]?  {
        guard let d = data else { return nil }
        self.rssData = d
        let p = XMLParser(data: d)
        p.delegate = self
        
        if p.parse() {
            return self.items
        } else {
            return nil
        }
        
    }
    
    func getParsedItems() -> [RSS] {
        return items
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        isReady = false
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        isReady = true
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName.lowercased() == "item" {
            inItem = true
            //start an new item
            item = RSS(title: "", link: "", description: "")
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement = elementName
        if elementName.lowercased() == "item" {
            inItem = false
            print("data append: \(item.title)")
            items.append(item)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !inItem { return }
        
        let trimStr = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimStr == "" { return }
        switch currentElement?.lowercased() {
            case "title":
                item.title = trimStr
                break
            case "link":
                item.link = trimStr
                break
            case "description":
                item.description = trimStr
                break
            default:
                break;
        }
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if !inItem { return }
        
        let dataStr = String(data: CDATABlock, encoding: .utf8)!
        if (dataStr == "") { return }
        switch currentElement?.lowercased() {
        case "title":
            item.title = dataStr
            break
        case "link":
            item.link = dataStr
            break
        case "description":
            item.description = dataStr
            break
        default:
            break;
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }
}
