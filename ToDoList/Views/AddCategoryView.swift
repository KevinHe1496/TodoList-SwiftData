import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    let categoriesIcons = ["house", "briefcase", "cart", "figure.mind.and.body", "book", "gamecontroller", "airplane", "gift"]
    @State var iconSelected = "house"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Add Category", text: $name)
                
                Section("Select Category") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categoriesIcons, id: \.self) { icon in
                                Image(systemName: icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 33, height: 20) // Tamaño del ícono
                                    .padding()
                                    .background(iconSelected == icon ? Color.blue.opacity(0.2) : Color.clear)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        iconSelected = icon
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Category")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        do {
                            let category = Category(name: name, iconName: iconSelected)
                            modelContext.insert(category)
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Error al guardar el contexto: \(error)")
                        }
                        
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddCategoryView()
}
