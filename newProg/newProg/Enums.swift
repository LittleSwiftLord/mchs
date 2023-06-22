
import Foundation


enum UserRole: String {
    case admin = "Admin"
    case student = "Student"
    case none = "None"
}

enum Weekday: String, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}


enum Institution: String, CaseIterable, Identifiable {
    case kindergarten = "Детский сад"
    case school = "Школа"
    case university = "Университет"
    
    var id: String { self.rawValue }
    
    var groups: [Group] {
        switch self {
        case .kindergarten:
            return [.a1, .b1]
        case .school:
            return Array(Group.schoolRange)
        case .university:
            return [.ist, .au, .ib, .ivt]
        }
    }
}



enum Group: String, CaseIterable, Identifiable {
    
    case a1 = "А-1"
    case b1 = "Б-1"
    case school1 = "1 класс", school2 = "2 класс", school3 = "3 класс", school4 = "4 класс",
         school5 = "5 класс", school6 = "6 класс", school7 = "7 класс", school8 = "8 класс",
         school9 = "9 класс", school10 = "10 класс", school11 = "11 класс"
    case ist = "ИСТ", au = "УТС", ib = "ИБ", ivt = "ИВТ"
    
    var id: String { self.rawValue }
    
    static var schoolRange: [Group] {
        return [.school1, .school2, .school3, .school4, .school5, .school6, .school7, .school8, .school9, .school10, .school11]
    }
}
    
    

//var schedule: [[Lesson]] {}
        


