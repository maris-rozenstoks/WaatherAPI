//
//  AppearanceViewController.swift
//  WaatherAPI
//
//  Created by maris.rozenstoks on 13/11/2023.
//

import UIKit

class AppearanceViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var openSettings: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
    }
    

    
   
    @IBAction func closeItemTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func setLabelText() {
        var labelText = "Unable to specify UI style"
        if traitCollection.userInterfaceStyle == .dark {
            labelText = "Dark Mode is On"
        } else {
            labelText = "Light Mode is On"
        }

        textLabel.text = labelText
    }
}

extension AppearanceViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setLabelText()
    }
}
