//
//  AppearanceViewController.swift
//  WaatherAPI
//
//  Created by maris.rozenstoks on 13/11/2023.
//

import UIKit

class AppearanceViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
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

    @IBAction func openSettings(_ sender: Any) {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
}
