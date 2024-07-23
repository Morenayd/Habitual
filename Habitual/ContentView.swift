//
//  ContentView.swift
//  Habitual
//
//  Created by Jesutofunmi Adewole on 23/07/2024.
//

import SwiftUI

struct Habit: Codable, Identifiable {
    var id = UUID()
    
    let title: String
    let description: String
    let schedule: String
    var totalCompletion: Int = 0
    
    init(id: UUID = UUID(), title: String = "Sample Habit", description: String = "Description", schedule: String = "Daily", totalCompletion: Int = 0) {
        self.id = id
        self.title = title
        self.description = description
        self.schedule = schedule
        self.totalCompletion = totalCompletion
    }
}

@Observable
class Habits {
    var activities = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedActivities = try? JSONDecoder().decode([Habit].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        }
        activities = []
    }
}

struct ContentView: View {
    @State private var habits = Habits()
    
    var activities: [Habit] {
        habits.activities
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                VStack {
                    List {
                        ForEach(habits.activities.indices, id: \.self) { index in
                            NavigationLink {
                                HabitDetailView(habits: habits, habitIndex: index)
                            }
                        label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habits.activities[index].title)
                                    HStack(spacing: 1) {
                                        //                                        ForEach(0..<5) { index in
                                        //                                            Image(systemName: "star.fill")
                                        //                                                .foregroundColor( .yellow)
                                        //                                        }
                                        Text("Total: \(habits.activities[index].totalCompletion)")
                                            .foregroundStyle(.mint)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)                                    }
                                }
                                Spacer()
                                Image(systemName: "circle")
                                    .font(.system(size: 24))
                                    .foregroundColor(.green)
                            }
                        }
                        }
                    }
                    .overlay(
                        HStack {
                            NavigationLink {
                                NewHabitView(habits: habits)
                            } label: {
                                HStack {
                                    Image(systemName: "plus")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                    Text("Add New Habit")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }
                                .padding()
                                .background(Color.mint)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                            }
                        }
                            .padding(), alignment: .bottomTrailing
                    )
                }
            }
            .navigationTitle("Your Habits")
        }
    }
}

#Preview {
    ContentView()
}
