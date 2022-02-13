//
//  ViewController.swift
//  Snacklish Storyboards
//
//  Created by Scott Odle on 1/10/22.
//

import UIKit

class InputViewController: UIViewController {
    @IBOutlet weak var inputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOutput" {
            if let outputViewController = segue.destination as? OutputViewController {
                outputViewController.snackModel = Snack(input: inputTextView.text)
            }
        }
    }
}

