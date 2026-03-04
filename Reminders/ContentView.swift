import SwiftUI

struct ContentView: View {
    @State private var isEditing: Bool = false
    @State private var page: RemindersPage = RemindersPage(
        title: "Todo List",
        items: [
            Reminder(title: "Get groceries"),
            Reminder(title: "Complete compilers lab"),
            Reminder(title: "Finish Cupboard ticket"),
            Reminder(title: "Feed Sugar Pig")
        ],
        color: .yellow
    )
    
    var body: some View {
        VStack {
            HStack {
                Text(page.title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(page.color)
                Spacer()
                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundStyle(page.color)
                }
            }
            .padding()
            
            List {
                ForEach($page.items) { $reminder in
                    HStack {
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(page.color)
                            .onTapGesture {
                                reminder.isCompleted.toggle()
                            }
                        TextField("New Reminder", text: $reminder.title)
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
                    page.items.append(Reminder(title: ""))
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(page.color)
                }
            }
            .padding()
        }
        .sheet(isPresented: $isEditing) {
            EditSheet(title: $page.title, selectedColor: $page.color)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
