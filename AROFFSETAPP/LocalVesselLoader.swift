//
//  LocalVesselLoader.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

struct CoreDataVesselLoader: VesselDistanceLoader {
    
    let store: CoreDataStore = {
        
        return try! CoreDataStore(storeURL: NSPersistentContainer.defaultDirectoryURL()
            .appendingPathComponent("VesselStore.sqlite"))
    }()
    
    func insert(vesselDistance: LocalVesselDistance) {
        store.insert(vesselDistance: vesselDistance)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        store.retrieve(completion: completion)
    }
}

class LocalVesselLoader: VesselDistanceLoader {
    
    static var distances = [LocalVesselDistance]()
    
    func insert(vesselDistance: LocalVesselDistance) {
        LocalVesselLoader.distances.append(vesselDistance)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        completion(.success(LocalVesselLoader.distances))
    }
}
