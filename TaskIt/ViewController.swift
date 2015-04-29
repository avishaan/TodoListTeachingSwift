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
      let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
      detailVC.detailTaskModel = thisTask
    } else if segue.identifier == "showTaskAdd" {
      let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
    }
  }
  
  @IBAction func addButtonTapped(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("showTaskAdd", sender: self)
  }
  // UITableViewDataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return fetchedResultsController.sections!.count
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // rows in section (completed/not completed)
    return fetchedResultsController.sections![section].numberOfObjects
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
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
    // what if there is only one section in the controller
    if fetchedResultsController.sections?.count == 1 {
      // check that single object to see if it's done
      let fetchedObjects = fetchedResultsController.fetchedObjects!
      let testTask:TaskModel = fetchedObjects[0] as TaskModel
      if testTask.completed == true {
        return "Completed"
      } else {
        return "Todo"
      }
    } else {
      
      if section == 0 {
        return "Todo"
      } else {
        return "Completed"
      }
    }
  }
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
    // flip completion instead of checking the section the item is in
    if thisTask.completed == true {
      thisTask.completed = false
    } else {
      thisTask.completed = true
    }
    (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
  }
  
  // called automatically when we make changes to our entities
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.reloadData()
  }
  
  // Helper
  
  // returns NSFetched Request with sort
  func taskFetchRequest() -> NSFetchRequest {
    let fetchRequest = NSFetchRequest(entityName: "TaskModel")
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
    let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
    fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
    return fetchRequest
  }
  
  func getFetchResultsController() -> NSFetchedResultsController {
    fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
    return fetchedResultsController
  }

}

