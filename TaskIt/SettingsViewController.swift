//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 5/3/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var capitalizeTableView: UITableView!
  @IBOutlet weak var completeNewTodoTableView: UITableView!
  @IBOutlet weak var versionLabel: UILabel!
  
  let kVersionNumber = "1.0"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // add both delegate and datasource, alternatively you can do in storyboard
    self.capitalizeTableView.delegate = self
    self.capitalizeTableView.dataSource = self
    // we don't want our user to scroll this table view since the number of rows will be fixed
    self.capitalizeTableView.scrollEnabled = false
    
    self.completeNewTodoTableView.delegate = self
    self.completeNewTodoTableView.dataSource = self
    self.completeNewTodoTableView.scrollEnabled = false
    
    // update the title programmatically, alternatively could do in storyboard
    self.title = "Settings"
    
    self.versionLabel.text = kVersionNumber
    
    // override default back button since we are using the show segue so we know how we can override it and make a different text
    var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonItemPressed:"))
    // update left bar button item of our navigation
    self.navigationItem.leftBarButtonItem = doneButton
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func doneBarButtonItemPressed (barButtonItem: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  
}
