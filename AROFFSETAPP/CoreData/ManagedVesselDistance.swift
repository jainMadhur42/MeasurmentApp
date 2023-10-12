//
//  ManagedVesselDistance.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

@objc(ManagedDistance)
class ManagedDistance: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var x1: Float
    @NSManaged var x2: Float
    @NSManaged var y1: Float
    @NSManaged var y2: Float
    @NSManaged var z1: Float
    @NSManaged var z2: Float
    @NSManaged var distance: Float
    @NSManaged var date: Date
    @NSManaged var vessel: ManagedVesselInfo
}

extension ManagedDistance {
    
    static func fetch(for vesselId: UUID, in context: NSManagedObjectContext) throws -> [ManagedDistance] {
        
        let request = NSFetchRequest<ManagedDistance>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "vessel.id == %@", vesselId as CVarArg)
        return try context.fetch(request)
    }
    
    func update(with localVesselDistance: LocalVesselDistance, in context: NSManagedObjectContext) throws {
        self.id =  localVesselDistance.id
        self.x1 = localVesselDistance.x1
        self.x2 = localVesselDistance.x2
        self.y1 = localVesselDistance.y1
        self.y2 = localVesselDistance.y2
        self.z1 = localVesselDistance.z1
        self.z2 = localVesselDistance.z2
        self.date = localVesselDistance.date
        self.distance = localVesselDistance.distance
        self.vessel = try ManagedVesselInfo.fetch(in: context).first!
        try context.save()
    }
}
