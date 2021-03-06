//
//  EventDetailVC.swift
//  TBNApplications
//
//  Created by Ping Li on 2017-03-29.
//  Copyright © 2017 Ping Li. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController, UIWebViewDelegate{

    var eventFeed: EventRSSFeed?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var webViewEventDetail: UIWebView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.startAnimating()
        if eventFeed != nil {
            //Show title
            titleLabel.text = eventFeed!.title
            //Show time
            timeLabel.text = eventFeed!.time
            //Show detail
            webViewEventDetail.delegate = self
            webViewEventDetail.loadHTMLString((eventFeed!.itemDescription), baseURL: nil)
            webViewEventDetail.sizeToFit()
            webViewEventDetail.layer.masksToBounds = true
            webViewEventDetail.layer.cornerRadius = 10.0
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webViewEventDetail == webView{
            activitySpinner.stopAnimating()
        }
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //UIWebView doesn't automatcially handle url which starts with "rwgps://"
        //This url needs to be opened explicitly in application level
        if navigationType == UIWebViewNavigationType.linkClicked
        {
            if request.url != nil
            {
                if request.url!.absoluteString.contains("rwgps://")
                {
                    UIApplication.shared.open(URL(string: request.url!.absoluteString)!, options: [:], completionHandler: nil)
                    return false
                }
            }
        }
        return true
    }
}
