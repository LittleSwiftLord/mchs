import SwiftUI
import CoreData

struct AttendanceView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: AttendanceRecord.entity(),
        sortDescriptors: [],
        animation: .default
    ) var attendanceRecords: FetchedResults<AttendanceRecord>
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("Выберите дату", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(.horizontal)

            let currentWeekday = Calendar.current.component(.weekday, from: selectedDate)
            
            // Filter the attendance records for the selected date
            let todaysRecords = attendanceRecords.filter { Calendar.current.isDate($0.date ?? Date(), equalTo: selectedDate, toGranularity: .day) }
            
            if todaysRecords.isEmpty {
                Text("Нет записей о посещаемости для выбранной даты.")
            } else {
                ForEach(todaysRecords, id: \.id) { record in
                    VStack(alignment: .leading) {
                        Text(record.lesson?.subject ?? "")
                            .font(.headline)
                        
                        Text(record.lesson?.time ?? "")
                            .font(.subheadline)
                        
                        Text(record.attendance?.isPresent == true ? "Присутствовал" : "Отсутствовал")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
    }
}
