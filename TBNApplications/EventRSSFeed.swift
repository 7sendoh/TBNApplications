//
//  EventRSSFeed.swift
//  TBNApplications
//
//  Created by Ping Li on 2017-03-24.
//  Copyright © 2017 Ping Li. All rights reserved.
//

import Foundation
import AlamofireRSSParser

class EventRSSFeed{
    
    private var _title: String!
    private var _link: String!
    private var _itemDescription: String!
    private var _guid: String!
    private var _pubDate: Date!
    private var _imagesFromDescription: [String]!
    
    //Getter for RSS details
    var title: String{
        if _title == nil{
            _title = ""
        }
        return _title
    }
    
    var link: String{
        if _link == nil{
            _link = ""
        }
        return _link
    }
    
    var itemDescription: String{
        if _itemDescription == nil{
            _itemDescription = ""
        }
        return _itemDescription
    }
    
    var guid: String{
        if _guid == nil{
            _guid = ""
        }
        return _guid
    }
    
    //Date only with format
    var date: String{
        if _pubDate == nil{
            return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            return dateFormatter.string(from: _pubDate)
        }
    }
    
    //Time only with format
    var time: String{
        if _pubDate == nil{
            return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = timeFormat
            dateFormatter.amSymbol = timeAMSymbol
            dateFormatter.pmSymbol = timePMSymbol
            return dateFormatter.string(from: _pubDate)
        }
    }
    
    var imagesFromDescription: [String]{
        if _imagesFromDescription == nil{
            return []
        }else{
            return _imagesFromDescription
        }
    }
    
    init(item: RSSItem){
        self._title = item.title
        self._link = item.link
        self._itemDescription = item.itemDescription
        self._guid = item.guid
        self._pubDate = item.pubDate
        self._imagesFromDescription = imagesFromDescription
    }

}
