import SwiftUI

@main
struct newProgApp: App {
    let persistenceController = PersistenceController.shared
    let authManager = AuthManager(viewContext: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(authManager)
        }
    }
}
