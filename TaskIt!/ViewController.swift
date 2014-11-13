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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: UITableViewDataSource

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		println(indexPath.row)
		var cell: TaskCell = self.tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
		return cell
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}

	// MARK: UITableViewDelegate

	func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
}

