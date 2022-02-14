//
//  SwiftUIHostingViewController.swift
//  Snacklish
//
//  Created by Scott Odle on 2/13/22.
//

import UIKit
import SwiftUI

class SwiftUIHostingViewController: UIViewController {

    let contentView = UIHostingController(rootView: SnacklishView())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(contentView)
        view.addSubview(contentView.view)
        
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    }

}
