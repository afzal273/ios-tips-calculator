//
//  SettingsViewController.swift
//  tips
//
//  Created by Syed, Afzal on 12/21/14.
//  Copyright (c) 2014 afzalsyed. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipSetting: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissSettings(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onSelection(sender: UISegmentedControl) {
        let tipSegLocation = tipSetting.selectedSegmentIndex
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipSegLocation, forKey: "defaultTipSegment")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.lightGrayColor()
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipSegLocation = defaults.integerForKey("defaultTipSegment")
        tipSetting.selectedSegmentIndex = tipSegLocation
        
    }
    
}
