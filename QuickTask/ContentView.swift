//
//  ContentView.swift
//  QuickTask
//
//  Created by Harshil Patel on 29/04/25.
//

import SwiftUI
struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
struct ContentView: View {
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
    
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        }
    }
    @State private var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
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
                    ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    tasks[index].isCompleted.toggle()
                                }
                                .foregroundColor(task.isCompleted ? .green : .gray)
                            
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                                .foregroundColor(task.isCompleted ? .gray : .primary)
                        }
                    }
                    .onDelete { indexSet in
                        tasks.remove(atOffsets: indexSet)
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
        .onAppear {
            loadTasks()
        }
    }
}

#Preview {
    ContentView()
}
