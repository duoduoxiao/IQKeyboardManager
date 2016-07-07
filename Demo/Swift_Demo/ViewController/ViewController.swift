//
//  ViewController.swift
//  swift test
//
//  Created by Iftekhar on 22/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    @IBAction func shareClicked (_ sender : UIBarButtonItem) {
        
        let shareString : String = "IQKeyboardManager is really great control for iOS developer to manage keyboard-textField."
        let shareImage : UIImage = UIImage(named: "IQKeyboardManagerScreenshot")!
        let youtubeUrl : URL = URL(string: "http://youtu.be/6nhLw6hju2A")!
        
        var activityItems = [NSObject]()
        activityItems.append(shareString)
        activityItems.append(shareImage)
        activityItems.append(youtubeUrl)

        let excludedActivities = [String]()
        activityItems.append(UIActivityTypePrint)
        activityItems.append(UIActivityTypeCopyToPasteboard)
        activityItems.append(UIActivityTypeAssignToContact)
        activityItems.append(UIActivityTypeSaveToCameraRoll)
        
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        controller.excludedActivityTypes = excludedActivities
        present(controller, animated: true) { () -> Void in

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().toolbarManageBehaviour = IQAutoToolbarManageBehaviour.byPosition
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            
            if identifier == "SettingsNavigationController" {
                
                let controller = segue.destinationViewController
                
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
                
                let heightWidth = max(UIScreen.main().bounds.width, UIScreen.main().bounds.height);
                controller.preferredContentSize = CGSize(width: heightWidth, height: heightWidth)
                controller.popoverPresentationController?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        self.view.endEditing(true)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
}
