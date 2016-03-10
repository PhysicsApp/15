//
//  ViewController.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 09/03/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerTwoField: UITextField!
    @IBOutlet weak var playerOneField: UITextField!
    
    var playerOneName: String!
    var playerTwoName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.performSegueWithIdentifier("", sender: self)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! UINavigationController
        let master = destination.viewControllers.first as! MasterFifteenViewController
        master.prepareFromSegue(playerOneName, playerTwoName: playerTwoName)
    }

    @IBAction func setNames(sender: UIButton) {
        if(!playerOneField.text!.isEmpty){
            self.playerOneName = playerOneField.text!
        }
        else{
            self.playerOneName = playerOneField.placeholder!
        }
        
        if(!playerTwoField.text!.isEmpty){
            self.playerTwoName = playerTwoField.text!
        }
        else{
            self.playerTwoName = playerTwoField.placeholder!
        }
        
        if(playerOneName == playerTwoName){
            let alertController = UIAlertController(title: "Error", message:
                "Names can not be equal", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        super.performSegueWithIdentifier("navFromNames", sender: self)
        
    }
}

