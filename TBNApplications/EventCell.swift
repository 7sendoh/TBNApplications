//
//  EventCell.swift
//  TBNApplications
//
//  Created by Ping Li on 2017-03-27.
//  Copyright © 2017 Ping Li. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class EventCell: UITableViewCell {

    @IBOutlet weak var EventTitle: UILabel!
    @IBOutlet weak var EventDate: UILabel!
    
    func configureCell(eventFeed: EventRSSFeed){
        //Create and insert content to control
        self.EventDate.text = eventFeed.date
        self.EventTitle.text = eventFeed.title
        
        self.EventDate.layer.masksToBounds = true
        self.EventDate.layer.cornerRadius = 10.0
    }
    
}
