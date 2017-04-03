//
//  ViewController.swift
//  TBNApplications
//
//  Created by Ping Li on 2017-03-24.
//  Copyright © 2017 Ping Li. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var EventTableView: UITableView!
    @IBOutlet weak var AllEventLabel: UILabel!
    @IBOutlet weak var Next20EventLabel: UITextField!
    @IBOutlet weak var AllEventButton: UILabel!
    @IBOutlet weak var ActivitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var LaunchScreenView: UIView!
    
    var eventFeedList: [EventRSSFeed] = []
    var displayAllEvent: Bool = false
    var showLaunchScreen: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Basic setup
        view.bringSubview(toFront: LaunchScreenView)
        EventTableView.delegate = self
        EventTableView.dataSource = self
        EventTableView.layer.cornerRadius = 10.0
        AllEventLabel.layer.masksToBounds = true
        AllEventLabel.layer.cornerRadius = 10.0
        AllEventButton.isEnabled = false
        //Hook up the event for the app becoming active
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(reloadEventTableView), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    func reloadEventTableView(){
        if showLaunchScreen
        {
            LaunchScreenView.isHidden = false
            view.bringSubview(toFront: LaunchScreenView)
        }else{
            ActivitySpinner.startAnimating()
        }
        //Remove all exist feed to do refresh
        self.eventFeedList.removeAll()
        self.EventTableView.reloadData()
        //Download event RSS feed
        downloadEventDetail {
            self.EventTableView.reloadData()
            self.AllEventButton.isEnabled = true
            if self.showLaunchScreen
            {
                self.LaunchScreenView.isHidden = true
                self.showLaunchScreen = false
            }else{
                self.ActivitySpinner.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell{
            //Insert feed content into cell
            cell.configureCell(eventFeed: eventFeedList[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventFeedList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func downloadEventDetail(completed: @escaping DownloadComplete){
        //Request event feed content in RSS form
        Alamofire.request(rssURL).responseRSS() { (response) -> Void in
            if let feed: RSSFeed = response.result.value {
                //Set value for feed object
                if !self.displayAllEvent
                {
                    for i in 0...19 {
                        let item = feed.items[i]
                        self.eventFeedList.append(EventRSSFeed(item: item))
                    }
                } else{
                    //all event
                    for item in feed.items {
                        self.eventFeedList.append(EventRSSFeed(item: item))
                    }
                }
                completed()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = eventFeedList[indexPath.row]
        performSegue(withIdentifier: "EventDetailVC", sender: event)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass event to detail page
        if segue.identifier == "EventDetailVC"{
            if let detailsVC = segue.destination as? EventDetailVC {
                if let event = sender as? EventRSSFeed {
                    detailsVC.eventFeed = event
                }
            }
        }
    }
    
    @IBAction func allEventButtonPressed(_ sender: Any) {
        if(AllEventButton.isEnabled)
        {
            //Reload the event table view list when user press the all event/Next 20 toggle button
            AllEventButton.isEnabled = false
            if(displayAllEvent)
            {
                displayAllEvent = false
                Next20EventLabel.isHidden = false
                AllEventLabel.text = allEventLabelText
            }else{
                displayAllEvent = true
                Next20EventLabel.isHidden = true
                AllEventLabel.text = next20EventLabelText
            }
            reloadEventTableView()
        }
    }
}

