//
//  TodoItem.swift
//  SwiftUITODOList
//
//  Created by Deborah Newberry on 6/20/19.
//  Copyright © 2019 Deborah Newberry. All rights reserved.
//

import SwiftUI
import Combine

final class TodoItem: BindableObject {
    let didChange = PassthroughSubject<TodoItem, Never>()
    
    var id = UUID()
    let body: String
    let date: Date
    var completed: Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    init(body: String, date: Date = Date(), completed: Bool = false) {
        self.body = body
        self.date = date
        self.completed = completed
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func toggleStatus() {
        completed = !completed
    }
    
}
