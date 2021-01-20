//
//  EditViewController.swift
//  iOSAssignment1
//
//  Created by Kalbek Saduakassov on 18.01.2021.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newSubTitle: UITextField!
    @IBOutlet weak var newDeadline: UITextField!
    
    public var completionHandler: ((String?, String?, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveChanges(_ sender: Any) {
        completionHandler?(newTitle.text, newSubTitle.text, newDeadline.text)
        dismiss(animated: true, completion: nil)
    }
    
}
