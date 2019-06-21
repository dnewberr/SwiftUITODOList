//
//  ContentView.swift
//  SwiftUITODOList
//
//  Created by Deborah Newberry on 6/4/19.
//  Copyright © 2019 Deborah Newberry. All rights reserved.
//
import SwiftUI

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
            }
            .foregroundColor(todoItem.completed ? Color.gray : Color.black)
    }
}

struct TodoListView: View {
    @State var todoItemData: [TodoItem]
    @State var newTodoItemDescription: String = ""
    
    var body: some View {
        return NavigationView {
            HStack {
                TextField($newTodoItemDescription,
                          placeholder: Text("Add a new item"))
                Button(action: {
                    // Closure will be called once user taps your button
                    self.createNewTodoItem()
                }) {
                    Text("Add")
                }.disabled(!isTextFieldValid())
            }.padding(20)
            
            List {
                ForEach(todoItemData) { todoItem in
                    TodoItemRow(todoItem: todoItem)
                        .tapAction { todoItem.toggleStatus() }
                    }.onMove(perform: move)
                    .onDelete(perform: delete)
                }
                .navigationBarTitle(Text("ToDo List"), displayMode: .large)
                .navigationBarItems(trailing:  EditButton())
        }
    }
    
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            todoItemData.remove(at: first)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // sort the indexes low to high
        let reversedSource = source.sorted()
        
        // then loop from the back to avoid reordering problems
        for index in reversedSource.reversed() {
            // for each item, remove it and insert it at the destination
            todoItemData.insert(todoItemData.remove(at: index), at: destination)
        }
    }
    
    func createNewTodoItem() {
        guard isTextFieldValid() else { return }
        todoItemData.append(TodoItem(body: $newTodoItemDescription.value))
        $newTodoItemDescription.value = ""
    }
    
    private func isTextFieldValid() -> Bool {
        return !$newTodoItemDescription.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

#if DEBUG
struct TodoListView_Previews : PreviewProvider {
    static var previews: some View {
        TodoListView(todoItemData: [TodoItem(body: "Test")])
    }
}
#endif
