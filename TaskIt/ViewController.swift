//
//  ViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 3/23/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  var taskArray:[TaskModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let date1 = Date.from(year: 2014, month: 05, day: 20)
    let date2 = Date.from(year: 2014, month: 03, day: 3)
    let date3 = Date.from(year: 2014, month: 12, day: 13)
    
    let task1:TaskModel = TaskModel(task: "Study French", subtask: "Verbs", date: date1)
    let task2:TaskModel = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: date2)
    
    taskArray = [task1, task2, TaskModel(task: "Gym", subtask: "Leg Day", date: date3)]
    
    self.tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // this is called right before segue is called right before the new view controller is presented on the screen
    
    if segue.identifier == "showTaskDetail" {
      let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let thisTask = taskArray[indexPath!.row]
      detailVC.detailTaskModel = thisTask
    }
  }
  
  @IBAction func addButtonTapped(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("showTaskAdd", sender: self)
  }
  // UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return taskArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let thisTask = taskArray[indexPath.row]
    var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
    
    cell.taskLabel.text = thisTask.task
    cell.descriptionLabel.text = thisTask.subtask
    cell.dateLabel.text = Date.toString(date: thisTask.date)
    
    return cell
  }
  
  // UITableViewDelegate
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // when we tap a specific row in the table view
    
    performSegueWithIdentifier("showTaskDetail", sender: self)

    
  }


}

