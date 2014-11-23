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

	var tasks:[TaskModel] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		let date1 = Date.from(year: 2014, month: 11, day: 26)
		let date2 = Date.from(year: 2014, month: 1, day: 1)
		let date3 = Date.from(year: 2014, month: 12, day: 25)

		let task1 = TaskModel(task: "Study French", subtask: "Verbs", date: date1)
		let task2 = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: date2)

		// Should really have a "task3" variable instead
		tasks = [task1, task2, TaskModel(task: "Gym", subtask: "Leg day", date: date3)]

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
			let thisTask = self.tasks[indexPath!.row]
			detailVC.detailTaskModel = thisTask
		}
	}

	// MARK: UITableViewDataSource

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let thisTask = self.tasks[indexPath.row]
		var cell: TaskCell = self.tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
		cell.taskLabel.text = thisTask.task
		cell.descriptionLabel.text = thisTask.subtask
		cell.dateLabel.text = Date.toString(date: thisTask.date)

		return cell
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.tasks.count
	}

	// MARK: UITableViewDelegate

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("showTaskDetail", sender: self)
	}
}

