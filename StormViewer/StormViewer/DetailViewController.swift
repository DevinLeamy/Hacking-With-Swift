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
