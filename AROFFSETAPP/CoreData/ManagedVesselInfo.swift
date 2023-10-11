//
//  ManagedVesselInfo.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

@objc(ManagedVesselInfo)
class ManagedVesselInfo: NSManagedObject {
    
    @NSManaged var id: UUID
    @NSManaged var contactEmail: String
    @NSManaged var contactPersonName: String
    @NSManaged var vesselName: String
    @NSManaged var organisation: String
}

extension ManagedVesselInfo {
    
    static func fetch(in context: NSManagedObjectContext) throws -> [ManagedVesselInfo] {
        
        let request = NSFetchRequest<ManagedVesselInfo>(entityName: entity().name!)
        return try context.fetch(request)
    }
    
    func update(with vesselInfo: LocalVesselInfo, in context: NSManagedObjectContext) throws {
        self.id = vesselInfo.id
        self.vesselName = vesselInfo.vesselName
        self.contactEmail = vesselInfo.contactEmail
        self.contactPersonName = vesselInfo.contactPersonName
        self.organisation = vesselInfo.organisation
        try context.save()
    }
}
