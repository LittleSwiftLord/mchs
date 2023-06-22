import SwiftUI
import CoreData


struct ProfileView: View {
    @EnvironmentObject private var authManager: AuthManager
    @State private var newPassword: String = ""

    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 16) {
                Image("person.circle")  // Замените "user_placeholder" на имя файла вашего изображения-заполнителя
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())

                Text("Логин: satimov")
                    .font(.title)
                    .bold()
                
                Text("ФИО: Сатимов")
                    .font(.subheadline)

                Text("Группа: УТС")
                    .font(.subheadline)
                
                Text("Дата рождения: 02.08.2000")
                    .font(.subheadline)
                
                SecureField("Новый пароль", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top)

                Button(action: {
                    authManager.changePassword(newPassword: newPassword)
                    newPassword = ""
                }) {
                    Text("Сменить пароль")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    authManager.logout()
                }) {
                    Text("Выйти")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

