//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 3/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
  
  var detailTaskModel:TaskModel!
  
  var mainVC: ViewController!
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var subtaskTextField: UITextField!
  @IBOutlet weak var dueDatePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.taskTextField.text = detailTaskModel.task
    self.subtaskTextField.text = detailTaskModel.subtask
    self.dueDatePicker.date = detailTaskModel.date
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  @IBAction func DoneButtonPressed(sender: UIBarButtonItem) {
    var task = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date)
    
    mainVC.taskArray[mainVC.tableView.indexPathForSelectedRow()!.row] = task
    
    self.navigationController?.popViewControllerAnimated(true)
  }
  
}
