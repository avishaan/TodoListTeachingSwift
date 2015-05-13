//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Brown Magic on 3/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

// objc is necessary to make optional protocols
@objc protocol TaskDetailViewControllerDelegate {
  optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {
  
  var detailTaskModel:TaskModel!
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var subtaskTextField: UITextField!
  @IBOutlet weak var dueDatePicker: UIDatePicker!
  
  var delegate:TaskDetailViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // setup background color
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    
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
    // we will set the delegate as the View Controller
    delegate?.taskDetailEdited!()
  }
  
}
