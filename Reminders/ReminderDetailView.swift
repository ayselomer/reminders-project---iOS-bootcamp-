import SwiftUI

struct ReminderDetailView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var color: Color
    @State private var isEditing = false
   
    var body: some View {
        List {
            Section {
                Text(description)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Section("Title & Description") {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            
            Section("Date") {
                DatePicker("Date", selection: $date)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { isEditing = true } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditSheet(title: .constant("List Info"), selectedColor: $color)
        }
    }
}
