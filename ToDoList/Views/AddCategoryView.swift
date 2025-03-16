import SwiftUI
import SwiftData
import UserNotifications

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
                    .accessibilityLabel("Enter the name of the category")
                
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
                                    .accessibilityLabel("Select \(icon) icon")
                                    .accessibilityHint("Tap to select this icon")
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
                            customNotification()
                            dismiss()
                        } catch {
                            print("Error al guardar el contexto: \(error)")
                        }
                        
                    }
                    .accessibilityLabel("Save category")
                    .accessibilityHint("Saves the category and goes back to the list")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityLabel("Cancel and go back")
                    .accessibilityHint("Discards changes and goes back to the previous screen")
                }
            }
        }
    }
    
    private func customNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Complete \(name)"
        content.subtitle = "You haven't completed all the tasks yet."
        
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    AddCategoryView()
}
