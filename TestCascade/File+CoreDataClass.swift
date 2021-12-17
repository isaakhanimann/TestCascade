import Foundation
import CoreData

@objc(File)
public class File: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case children
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Missing managed object context")
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let throwableChildren = try container.decode(
            [Throwable<Child>].self,
            forKey: .children)
        let children = throwableChildren.compactMap { try? $0.result.get() }
        self.addToChildren(Set(children) as NSSet)
    }
}
