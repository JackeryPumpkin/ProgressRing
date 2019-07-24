//
//  ViewController.swift
//  UIGraph
//
//  Created by Zachary Duncan on 7/16/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var progressRing: ProgressRing!
    @IBOutlet weak var medsTakenLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    var medLog: [(CGFloat, Date)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressRing.minProgress = 0
        progressRing.maxProgress = 800
        progressRing.progress = 0
        progressRing.stepSize = 80
        medsTakenLabel.text = progressRing.progress.wholeNumberFormat()
    }

    @IBAction func add(_ sender: Any) {
        progressRing.increaseOneStep()
        medsTakenLabel.text = progressRing.progress.wholeNumberFormat()
        medLog.append((progressRing.stepSize, Date()))
        table.reloadData()
    }
    
    @IBAction func subtract(_ sender: Any) {
        progressRing.decreaseOneStep()
        medsTakenLabel.text = progressRing.progress.wholeNumberFormat()
        medLog.removeLast()
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medLog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = medLog[indexPath.row].0.wholeNumberFormat() + "mg  -  " + medLog[indexPath.row].1.localizedDescrition
        return cell
    }
}

