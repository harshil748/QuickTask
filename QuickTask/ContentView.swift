//
//  ContentView.swift
//  QuickTask
//
//  Created by Harshil Patel on 29/04/25.
//

import SwiftUI
struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var isShowingAddTask = false
    @State private var newTaskTitle = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("QuickTask")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            if tasks.isEmpty {
                Text("No tasks yet.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(tasks.indices, id: \.self) { index in
                        HStack {
                            Image(systemName: tasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    tasks[index].isCompleted.toggle()
                                }
                                .foregroundColor(tasks[index].isCompleted ? .green : .gray)
                            
                            Text(tasks[index].title)
                                .strikethrough(tasks[index].isCompleted)
                                .foregroundColor(tasks[index].isCompleted ? .gray : .primary)
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            Button(action: {
                isShowingAddTask = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Task")
                }
                .foregroundColor(.blue)
            }
            .sheet(isPresented: $isShowingAddTask) {
                VStack(spacing: 20) {
                    Text("New Task")
                        .font(.headline)
                    
                    TextField("Enter task title", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    HStack {
                        Button("Cancel") {
                            isShowingAddTask = false
                            newTaskTitle = ""
                        }
                        
                        Spacer()
                        
                        Button("Save") {
                            let newTask = Task(title: newTaskTitle, isCompleted: false)
                            tasks.append(newTask)
                            isShowingAddTask = false
                            newTaskTitle = ""
                        }
                        .disabled(newTaskTitle.isEmpty)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
