//
//  LocalVesselLoader.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

protocol VesselDistanceLoader {
    
    func insert(vesselDistance: LocalVesselDistance)
    func retrieve(completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void)
}

protocol VesselInfoLoader {
    
    func insert(vesselInfo: LocalVesselInfo)
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
    
    func retrieve(completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        store.retrieve(completion: completion)
    }
}

extension CoreDataVesselLoader: VesselInfoLoader {
    
    func insert(vesselInfo: LocalVesselInfo) {
        store.insert(vesselInfo: vesselInfo)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void) {
        store.retrieve(completion: completion)
    }
}

struct LocalVesselLoader: VesselDistanceLoader {
    
    static var distances = [LocalVesselDistance]()
    static var vessels = [LocalVesselInfo]()
    
    func insert(vesselDistance: LocalVesselDistance) {
        LocalVesselLoader.distances.append(vesselDistance)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselDistance], Error>) -> Void) {
        completion(.success(LocalVesselLoader.distances))
    }
}

extension LocalVesselLoader: VesselInfoLoader {
    
    func insert(vesselInfo: LocalVesselInfo) {
        LocalVesselLoader.vessels.append(vesselInfo)
    }
    
    func retrieve(completion: @escaping (Result<[LocalVesselInfo], Error>) -> Void) {
        completion(.success(LocalVesselLoader.vessels))
    }
}
