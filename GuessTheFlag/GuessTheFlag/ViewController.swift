//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Devin Leamy on 2020-03-15.
//  Copyright © 2020 Devin Leamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var button1: UIButton!
	
	@IBOutlet var button2: UIButton!
	
	@IBOutlet var button3: UIButton!
	
	@IBOutlet var scoreLbl: UILabel!
	var countries = [String]()
	var correctAnswer = 0
	var score = 0
	
	
	override func viewDidLoad() {
		// Do any additional setup after loading the view.
		super.viewDidLoad()
		countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		askQuestion()
		button1.layer.borderWidth = 3
		button2.layer.borderWidth = 3
		button3.layer.borderWidth = 3
//		button1.layer.borderColor = UIColor.lightGray.cgColor
//		button2.layer.borderColor = UIColor.lightGray.cgColor
//		button3.layer.borderColor = UIColor.lightGray.cgColor
	}
	//Sets the three buttons to three countries - the equivalent to posing a question
	func askQuestion(action: UIAlertAction! = nil) { //If no action is given action = nil
		//Shuffles the countries array so the countries listed are random
		countries.shuffle()
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		correctAnswer = Int.random(in: 0..<3)
		title = countries[correctAnswer].uppercased()
		scoreLbl.text = "Score: \(score)"
	}
	// Responds to button taps and rewards the player for correct answers
	@IBAction func buttonTapped(_ sender: UIButton) {
//		var title: String
		//Checks if the answer is correct
		if sender.tag == correctAnswer {
//			title = "Correct"
			score += 1
		} else {
//			title = "Wrong"
			score -= 1
		}
		askQuestion()
		
//		let alertController = UIAlertController(
//			title: title, message: "Your score is \(score).", preferredStyle: .alert
//		)
//		alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
//		present(alertController, animated: true)
	}
	
}

