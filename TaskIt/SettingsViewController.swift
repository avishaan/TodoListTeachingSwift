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
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if tableView == self.capitalizeTableView {
      // check which tableView is being called
      // create cel
      var capitalizeCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
      // check row
      if indexPath.row == 0 {
        // we are in first row
        capitalizeCell.textLabel?.text = "No do not Capitalize"
        
        // if we don't want to capitalize new tasks
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false {
          // show a checkmark
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
          
        } else {
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
        }
        
      } else {
        // indexPath row doesnt equal 1
        capitalizeCell.textLabel?.text = "Yes, Capitalize!"
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
        }
      }
      return capitalizeCell
    } else {
      // this means it is not capitalizeTableView, must be completeNewTodoTableView
      var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as UITableViewCell
      if indexPath.row == 0 {
        cell.textLabel?.text = "Do not complete Task"
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == false {
          cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
          cell.accessoryType = UITableViewCellAccessoryType.None
        }
      } else {
        cell.textLabel?.text = "Complete Task"
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
          cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
          cell.accessoryType = UITableViewCellAccessoryType.None
        }
      }
      return cell
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    // height for row
    return 30
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if tableView == self.capitalizeTableView {
      return "Capitalize New Task?"
    } else {
      return "Complete New Task"
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // we will set the settings here
    if tableView == self.capitalizeTableView {
      // settings for capitalize table view
      if indexPath.row == 0 {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
      } else {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
      }
    } else {
      // settings for complete new todo
      if indexPath.row == 0{
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewTodoKey)
      } else {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCompleteNewTodoKey)
      }
    }
    // we need to remember to save
    NSUserDefaults.standardUserDefaults().synchronize()
    // reload the data for the tableView
    tableView.reloadData()
  }
  
}
