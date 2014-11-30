//
//  ViewController.swift
//  TaskIt!
//
//  Created by Scott Brady on 11/11/14.
//  Copyright (c) 2014 Spider Monkey Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!

	var allTasks:[[TaskModel]] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

/*
		let date1 = Date.from(year: 2014, month: 11, day: 26)
		let date2 = Date.from(year: 2014, month: 1, day: 1)
		let date3 = Date.from(year: 2014, month: 12, day: 25)

        let task1 = TaskModel(task: "Study French", subtask: "Verbs", date: date1, isComplete: false)
        let task2 = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: date2, isComplete: false)

		// Should really have a "task3" variable instead
        let incompleteTasks = [task1, task2, TaskModel(task: "Gym", subtask: "Leg day", date: date3, isComplete: false)]
        var completeTasks = [TaskModel(task: "Code", subtask: "Task Project", date: date2, isComplete: true)]

        self.allTasks = [incompleteTasks,completeTasks]
        
		// For this project, this isn't needed, as iOS8 appears to automaticallly refresh the table; this is showing an example of how to do it in other cases
		self.tableView.reloadData()
*/
    }

	// For this project, this isn't needed, as iOS8 appears to automaticallly refresh the table; this is showing an example of how to do it in other cases
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

        // Sort the tasks by date
        for (var i = 0; i < self.allTasks.count; ++i) {
            self.allTasks[i] = self.allTasks[i].sorted{
                (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
                // compariosn logic here
                return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
            }
            
        }

        self.tableView.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "showTaskDetail") {
			let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
			let indexPath = self.tableView.indexPathForSelectedRow()
			let thisTask = self.allTasks[indexPath!.section][indexPath!.row]
			detailVC.detailTaskModel = thisTask
			detailVC.mainVC = self
		}
		else if (segue.identifier == "showTaskAdd") {
			let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
			addTaskVC.mainVC = self
		}
	}

	// MARK: IBActions
	@IBAction func addButtonTapped(sender: UIBarButtonItem) {
		self.performSegueWithIdentifier("showTaskAdd", sender: self)
	}

	// MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.allTasks.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTasks[section].count
    }
    
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let thisTask = self.allTasks[indexPath.section][indexPath.row]
		var cell: TaskCell = self.tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
		cell.taskLabel.text = thisTask.task
		cell.descriptionLabel.text = thisTask.subtask
		cell.dateLabel.text = Date.toString(date: thisTask.date)

		return cell
	}

	// MARK: UITableViewDelegate

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("showTaskDetail", sender: self)
	}
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "To Do"
        }
        else {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = self.allTasks[indexPath.section][indexPath.row];
        var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isComplete: !thisTask.isComplete)
        var newSection:Int
        if (indexPath.section == 0) {
            newSection = 1
        }
        else {
            newSection = 0
        }
        self.allTasks[indexPath.section].removeAtIndex(indexPath.row)
        self.allTasks[newSection].append(newTask)
        tableView.reloadData()
    }
    
    // MARK: Helper functions
    
}

