//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 5/3/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var capitalizeTableView: UITableView!
  @IBOutlet weak var completeNewTodoTableView: UITableView!
  @IBOutlet weak var versionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
