import SwiftUI

struct EditSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var title: String
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button("Done") { dismiss() }
                    .fontWeight(.bold)
            }
            
            HStack {
                Image(systemName: "list.bullet.circle.fill")
                    .font(.system(size: 60))
                TextField("List Name", text: $title)
                    .font(.title)
                    .bold()
            }
            
            ColorChooser(selectedColor: $selectedColor)
            Spacer()
        }
        .foregroundStyle(selectedColor)
        .padding()
    }
}
