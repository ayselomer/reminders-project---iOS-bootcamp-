import SwiftUI

struct ContentView: View {
    @State private var isEditing: Bool = false
    @State private var page: RemindersPage = RemindersPage(
        title: "Todo List",
        items: [
            Reminder(title: "Complete Optimization HW", description: "MATH 560 no fun :(", date: Date().addingTimeInterval(604800)),
            Reminder(title: "Go to gym", description: "It's a healthy habit.", date: Date().addingTimeInterval(3600))
        ],
        color: .yellow
    )
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(page.title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(page.color)
                    Spacer()
                }
                .padding(.horizontal)
                
                List {
                    ForEach($page.items) { $reminder in
                        NavigationLink {
                            ReminderDetailView(title: $reminder.title, description: $reminder.description, date: $reminder.date, color: $page.color)
                        } label: {
                            HStack {
                                Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(page.color)
                                    .onTapGesture { reminder.isCompleted.toggle() }
                                    .buttonStyle(.borderless)
                                
                                VStack(alignment: .leading) {
                                    Text(reminder.title)
                                        .foregroundStyle(reminder.isCompleted ? .gray : .primary)
                                    
                                    if reminder.isCompleted {
                                        Text("Completed")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    } else {
                                        Text(reminder.date, style: .relative)
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        page.items.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
                
                HStack {
                    Spacer()
                    Button {
                        page.items.append(Reminder(title: "", description: "", date: Date()))
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(page.color)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { isEditing = true } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(page.color)
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                EditSheet(title: $page.title, selectedColor: $page.color)
            }
        }
    }
}
#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
