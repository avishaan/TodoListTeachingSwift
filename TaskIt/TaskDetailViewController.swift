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
    
    let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    detailTaskModel.task = taskTextField.text
    detailTaskModel.subtask = subtaskTextField.text
    detailTaskModel.date = dueDatePicker.date
    detailTaskModel.completed = detailTaskModel.completed
    
    
    self.navigationController?.popViewControllerAnimated(true)
  }
  
}
