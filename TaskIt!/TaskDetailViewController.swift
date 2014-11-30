//
//  TaskDetailViewController.swift
//  TaskIt!
//
//  Created by Scott Brady on 11/22/14.
//  Copyright (c) 2014 Spider Monkey Tech. All rights reserved.
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

	// MARK: IBActions

	@IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
		self.navigationController?.popViewControllerAnimated(true)
	}

	@IBAction func doneButtonTapped(sender: UIBarButtonItem) {
		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
		
		self.detailTaskModel.task = self.taskTextField.text
		self.detailTaskModel.subtask = self.subtaskTextField.text
		self.detailTaskModel.date = self.dueDatePicker.date
		
		appDelegate.saveContext()
		
		self.navigationController?.popViewControllerAnimated(true)
	}
}
