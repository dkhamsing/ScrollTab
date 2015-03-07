//
//  ViewController.swift
//  Demo-Swift
//
//  Created by Daniel Khamsing on 3/6/15.
//
//

import UIKit

class ViewController: UIViewController, DKScrollingTabControllerDelegate {

    let tabController = DKScrollingTabController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tabController.delegate = self
        
        
        self.addChildViewController(tabController)
        tabController .didMoveToParentViewController(self)
        self.view.addSubview(tabController.view)
        tabController.view.frame = CGRectMake(0, 20, 320, 40)
        tabController.buttonPadding = 25
        tabController.selection = ["zero", "one", "two", "three", "four"]
    }
        
    func ScrollingTabController(controller: DKScrollingTabController!, selection: UInt) {
        print("tapped \(selection) \n")
    }

}

