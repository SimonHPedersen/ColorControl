//
//  ViewController.swift
//  ColorControl
//
//  Created by Simon Hem Pedersen on 08/11/15.
//  Copyright © 2015 Simon Hem Pedersen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let colors : [UIColor] = [UIColor.blueColor(), UIColor.redColor(), UIColor.yellowColor(), UIColor.greenColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func backward(sender: AnyObject) {
        self.view.backgroundColor = UIColor.blackColor()
    }

    @IBAction func forward(sender: AnyObject) {
                self.view.backgroundColor = UIColor.greenColor()
    }
    
    @IBAction func left(sender: AnyObject) {
                self.view.backgroundColor = UIColor.yellowColor()
    }
    
    @IBAction func stop(sender: AnyObject) {
        self.view.backgroundColor = UIColor.redColor()
    }

    @IBAction func right(sender: AnyObject) {
                self.view.backgroundColor = UIColor.blueColor()
    }

    @IBOutlet var colorLabel: UILabel!
}

