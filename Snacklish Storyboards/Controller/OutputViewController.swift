//
//  OutputViewController.swift
//  Snacklish Storyboards
//
//  Created by Scott Odle on 1/10/22.
//

import UIKit

class OutputViewController: UIViewController {
    @IBOutlet weak var outputLabel: UILabel!
    
    var snackModel: Snack?
    
    override func viewWillAppear(_ animated: Bool) {
        if let outputText = snackModel?.snacklify() {
            outputLabel.text = outputText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = outputLabel.text
        
        let previousTint = sender.tintColor
        var previousTitle = "Copy"
        if let titleLabel = sender.titleLabel {
            if let titleText = titleLabel.text {
                previousTitle = titleText
            }
        }
        
        sender.tintColor = .green
        sender.setTitle("Copied!", for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.tintColor = previousTint
            sender.setTitle(previousTitle, for: .normal)
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        if let shareText = outputLabel.text {
            let shareItems = [shareText]
            let ac = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            present(ac, animated: true)
        }
    }
}
