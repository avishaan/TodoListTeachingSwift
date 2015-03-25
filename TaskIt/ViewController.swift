//
//  ViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 3/23/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
  // way to manage updates to table view
  var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
  // holds array of completed and uncompleted tasks
  var baseArray:[[TaskModel]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup
    
    fetchedResultsController = getFetchResultsController()
    fetchedResultsController.delegate = self
    fetchedResultsController.performFetch(nil)
  }
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
//    func sortByDate (taskOne: TaskModel, taskTwo: TaskModel) -> Bool {
//      return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//    }
//    
//    taskArray = taskArray.sorted(sortByDate)
    
    // below is alternative closure to the above
    baseArray[0] = baseArray[0].sorted {
      (taskOne: TaskModel, taskTwo: TaskModel) -> Bool in
      //comparison login here
      return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
    }
    
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
      let thisTask = baseArray[indexPath!.section][indexPath!.row]
      detailVC.mainVC = self
      detailVC.detailTaskModel = thisTask
    } else if segue.identifier == "showTaskAdd" {
      let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
      addTaskVC.mainVC = self
    }
  }
  
  @IBAction func addButtonTapped(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("showTaskAdd", sender: self)
  }
  // UITableViewDataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return baseArray.count
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // rows in section (completed/not completed)
    return baseArray[section].count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let thisTask = baseArray[indexPath.section][indexPath.row]
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
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 25
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Todo"
    } else {
      return "Completed"
    }
  }
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    let thisTask = baseArray[indexPath.section][indexPath.row]
    if indexPath.section == 0 {
      var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: true)
      baseArray[1].append(newTask)
    } else {
      var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: false)
      baseArray[0].append(newTask)
    }
    baseArray[indexPath.section].removeAtIndex(indexPath.row)
    tableView.reloadData()
  }
  
  // Helper
  
  // returns NSFetched Request with sort
  func taskFetchRequest() -> NSFetchRequest {
    let fetchRequest = NSFetchRequest(entityName: "TaskModel")
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    return fetchRequest
  }
  
  func getFetchResultsController() -> NSFetchedResultsController {
    fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
  }

}

