//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 3/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
  func addTask(message:String)
  func addTaskCanceled(message:String)
}

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var subtaskTextField: UITextField!
  @IBOutlet weak var dueDatePicker: UIDatePicker!
  
  var delegate:AddTaskViewControllerDelegate?
  
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
    // must dismiss view controller FIRST before the delegate otherwise this won't work
    delegate?.addTaskCanceled("Task was not added")
  }
  
  @IBAction func addTaskButtonTapped(sender: UIButton) {
    
    let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    let managedObjectContext = appDelegate.managedObjectContext
    let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
    let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
    
    // check if the user set autocapitalization in their settings
    if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
      task.task = taskTextField.text.capitalizedString
    } else {
      task.task = taskTextField.text
    }
    // check if the user set autocomplete new task in their settings
    if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
      task.completed = true
    } else {
      task.completed = false
    }
    
    task.subtask = subtaskTextField.text
    task.date = dueDatePicker.date
    
    appDelegate.saveContext()
    
    // request all instance of task model
    var request = NSFetchRequest(entityName: "TaskModel")
    
    var error:NSError? = nil
    
    var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
    
    for res in results {
      println(res)
    }
    
    // must dismiss view controller FIRST before the delegate otherwise this won't work
    self.dismissViewControllerAnimated(true, completion: nil)
    delegate?.addTask("Task Added")
  }
  
}
