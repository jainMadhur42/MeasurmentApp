//
//  LocalVesselLoader.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

protocol VesselDistanceLoader {
    
    func insert(vesselDistance: LocalVesselDistance)
    func retrieve(for vesselId: UUID, completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void)
}

protocol VesselInfoLoader {
    
    func insert(vesselInfo: LocalVesselInfo, completion: @escaping (Result<UUID, Error>) -> Void)
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void)
}


struct CoreDataVesselLoader: VesselDistanceLoader {
    
    let store: CoreDataStore = {
        
        return try! CoreDataStore(storeURL: NSPersistentContainer.defaultDirectoryURL()
            .appendingPathComponent("VesselStore.sqlite"))
    }()
    
    func insert(vesselDistance: LocalVesselDistance) {
        store.insert(vesselDistance: vesselDistance)
    }
    
    func retrieve(for vesselId: UUID, completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        store.retrieve(for: vesselId, completion: completion)
    }
}

extension CoreDataVesselLoader: VesselInfoLoader {
    
    func insert(vesselInfo: LocalVesselInfo, completion: @escaping (Result<UUID, Error>) -> Void) {
        store.insert(vesselInfo: vesselInfo, completion: completion)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void) {
        store.retrieve(completion: completion)
    }
}

struct LocalVesselLoader: VesselDistanceLoader {
    
    static var distances = [LocalVesselDistance]()
    static var vessels: [LocalVesselInfo] = [LocalVesselInfo(id: UUID()
                                                             , contactEmail: "madhur.jain@gmail.com"
                                                             , contactPersonName: "Madhur Jain"
                                                             , vesselName: "Madhur"
                                                             , organisation: "Madhur")]
    
    func insert(vesselDistance: LocalVesselDistance) {
        LocalVesselLoader.distances.append(vesselDistance)
    }
    
    func retrieve(for vesselId: UUID, completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        completion(.success(LocalVesselLoader.distances))
    }
}

extension LocalVesselLoader: VesselInfoLoader {
    
    func insert(vesselInfo: LocalVesselInfo, completion: (Result<UUID, Error>) -> Void) {
        LocalVesselLoader.vessels.append(vesselInfo)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void) {
        completion(.success(LocalVesselLoader.vessels))
    }
}
