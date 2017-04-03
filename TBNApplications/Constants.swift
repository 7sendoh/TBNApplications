//
//  Constants.swift
//  TBNApplications
//
//  Created by Ping Li on 2017-03-27.
//  Copyright © 2017 Ping Li. All rights reserved.
//

import Foundation

//URL for event feed RSS file
let rssURL = "https://tbn.ca/widget/events/RSS"

//Button label
let allEventLabelText = "All Events"
let next20EventLabelText = "Next 20 Events"

//Date formatter properties
let dateFormat = "MMM dd"
let timeFormat = "hh:mm a"
let timeAMSymbol = "AM"
let timePMSymbol = "PM"

typealias DownloadComplete = () -> ()
