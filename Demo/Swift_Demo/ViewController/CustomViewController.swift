//
//  CustomViewController.swift
//  Demo
//
//  Created by Iftekhar on 19/09/15.
//  Copyright © 2015 Iftekhar. All rights reserved.
//

class CustomViewController : UIViewController, UIPopoverPresentationControllerDelegate {
    
    private var returnHandler : IQKeyboardReturnKeyHandler!
    @IBOutlet private var settingsView : UIView!

    @IBOutlet private var switchDisableViewController : UISwitch!
    @IBOutlet private var switchEnableViewController : UISwitch!

    @IBOutlet private var switchDisableToolbar : UISwitch!
    @IBOutlet private var switchEnableToolbar : UISwitch!
    
    @IBOutlet private var switchDisableTouchResign : UISwitch!
    @IBOutlet private var switchEnableTouchResign : UISwitch!

    @IBOutlet private var switchAllowPreviousNext : UISwitch!

    @IBOutlet private var settingsTopConstraint : NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsView.layer.shadowColor = UIColor.black().cgColor
        settingsView.layer.shadowOffset = CGSize.zero
        settingsView.layer.shadowRadius = 5.0
        settingsView.layer.shadowOpacity = 0.5

        returnHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnHandler.lastTextFieldReturnKeyType = .done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switchDisableViewController.isOn = IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses.contains({ element in
            return element == CustomViewController.self
        })
        
        switchEnableViewController.isOn = IQKeyboardManager.sharedManager().enabledDistanceHandlingClasses.contains({ element in
            return element == CustomViewController.self
        })
        
        switchDisableToolbar.isOn = IQKeyboardManager.sharedManager().disabledToolbarClasses.contains({ element in
            return element == CustomViewController.self
        })
        switchEnableToolbar.isOn = IQKeyboardManager.sharedManager().enabledToolbarClasses.contains({ element in
            return element == CustomViewController.self
        })
        
        switchDisableTouchResign.isOn = IQKeyboardManager.sharedManager().disabledTouchResignedClasses.contains({ element in
            return element == CustomViewController.self
        })
        switchEnableTouchResign.isOn = IQKeyboardManager.sharedManager().enabledTouchResignedClasses.contains({ element in
            return element == CustomViewController.self
        })
        
        switchAllowPreviousNext.isOn = IQKeyboardManager.sharedManager().toolbarPreviousNextAllowedClasses.contains({ element in
            return element == IQPreviousNextView.self
        });
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {

            let animationCurve = UIViewAnimationOptions.init(rawValue: 7)
            let animationDuration : TimeInterval = 0.3;
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState.union(animationCurve), animations: { () -> Void in

                if self.settingsTopConstraint.constant != 0 {
                    self.settingsTopConstraint.constant = 0;
                } else {
                    self.settingsTopConstraint.constant = -self.settingsView.frame.size.height+30;
                }
                
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }) { (animated:Bool) -> Void in}
        }
    }

    @IBAction func disableInViewControllerAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        if sender.isOn {
            IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses.append(CustomViewController.self)
        }
        else {
            
            if let index = IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses.index(where: { element in
                return element == CustomViewController.self
            }) {
                IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses.remove(at: index)
            }
        }
    }
    
    @IBAction func enableInViewControllerAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        if sender.isOn {
            IQKeyboardManager.sharedManager().enabledDistanceHandlingClasses.append(CustomViewController.self)
        }
        else {
            
            if let index = IQKeyboardManager.sharedManager().enabledDistanceHandlingClasses.index(where: { element in
                return element == CustomViewController.self
            }) {
                IQKeyboardManager.sharedManager().enabledDistanceHandlingClasses.remove(at: index)
            }
        }
    }
    
    @IBAction func disableToolbarAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        if sender.isOn {
            IQKeyboardManager.sharedManager().disabledToolbarClasses.append(CustomViewController.self)
        }
        else {

            if let index = IQKeyboardManager.sharedManager().disabledToolbarClasses.index(where: { element in
                return element == CustomViewController.self
            }) {
                IQKeyboardManager.sharedManager().disabledToolbarClasses.remove(at: index)
            }
        }
    }
    
    @IBAction func enableToolbarAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        if sender.isOn {
            IQKeyboardManager.sharedManager().enabledToolbarClasses.append(CustomViewController.self)
        }
        else {
            if let index = IQKeyboardManager.sharedManager().enabledToolbarClasses.index(where: { element in
                return element == CustomViewController.self
            }) {
                IQKeyboardManager.sharedManager().enabledToolbarClasses.remove(at: index)
            }
        }
    }
    
    @IBAction func disableTouchOutsideAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        if sender.isOn {
            IQKeyboardManager.sharedManager().disabledTouchResignedClasses.append(CustomViewController.self)
        }
        else {
            if let index = IQKeyboardManager.sharedManager().disabledTouchResignedClasses.index(where: { element in
                return element == CustomViewController.self
            }) {
                IQKeyboardManager.sharedManager().disabledTouchResignedClasses.remove(at: index)
            }
        }
    }
    
    @IBAction func enableTouchOutsideAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        if sender.isOn {
            IQKeyboardManager.sharedManager().enabledTouchResignedClasses.append(CustomViewController.self)
        }
        else {
            
            if let index = IQKeyboardManager.sharedManager().enabledTouchResignedClasses.index(where: { element in
                return element == CustomViewController.self
            }) {
                IQKeyboardManager.sharedManager().enabledTouchResignedClasses.remove(at: index)
            }
        }
    }
    
    @IBAction func allowedPreviousNextAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        if sender.isOn {
            IQKeyboardManager.sharedManager().toolbarPreviousNextAllowedClasses.append(IQPreviousNextView.self)
        }
        else {
            
            if let index = IQKeyboardManager.sharedManager().toolbarPreviousNextAllowedClasses.index(where: { element in
                return element == IQPreviousNextView.self
            }) {
                IQKeyboardManager.sharedManager().toolbarPreviousNextAllowedClasses.remove(at: index)
            }
        }
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
