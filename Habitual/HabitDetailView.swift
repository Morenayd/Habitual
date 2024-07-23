import SwiftUI

struct HabitDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var habits: Habits
    var habitIndex: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
                GridRow {
                    Text("Schedule:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(habits.activities[habitIndex].schedule)
                        .font(.body)
                        .foregroundColor(.black)
                }

                GridRow {
                    Text("Description:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(habits.activities[habitIndex].description)
                        .font(.body)
                        .foregroundColor(.black)
                }
                
                GridRow {
                    Text("Total Completion:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("\(habits.activities[habitIndex].totalCompletion)")
                        .font(.body)
                        .foregroundColor(.black)
                }
            }

            Spacer()

            HStack(spacing: 20) {
                Button {
                    habits.activities[habitIndex].totalCompletion += 1
                    //dismiss()
                } label: {
                    Text("Complete")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }

                Button {
                    if let index = habits.activities.firstIndex(where: { $0.id == habits.activities[habitIndex].id }) {
                                habits.activities.remove(at: index)
                            }
                    dismiss()
                } label: {
                    Text("Delete")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle(habits.activities[habitIndex].title)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habits: Habits(), habitIndex: 0)
            .preferredColorScheme(.light)
    }
}

