//
//  ViewController.swift
//  TaskIt!
//
//  Created by Scott Brady on 11/11/14.
//  Copyright (c) 2014 Spider Monkey Tech. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

	@IBOutlet weak var tableView: UITableView!
	
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		self.fetchedResultsController = getFetchedResultsController()
		self.fetchedResultsController.delegate = self
		self.fetchedResultsController.performFetch(nil)
    }

	// For this project, this isn't needed, as iOS8 appears to automaticallly refresh the table; this is showing an example of how to do it in other cases
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "showTaskDetail") {
			let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
			let indexPath = self.tableView.indexPathForSelectedRow()
			let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
			detailVC.detailTaskModel = thisTask
		}
		else if (segue.identifier == "showTaskAdd") {
			let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
		}
	}

	// MARK: IBActions
	@IBAction func addButtonTapped(sender: UIBarButtonItem) {
		self.performSegueWithIdentifier("showTaskAdd", sender: self)
	}

	// MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
		
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
		let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        if (indexPath.section == 0) {
			thisTask.isComplete = true
        }
        else {
            thisTask.isComplete = false
        }
		(UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
	}
	
	// MARK: NSFetchedResultsControllerDelegate
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		self.tableView.reloadData()
	}
    
    // MARK: Helper functions
	
	func taskFetchRequest() -> NSFetchRequest {
		let fetchRequest = NSFetchRequest(entityName: "TaskModel")
		let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
		let isCompleteSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
		fetchRequest.sortDescriptors = [isCompleteSortDescriptor,sortDescriptor]
		
		return fetchRequest
	}
	
	func getFetchedResultsController() -> NSFetchedResultsController {
		self.fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
		
		return fetchedResultsController
	}
}

