import SwiftUI

struct EditSheet: View {
    @Binding var title: String
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
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

#Preview {
    @Previewable @State var title: String = "Todo List"
    @Previewable @State var selectedColor: Color = .red
    
    EditSheet(title: $title, selectedColor: $selectedColor)
        .preferredColorScheme(.dark)
}
