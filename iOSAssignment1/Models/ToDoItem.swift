//
//  ToDoItem.swift
//  iOSAssignment1
//
//  Created by Kalbek Saduakassov on 16.01.2021.
//

import Foundation




public class ToDoItem {
    static var id: Int? = 0
    var title: String?
    var subtitle: String?
    var deadLine: Date?
    var isDone: Bool?
    
    public init() {}
    
    public init(title: String) {
        ToDoItem.id! += 1
        self.title = title
        self.subtitle = "this is a subtitle of \(title)"
        deadLine = Date()
        isDone = false
    }
    
    public init(title: String, subtitle: String, deadline: Date) {
        ToDoItem.id! += 1
        self.title = title
        self.subtitle = subtitle
        self.deadLine = deadline
        isDone = false
    }
    
    
    
    
}
