//
//  ManagedVesselInfo.swift
//  AROFFSETAPP
//
//  Created by Darshan on 11/10/23.
//

import CoreData

@objc(ManagedVesselInfo)
class ManagedVesselInfo: NSManagedObject {
    
    @NSManaged var id: UUID
    @NSManaged var contactEmail: String
    @NSManaged var contactPersonName: String
    @NSManaged var vesselName: String
    @NSManaged var organisation: String
    @NSManaged var distances: ManagedDistance
}

extension ManagedVesselInfo {
    
    static func fetch(vesselId: UUID? = nil,  in context: NSManagedObjectContext) throws -> [ManagedVesselInfo] {
        
        let request = NSFetchRequest<ManagedVesselInfo>(entityName: entity().name!)
        if let vesselId = vesselId {
            request.predicate = NSPredicate(format: "id == %@", vesselId as CVarArg)
        }
        return try context.fetch(request)
    }
    
    func update(with vesselInfo: LocalVesselInfo
                , completion: @escaping (Result<UUID, Error>) -> Void
                , in context: NSManagedObjectContext) throws {
        self.id = vesselInfo.id
        self.vesselName = vesselInfo.vesselName
        self.contactEmail = vesselInfo.contactEmail
        self.contactPersonName = vesselInfo.contactPersonName
        self.organisation = vesselInfo.organisation
        try context.save()
        completion(.success(vesselInfo.id))
    }
}
