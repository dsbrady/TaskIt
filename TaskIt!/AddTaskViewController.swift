//
//  AddTaskViewController.swift
//  TaskIt!
//
//  Created by Scott Brady on 11/23/14.
//  Copyright (c) 2014 Spider Monkey Tech. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

	var mainVC:ViewController!

	@IBOutlet weak var taskTextField: UITextField!
	@IBOutlet weak var subtaskTextField: UITextField!
	@IBOutlet weak var dueDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: IBActions

	@IBAction func cancelButtonTapped(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

	@IBAction func addTaskButtonTapped(sender: UIButton) {
        var task = TaskModel(task: self.taskTextField.text, subtask: self.subtaskTextField.text, date: self.dueDatePicker.date, isComplete: false)
		self.mainVC?.allTasks[0].append(task)
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
