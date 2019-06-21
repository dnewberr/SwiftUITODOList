//
//  ContentView.swift
//  SwiftUITODOList
//
//  Created by Deborah Newberry on 6/4/19.
//  Copyright © 2019 Deborah Newberry. All rights reserved.
//
import SwiftUI

struct TaskRow: View {
    @ObjectBinding var task: Task
    
    var body: some View {
        HStack(spacing: 20)  {
            Text(task.taskDescription)
//                .strikethrough(task.isComplete, color: Color.gray)
            Spacer()
            Text(task.dateToString())
//                .font(.footnote)
//                .strikethrough(task.isComplete, color: Color.gray)
//            Circle()
//                .fill(task.isComplete ? Color.green : Color.gray)
//                .frame(width: 20, height: 20)
            }
//            .foregroundColor(task.isComplete ? Color.gray : Color.black)
    }
}

struct TaskListView: View {
    @State var data: [Task]
    @State var newTaskDescription: String = ""
    
    var body: some View {
        return NavigationView {
            HStack {
                TextField($newTaskDescription, placeholder: Text("Add a new item")) .textFieldStyle(.roundedBorder)
                Button(action: {
                    self.createNewTask()
                }) {
                    VStack {
                        Text("+").bold()
                        }
                        .padding(10)
                        .background(Color.clear)
                        .overlay(Circle()
                            .stroke(isTextFieldValid() ? Color.blue : Color.gray))
                    }
                    .disabled(!isTextFieldValid())
                }
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 10)
            
            List {
                ForEach(data) { task in
                        TaskRow(task: task)
//                            .tapAction { todoItem.toggleStatus() }
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
                .navigationBarTitle(Text("ToDo List"), displayMode: .large)
                .navigationBarItems(trailing:  EditButton())
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
//            data.remove(at: first)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // sort the indexes low to high
        let reversedSource = source.sorted()
        
        // then loop from the back to avoid reordering problems
        for index in reversedSource.reversed() {
            // for each item, remove it and insert it at the destination
//            data.insert(data.remove(at: index), at: destination)
        }
    }
    
    func createNewTask() {
        guard isTextFieldValid() else { return }
//        data.append(Task(body: $newTaskDescription.value))
//        $newTaskDescription.value = ""
    }
    
    private func isTextFieldValid() -> Bool {
        return !$newTaskDescription.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
//
//#if DEBUG
//struct TaskListView_Previews : PreviewProvider {
//    static var previews: some View {
//        TaskListView(todoItemData: [Task(body: "Test")])
//    }
//}
//#endif
