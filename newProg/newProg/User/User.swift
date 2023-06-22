import Foundation
import CoreData

public class User: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var fullName: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var institution: String?
    @NSManaged public var group: String?
    @NSManaged public var role: String?
    @NSManaged public var attendances: NSSet?
    @NSManaged public var user: NSSet?
}

extension User {
    static func getAllUsers() -> NSFetchRequest<User> {
        let request: NSFetchRequest<User> = NSFetchRequest<User>(entityName: "User")
        request.sortDescriptors = []
        return request
    }
}
