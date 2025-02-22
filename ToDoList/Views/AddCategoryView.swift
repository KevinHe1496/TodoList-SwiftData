import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    let categoriesIcons = ["house", "briefcase", "cart", "figure.mind.and.body", "book", "gamecontroller", "airplane", "gift"]
    @State var categorySelected = "house"
    
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
                                    .background(categorySelected == icon ? Color.blue.opacity(0.2) : Color.clear)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        categorySelected = icon
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
                        let category = Category(name: name)
                        modelContext.insert(category)
                        dismiss()
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
