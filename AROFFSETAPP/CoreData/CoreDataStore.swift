//
//  CoreDataStore.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

public final class CoreDataStore {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "VesselStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }

    func insert(vesselDistance: LocalVesselDistance) {
        perform { context in
            do {
                let managedDistance = ManagedDistance(context: context)
                try managedDistance.update(with: vesselDistance, in: context)
            } catch let error {
                print("Error \(error)")
            }
        }
    }
    
    func insert(vesselInfo: LocalVesselInfo, completion: @escaping (Result<UUID, Error>) -> Void) {
        perform { context in
            do {
                let managedVesselInfo = ManagedVesselInfo(context: context)
                try managedVesselInfo.update(with: vesselInfo, completion: completion, in: context)
            } catch let error {
                print("Error \(error)")
            }
        }
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void) {
        perform { context in
            do {
                guard let managedVesselInfo =  try? ManagedVesselInfo.fetch(in: context) else {
                    
                    completion(.failure(NSError(domain: "Item not found", code: 123)))
                    return
                }
                completion(.success(managedVesselInfo.map {
                    LocalVesselInfo(id: $0.id
                                    , contactEmail: $0.contactEmail
                                    , contactPersonName: $0.contactPersonName
                                    , vesselName: $0.vesselName
                                    , organisation: $0.organisation)
                }))
            }
        }
    }
    
    func retrieve(for vesselId: UUID, completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        perform { context in
            do {
                guard let managedDistance =  try? ManagedDistance.fetch(for: vesselId, in: context) else {
                    
                    completion(.failure(NSError(domain: "Item not found", code: 123)))
                    return
                }
                completion(.success(managedDistance.map {
                    LocalVesselDistance(x1: $0.x1, x2: $0.x2, y1: $0.y1
                                        , y2: $0.y2
                                        , z1: $0.z1
                                        , z2: $0.z2
                                        , distance: $0.distance
                                        , date: $0.date
                                        , vesselId: $0.vessel.id)
                }))
            }
        }
    }
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
}
