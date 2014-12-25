//
//  ViewController.swift
//  tips
//
//  Created by Syed, Afzal on 12/20/14.
//  Copyright (c) 2014 afzalsyed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do additional setup
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // if app is restarted and time from last bill update to restart 
        // is less than 10 minutes then display the last bill amount
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        
        if let start = defaults.objectForKey("lastUpdateTime") as NSDate? {
            let timeInterval: Double = NSDate().timeIntervalSinceDate(start)
            if timeInterval < 600 {
                let billAmount = defaults.doubleForKey("defaultBillAmount")
                // If there is no bill amount
                // leave bill field as blank instead of 0.0
                if billAmount != 0 {
                    billField.text = "\(billAmount)"
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        let tipSegLocation = defaults.integerForKey("defaultTipSegment")
        tipControl.selectedSegmentIndex = tipSegLocation
        updateBillAmount()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateBillAmount(){
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
      
        
        // create a tip Percentages array
        // which is used to get the tip percentage from tap
        let tipPercentages = [0.18, 0.2, 0.22]
        
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = (billField.text as NSString).doubleValue
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(billAmount, forKey: "defaultBillAmount")
        defaults.setObject(NSDate(), forKey: "lastUpdateTime")
        defaults.synchronize()
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        formatter.locale = NSLocale.currentLocale()
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateBillAmount()
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

