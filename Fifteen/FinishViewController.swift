//
//  FinishViewController.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 3/9/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    private var delegate : PlayerStatusDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerLabel.text = self.delegate.getPlayerName()
    }
    
    func prepareFromSegue(delegate : PlayerStatusDelegate){
        self.delegate = delegate
    }
    
    @IBAction func goHome(sender: AnyObject) {
        delegate.gameDidEnded()
    }
}
