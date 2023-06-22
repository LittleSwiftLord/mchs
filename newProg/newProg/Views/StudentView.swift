import SwiftUI

struct StudentView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var selectedTab: Int = 0 // для определения текущей вкладки
    @State private var selectedDate: Date = Date() // для выбора даты расписания
    @State private var selectedGroup: Group = .ist // для выбора группы

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack {
                    if let user = authManager.currentUser {
                        Text("Добро пожаловать, \(user.username ?? "")")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                    }
                    
                    VStack {
                        Picker("Выберите вашу группу", selection: $selectedGroup) {
                            ForEach(Group.allCases, id: \.self) { group in
                                Text(group.rawValue).tag(group)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 40)
                    
                        NavigationLink(destination: ScheduleView()) {
                                Text("Посетить страницу расписания")
                                
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.top, 20)
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("Главная", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Расписание")
            }.tag(0)

            NavigationView {
                VStack {
                    Text("Страница посещаемости")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    NavigationLink(destination: AttendanceView()) {
                        Text("Посетить страницу посещаемости")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    }
                }
                .navigationBarTitle("Посещаемость", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "checkmark.circle.fill")
                Text("Посещаемость")
            }.tag(1)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Профиль")
                }.tag(2)
        }
    }
}
