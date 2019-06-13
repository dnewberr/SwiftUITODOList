//
//  ContentView.swift
//  SwiftUITODOList
//
//  Created by Deborah Newberry on 6/4/19.
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
    
    func toggle() {
        completed = !completed
    }
    
}

struct TodoItemRow: View {
    @ObjectBinding var todoItem: TodoItem
    
    var body: some View {
        HStack {
            Text(todoItem.body)
                .strikethrough(todoItem.completed, color: Color.gray)
            Spacer()
            Text(todoItem.dateToString())
                .font(.footnote)
                .strikethrough(todoItem.completed, color: Color.gray)
            Circle()
                .fill(todoItem.completed ? Color.green : Color.gray)
                .frame(width: 20, height: 20)
            }.foregroundColor(todoItem.completed ? Color.gray : Color.black)
    }
}

struct TodoListView: View {
    var todoItemData: [TodoItem]
    var body: some View {
        return NavigationView {
            List(todoItemData) { todoItem in
                TodoItemRow(todoItem: todoItem)
                    .tapAction { todoItem.toggle() }
            }
            .navigationBarTitle(Text("ToDo List"), displayMode: .large)
            .navigationBarItems(trailing:  EditButton())

//            Button(action: {
//                print("tapped")
//            }) {
//                Text("Add")
//            }
        }
    }
    
    func delete() {
        // TODO
        print("Delete")
    }
    
    func move() {
        // TODO
    }
}

#if DEBUG
struct TodoListView_Previews : PreviewProvider {
    static var previews: some View {
        TodoListView(todoItemData: [TodoItem(body: "Test")])
    }
}
#endif
