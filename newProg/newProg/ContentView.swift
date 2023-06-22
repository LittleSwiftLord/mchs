import SwiftUI

struct ContentView: View {
    // Переменные состояния для определения текущего отображаемого представления
    @State private var showLoginView: Bool = true
    @State private var showRegistrationView: Bool = false

    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        VStack {
            if authManager.isLoggedIn {
                StudentView()
            } else {
                if showLoginView {
                    LoginView(showLoginView: $showLoginView, showRegistrationView: $showRegistrationView)
                } else if showRegistrationView {
                    RegistrationView(showLoginView: $showLoginView, showRegistrationView: $showRegistrationView)
                }
            }
        }
    }
}
