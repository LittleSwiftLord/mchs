import Foundation
import Combine
import CoreData

class AuthManager: ObservableObject {
    @Published var currentUser: AppUser?
    @Published var showAlert: Bool = false
    @Published var isLoggedIn: Bool = false
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        let user = fetchUserFromDatabase(username: username)
        
            if let user = user {
                if user.password == password {
                    currentUser = user
                    isLoggedIn = true
                    completion(true)
                } else {
                    showAlert = true
                    completion(false)
                }
            } else {
                showAlert = true
                completion(false)
            }
    }

    func logout() {
        currentUser = nil
    }
    
    private func fetchUserFromDatabase(username: String) -> AppUser? {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let fetchedResults = try viewContext.fetch(fetchRequest)
            return fetchedResults.first
        } catch {
            print("Ошибка при получении пользователя из базы данных: \(error.localizedDescription)")
            return nil
        }
    }

    func changePassword(newPassword: String) {
        guard let username = currentUser?.username else { return }
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let fetchedResults = try viewContext.fetch(fetchRequest)
            guard let user = fetchedResults.first else { return }
            user.password = newPassword
            try viewContext.save()
        } catch {
            print("Ошибка при изменении пароля: \(error.localizedDescription)")
        }
    }

    private func navigateToAdminView() {
        // Логика перехода на экран администратора
    }
    
    private func navigateToStudentView() {
        // Логика перехода на экран учащегося
    }
}
