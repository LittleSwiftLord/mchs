import SwiftUI
import CoreData

struct RegistrationView: View {
    @Binding var showLoginView: Bool
    @Binding var showRegistrationView: Bool

    @State private var fullName: String = ""
    @State private var birthDate = Date()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var institution: Institution = .kindergarten
    @State private var group: String = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var groups: [String] {
        switch institution {
        case .kindergarten:
            return ["А-1", "Б-1"]
        case .school:
            return (1...11).map { "\($0)" }
        case .university:
            return ["ИСТ", "АУ", "ИБ", "ИВТ"]
        }
    }

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            TextField("ФИО", text: $fullName)
                         .padding()
                         .background(Color(.systemGray6))
                         .cornerRadius(5.0)
                         .padding(.horizontal, 20)
                         .frame(width: 390)
                     
            DatePicker("Дата рождения", selection: $birthDate, displayedComponents: .date)
                         .padding()
                         .background(Color(.systemGray6))
                         .cornerRadius(5.0)
                         .padding(.horizontal, 20)
                         .frame(width: 390)
            
            TextField("Имя пользователя", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .frame(width: 350)

            SecureField("Пароль", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .frame(width: 350)

            SecureField("Подтверждение пароля", text: $passwordConfirm)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .frame(width: 350)

            Picker("Тип учреждения", selection: $institution) {
                ForEach(Institution.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .padding(.bottom, 20)

            Picker("Группа/Класс", selection: $group) {
                ForEach(groups, id: \.self) { group in
                    Text(group).tag(group)
                }
            }
            .padding(.bottom, 20)

            Button(action: {
                registerUser()
            }) {
                Text("Зарегистрироваться")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5.0)

            Button(action: {
                showRegistrationView = false
                showLoginView = true
            }) {
                Text("Уже есть аккаунт? Войти")
            }
            .padding()
        }
    
        .padding()
        .ignoresSafeArea(.keyboard)
        .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
    }
    

    private func registerUser() {
        if password != passwordConfirm {
            alertTitle = "Ошибка"
                    alertMessage = "Введенные пароли не совпадают."
                    showingAlert = true
                    return
        }

        // Создание нового пользователя
        let newUser = AppUser(context: viewContext)
        newUser.username = username
        newUser.password = password
        newUser.institution = institution.rawValue
        newUser.group = group
        do {
            try viewContext.save()

            // В случае успешной регистрации, переключиться на представление входа
            showRegistrationView = false
            showLoginView = true
        } catch {
            // Обработка ошибок при сохранении
        }
    }
}
