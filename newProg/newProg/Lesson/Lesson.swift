import SwiftUI

struct Lesson: Hashable {
    let time: String
    let subject: String
}



struct ScheduleView: View {
    @State private var selectedInstitution = Institution.kindergarten
    @State private var selectedGroup = Group.a1
    @State private var selectedDate = Date()

    let schedule: [Group: [Lesson]] = [
         .a1: [Lesson(time: "9:00", subject: "Математика"), Lesson(time: "10:00", subject: "Русский язык")],
         .b1: [Lesson(time: "9:30", subject: "Физкультура"), Lesson(time: "10:30", subject: "Музыка")],
         .school1: [Lesson(time: "8:30", subject: "Математика"), Lesson(time: "9:30", subject: "Пиьсмо")],
         .school11: [Lesson(time: "8:30", subject: "Физика"), Lesson(time: "9:30", subject: "Алгебра")],
         .au: [Lesson(time: "8:00", subject: "Автоматизация"), Lesson(time: "9:30", subject: "МСПИС"),Lesson(time: "11:00", subject: "База данных")],
         .ist: [Lesson(time: "8:00", subject: "Метрология"), Lesson(time: "9:30", subject: "База данных"),Lesson(time: "10:30", subject: "Web-программирование")]
    ]
    
    var body: some View {
        VStack {
            DatePicker("Выберите дату", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(.horizontal)

            Picker("Выберите учреждение", selection: $selectedInstitution) {
                ForEach(Institution.allCases, id: \.self) { institution in
                    Text(institution.rawValue).tag(institution)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)

            Picker("Выберите группу", selection: $selectedGroup) {
                ForEach(selectedInstitution.groups, id: \.self) { group in
                    Text(group.rawValue).tag(group)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)

            Text("Расписание для \(selectedGroup.rawValue)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            let currentWeekday = Calendar.current.component(.weekday, from: selectedDate)
            let todaySchedule = schedule[selectedGroup] ?? []
            
            if todaySchedule.isEmpty {
                Text("Сегодня выходной")
            } else {
                ForEach(todaySchedule, id: \.self) { lesson in
                    LessonView(lesson: lesson)
                }
            }
        }
        .padding()
    }
}
