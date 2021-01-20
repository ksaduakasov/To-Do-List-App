//
//  SecondViewController.swift
//  iOSAssignment1
//
//  Created by Kalbek Saduakassov on 16.01.2021.
//

import UIKit

protocol SecondViewControllerDelegate {
    func removeItem (id: IndexPath) -> UIContextualAction
    func editItem(id: IndexPath) -> UIContextualAction
    func reviewItem(id: IndexPath)
}

class SecondViewController: ViewController {
    
    public var arr = [ToDoItem]()
    let cellId = "TableViewCell"
    
    var delegate: SecondViewControllerDelegate?
    
    //tableView outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        testDataConfigure()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        tableView.delegate = self
        tableView.dataSource = self
        self.configureTableView()
    }
    
    func testDataConfigure(){
        for i in 1...5 {
            arr.append(ToDoItem(title:"ToDo #\(i)"))
        }
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        delegate = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        
    }
    
    //sort items in ToDo
    @IBAction func sortItems(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = self.tableView.isEditing ? "Done" : "Sort"
    }
    
    //button that adds ToDo
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        
        let alert = UIAlertController(title: "Add your ToDo", message: "Please fill in all the fields", preferredStyle: .alert)
        alert.addTextField { (newTitle) in
            newTitle.placeholder = "Enter title of your ToDo"
        }
        
        alert.addTextField { (newSubTitle) in
            newSubTitle.placeholder = "Enter new subtitle of your ToDo"
        }
        alert.addTextField { (newDate) in
            newDate.placeholder = "Enter date in format 'dd-MM-yyyy'"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let output1 = alert.textFields![0].text else { return }
            guard let output2 = alert.textFields![1].text else { return }
            guard let output3 = alert.textFields![2].text else { return }
            self.arr.append(ToDoItem(title: output1, subtitle: output2, deadline: df.date(from: output3) ?? Date()))
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    
}


//tableView methods

//returns count
extension SecondViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    //returns table cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let item = arr[indexPath.row]
        cell.delegate = delegate
        cell.titleLabel.text = item.title
        cell.subTitleLabel.text = df.string(from: item.deadLine ?? Date())
        return cell
    }
    
    //swipeFromRight
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = delegate!.removeItem(id: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    //swipeFromLeft
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = delegate!.editItem(id: indexPath)
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate!.reviewItem(id: indexPath)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObj = arr[sourceIndexPath.row]
        arr.remove(at: sourceIndexPath.row)
        arr.insert(moveObj, at: sourceIndexPath.row)
        
    }
    
    
}

//SecondViewControllerDelegate methods
extension SecondViewController: SecondViewControllerDelegate {

    //edit item
    func editItem(id: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Edit") { [self] (action, view, completion) in
            let vc = storyboard?.instantiateViewController(identifier: "EditViewController") as! EditViewController
            vc.completionHandler = { newTitle, newSubTitle, newDeadline in
                let df = DateFormatter()
                df.dateFormat = "dd-MM-yyyy"
                self.arr[id.row].title = newTitle
                self.arr[id.row].subtitle = newSubTitle
                self.arr[id.row].deadLine = df.date(from: newDeadline!)
                self.tableView.reloadData()
            }
            present(vc, animated: true)
        }
        action.backgroundColor = .green
        
        return action
    }
    
    //remove item
    func removeItem(id: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completion) in
            arr.remove(at: id.row)
            tableView.deleteRows(at: [id], with: .none)
        }
        return action
        
    }
    
    //show item
    func reviewItem(id: IndexPath) {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        let vc = storyboard?.instantiateViewController(identifier: "PreviewViewController") as! PreviewViewController
        vc.object = ToDoItem(title:arr[id.row].title ?? "", subtitle: arr[id.row].subtitle ?? "",
                             deadline: arr[id.row].deadLine ?? Date())
//        vc.titleLabel.text = arr[id.row].title
//        vc.subtitleLabel.text = arr[id.row].subtitle
//        vc.deadlineLabel.text = df.string(from: arr[id.row].deadLine ?? Date())
        present(vc, animated: true)
    }
    
}






