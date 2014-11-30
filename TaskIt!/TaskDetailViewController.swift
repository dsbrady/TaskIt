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
	var mainVC:ViewController!
	
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
        var task = TaskModel(task: self.taskTextField.text, subtask: self.subtaskTextField.text, date: self.dueDatePicker.date, isComplete: false)
		self.mainVC.allTasks[0][self.mainVC.tableView.indexPathForSelectedRow()!.row] = task
		self.navigationController?.popViewControllerAnimated(true)
	}
}
