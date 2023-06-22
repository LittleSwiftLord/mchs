import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username: String = ""
    @State private var password: String = ""

    @Binding var showLoginView: Bool
    @Binding var showRegistrationView: Bool

    @State private var showError: Bool = false
    @State private var errorString: String = ""
    @State private var showStudentView: Bool = false
    @State private var showAdminView: Bool = false

    var body: some View {
        VStack {
            Text("Войти")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            TextField("Имя пользователя", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Пароль", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button("Войти") {
                loginUser()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5.0)
            .fullScreenCover(isPresented: $showStudentView) {
                StudentView()
            }
            .fullScreenCover(isPresented: $showAdminView) {
                AdminView()
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Ошибка"), message: Text(errorString), dismissButton: .default(Text("OK")))
            }
            
            Button(action: {
                showLoginView = false
                showRegistrationView = true
            }) {
                Text("Зарегистрироваться")
                    .foregroundColor(.blue)
            }

        }
        .padding()
    }

    private func loginUser() {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let fetchedUsers = try viewContext.fetch(fetchRequest)

            if fetchedUsers.count == 1 {
                let user = fetchedUsers.first!
                if user.role == "admin" {
                    showAdminView = true
                } else {
                    showStudentView = true
                }
            } else {
                print("Ошибка: найдено \(fetchedUsers.count) пользователей с введенными именем пользователя и паролем")
                showError = true
                errorString = "Неправильное имя пользователя или пароль"
            }
        } catch {
            print("Ошибка при выполнении fetch запроса: \(error)")
            showError = true
            errorString = "Произошла ошибка при попытке входа"
        }
    }
}
