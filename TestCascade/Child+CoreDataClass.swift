import Foundation
import CoreData

@objc(Child)
public class Child: NSManagedObject, Decodable {

    enum DecodingError: Error {
        case someError
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Missing managed object context")
        }
        self.init(context: context)
        self.name = "Default name"
        throw DecodingError.someError
    }
}
