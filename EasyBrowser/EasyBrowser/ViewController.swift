//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Devin Leamy on 2020-03-16.
//  Copyright © 2020 Devin Leamy. All rights reserved.
//

import WebKit
import UIKit

//ViewController is inheriting functionality from the UIViewController and implementing the WKNavigationDelegate Protocols
class ViewController: UIViewController, WKNavigationDelegate {
	var webView: WKWebView!
	var progressView: UIProgressView!
	var websites = ["google.com", "apple.com", "hackingwithswift.com", "bing.com"]
	override func loadView() {
		webView = WKWebView()
		//Delegate: One thing acting in place of another
		//When any web page navigation happens please tell me [self] - the current view controller
		webView.navigationDelegate = self
		view = webView //Asign the root view of the view controller to the newInstance of the WKWebView
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		let url = URL(string: "https://" + websites[0])! //Creates new URL object [MUST USE https:// PREFIX]
		webView.load(URLRequest(url: url)) // Creates new URLRequest object with the url and gives it to the webView to load
		webView.allowsBackForwardNavigationGestures = true // Enables some gesture functionality
		//Adds button to navigation bar that when clicked triggers the function openTapped
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Open", style: .plain, target: self, action: #selector(openTapped)
		)
		//Creates new UIProgressView object
		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		//Wrappes the progresssView object in a new UIBarButtonItem
		let progressButton = UIBarButtonItem(customView: progressView)
		
		//Makes a navbar button that expands to fill the navbar
		let spacer = UIBarButtonItem(
			barButtonSystemItem: .flexibleSpace, target: nil, action: nil
		)
		//A refresh button that utilizes the webView's reload method
		let refresh = UIBarButtonItem(
			barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)
		)
		//Set the array of UIBarButtonItems in the toolbar
		toolbarItems = [progressButton, spacer, refresh]
		//Makes the toolbar, that is initally hidden, visible
		navigationController?.isToolbarHidden = false
		//Utilizes KVO (Key-Value observing) to check for status changes in the WKWebView's estimatedProgress property
		webView.addObserver(
			self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil
		)
	}
	
	@objc func openTapped() {
		let alertController = UIAlertController(
			title: "Open page...", message: nil, preferredStyle: .actionSheet
		)
		//Adds websites to be chosen after clicking on the rightBarButtonItem in the nav bar
		//When a button is clicked it triggers the method openPage
		for website in websites {
			alertController.addAction(
				UIAlertAction(title: website, style: .default, handler: openPage)
			)
		}
		//The action controller will be hidden if clicked
		alertController.addAction(
			UIAlertAction(title: "Cancel", style: .cancel)
		)
		//Tells iOS where the action sheet should be anchored
		alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
		present(alertController, animated: true)
	}
	
	func openPage(action: UIAlertAction) {
		//Creates a new URL object and then load the website at the given url
		let url = URL(string: "https://" + action.title!)!
		webView.load(URLRequest(url: url))
	}
	
	//Called once a website has finished loading
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		//Set the navbar title to the name of the website we are visiting
		title = webView.title
	}
	//Is called when a property that is being observed through KVO is changed
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			//Sets the progress of the progress bar
			progressView.progress = Float(webView.estimatedProgress)
		}
	}
	
	//Checks whether the website that is being loaded is one of the options listed in the action controller
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		//Gets the url of the page that is being requested
		let url = navigationAction.request.url
		//Gets the host ie webdomain. For a given URL "https://google.com" the host/webdomain is google.com
		if let host = url?.host {
			for website in websites {
				if host.contains(website) {
					//If website is in our list of websites allow it to be loaded
					decisionHandler(.allow)
					return
				}
			}
		}
		//URL request is not in list of websites and therefore the page is not loaded
		decisionHandler(.cancel)
	}
}

