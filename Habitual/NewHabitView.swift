//
//  NewHabitView.swift
//  Habitual
//
//  Created by Jesutofunmi Adewole on 23/07/2024.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) var dismiss

    @State private var habitTitle = ""
    @State private var habitDesc = ""
    @State private var habitSchedule = "Daily"
    
    var habits: Habits
    
    let schedule = ["Daily", "Weekly", "Monthly"]
     
    var body: some View {
        NavigationView {
            Form {
                Section ("Habit Detail")  {
                    TextField("Habit Title", text: $habitTitle)
                    TextField("Habit Description", text: $habitDesc)
                }
                Section ("Habit Schedule") {
                    Picker("Schedule", selection: $habitSchedule) {
                        ForEach(schedule, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let habit = Habit(title: habitTitle, description: habitDesc, schedule: habitSchedule)
                    habits.activities.append(habit)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NewHabitView(habits: Habits())
}
