//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Devin Leamy on 2020-03-12.
//  Copyright © 2020 Devin Leamy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	var selectedImage: String?
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Storm #\(getImageNumberOf(image: selectedImage))"
		//Creates a rightBarButton for the navigationBar that when clicked will trigger the method shareTapped()
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action, target: self, action: #selector(shareTapped) //When using #selector the method inside will always have to have the @objc tag
		)
		//Prevents the navigationBar from inheriting large titles from the ViewController
		navigationItem.largeTitleDisplayMode = .never
		//Checks if there is a selected image
		if let imageToLoad = selectedImage {
			//If there is, set the UIImageView property or type UIImage to the selected image's url
			imageView.image = UIImage(named: imageToLoad)
		}
	}
	//Makes the navigation bar appear and disappear on tap
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
	
	//Allows photos to be shares to a varity of platforms
	@objc func shareTapped() {
		//Creates the activityViewController tool iOS uses to share content with other apps and services
		let activityViewController = UIActivityViewController(
			activityItems: [imageView.image!], applicationActivities: []
		)
		//Tells iOS where the activityViewController will be anchored (where it should appear from)
		activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(activityViewController, animated: true)
	}
	
	func getImageNumberOf(image imageTitle: String?) -> Int {
		for i in 0..<pictures.count {
			if (pictures[i] == imageTitle) {
				return i
			}
		}
		return -1
	}
	override var prefersHomeIndicatorAutoHidden: Bool {
		return navigationController?.hidesBarsOnTap ?? false
	}
}
