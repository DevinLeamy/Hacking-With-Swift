//
//  ViewController.swift
//  StormViewer
//
//  Created by Devin Leamy on 2020-03-12.
//  Copyright © 2020 Devin Leamy. All rights reserved.
//

import UIKit

var pictures = [String]()
class ViewController: UITableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let fileManager = FileManager.default
		let path = Bundle.main.resourcePath!
		title = "Storm Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true
		let items = try! fileManager.contentsOfDirectory(atPath: path)
		for item in items {
			if item.hasPrefix("nssl") {
				pictures.append(item)
			}
		}
		print(pictures)
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictures.count
	}
	override func tableView(_ tableView:  UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		cell.textLabel?.text = pictures[indexPath.row]
		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//1: Try loading the "Detail" view controler and typecasting it to be a DetailViewController
		if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail")
			as? DetailViewController {
				//2: Successfully typecasted the returned viewController object to DetailViewController
				//Now, set its selectedImage property. Make it equal to the text in the desired row
				viewController.selectedImage = pictures[indexPath.row]
				//3: Now push it onto the navigation controller ie make it the viewed window
				navigationController?.pushViewController(viewController, animated: true)
		}
	}


}

