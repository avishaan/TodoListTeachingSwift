//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 3/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIButton) {
    // modal transition doesn't have access to navigationController so cant pop
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
