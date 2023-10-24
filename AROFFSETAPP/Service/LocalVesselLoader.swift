//
//  LocalVesselLoader.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

protocol VesselDistanceLoader {
    
    func insert(vesselDistance: LocalVesselDistance, completion: @escaping () -> Void)
    func delete(distance uuid: UUID, completion: @escaping (Error?) -> Void)
    func retrieve(for vesselId: UUID, completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void)
}

protocol VesselInfoLoader {
    
    func insert(vesselInfo: LocalVesselInfo, completion: @escaping (Result<UUID, Error>) -> Void)
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void)
    func delete(uuid: UUID, completion: @escaping (Error?) -> Void)
}


struct CoreDataVesselLoader: VesselDistanceLoader {
    
    let store: CoreDataStore = {
        
        return try! CoreDataStore(storeURL: NSPersistentContainer.defaultDirectoryURL()
            .appendingPathComponent("VesselStore.sqlite"))
    }()
    
    func insert(vesselDistance: LocalVesselDistance, completion: @escaping () -> Void) {
        store.insert(vesselDistance: vesselDistance)
    }
    
    func retrieve(for vesselId: UUID, completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        store.retrieve(for: vesselId, completion: completion)
    }
    
    func delete(distance uuid: UUID, completion: @escaping (Error?) -> Void) {
        store.delete(distance: uuid, completion: completion)
    }
    
}

extension CoreDataVesselLoader: VesselInfoLoader {
    
    
    func insert(vesselInfo: LocalVesselInfo, completion: @escaping (Result<UUID, Error>) -> Void) {
        store.insert(vesselInfo: vesselInfo, completion: completion)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void) {
        store.retrieve(completion: completion)
    }
    
    func delete(uuid: UUID, completion: @escaping (Error?) -> Void) {
        store.delete(vessel: uuid, completion: completion)
    }
}

struct LocalVesselLoader: VesselDistanceLoader {
    
    static var distances = [LocalVesselDistance]()
    static var vessels: [LocalVesselInfo] = [LocalVesselInfo(id: UUID()
                                                             , contactEmail: "madhur.jain@gmail.com"
                                                             , contactPersonName: "Madhur Jain"
                                                             , vesselName: "Madhur"
                                                             , organisation: "Madhur")]
    
    func insert(vesselDistance: LocalVesselDistance, completion: @escaping () -> Void) {
        LocalVesselLoader.distances.append(vesselDistance)
    }
    
    func retrieve(for vesselId: UUID, completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        completion(.success(LocalVesselLoader.distances))
    }
    
    func delete(distance uuid: UUID, completion: @escaping (Error?) -> Void) {
        
    }
    
}

extension LocalVesselLoader: VesselInfoLoader {
    
    func delete(uuid: UUID, completion: @escaping (Error?) -> Void) {
        LocalVesselLoader.vessels.removeAll {
            $0.id == uuid
        }
    }
    
    
    func insert(vesselInfo: LocalVesselInfo, completion: (Result<UUID, Error>) -> Void) {
        LocalVesselLoader.vessels.append(vesselInfo)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void) {
        completion(.success(LocalVesselLoader.vessels))
    }
}
