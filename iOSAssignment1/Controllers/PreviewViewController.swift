//
//  PreviewViewController.swift
//  iOSAssignment1
//
//  Created by Kalbek Saduakassov on 18.01.2021.
//

import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var deadlineLabel: UILabel!
    @IBOutlet var progressSwitch: UISwitch!
    @IBOutlet weak var progressMessage: UILabel!

    
    public var object = ToDoItem()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        titleLabel.text = object.title
        subtitleLabel.text = object.subtitle
        deadlineLabel.text = df.string(from: object.deadLine ?? Date())
        progressMessage.text = object.isDone! ? "This task is done" : "This task is not done yet"
        progressMessage.textColor = object.isDone! ? .green : .systemOrange
    }
    
    
    @IBAction func progressDidMarked(_ sender: UISwitch) {
        
        if sender.isOn {
            object.isDone = true
            progressMessage.text = "This task is done"
            progressMessage.textColor = .green
        }
        else {
            object.isDone = false
            progressMessage.text = "This task is not done yet"
            progressMessage.textColor = .systemOrange
        }
       
    }
    
    
    
}
