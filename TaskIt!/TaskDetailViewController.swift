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
    
}
