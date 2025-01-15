//
//  RealmManager.swift
//  FoodFork
//
//  Created by Ivy Moon on 9/30/24.
//

import UIKit
import Realm
import RealmSwift

public class RealmManager {
    let realm = try! Realm()
    var token: NotificationToken?
    
    // 추가
    public func add(_ object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    //format : "name = %@,kim"
    public func search<T:Object>(type: T.Type, query: String) {
        let format = query.components(separatedBy: ",")
        
        // 모든 객체 얻기
        let list = realm.objects(type)

        // 필터링
        if let first = format.first, let last = format.last {
            let predicateQuery = NSPredicate(format: first, last) // 쿼리
        }
        
//        let result = savedShifts.list(predicateQuery)
    }
    
    // 업데이트
    public func update() {
        
    }
    
    // 삭제
    public func delete(_ object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    // 리스트 얻기
    public func getList<T:Object>(objcet: T.Type) -> [T] {
        let results = realm.objects(objcet.self)

        return Array(results)
    }
//    public func getList<T:Object>(objcet: T.Type, format: String? = nil, value: String? = nil) {
//        let objects = realm.objects(objcet.self)
//        
//        if let format = format, let value = value {
//            let predicateQuery = NSPredicate(format: format, value)
//            let result =
//        }
//    }
}

public class ForkDataManager: RealmManager {
    public static let main = ForkDataManager()
    
    override init() {
        super.init()
        
        let _ = loadForks()
    }
    
    public var objectForks: [ForkInfoObject] = []
    
    public func addFork(_ object: ForkInfoObject) {
        self.add(object)
        
        let _ = loadForks()
    }
    
    public func loadForks() -> [ForkInfoObject] {
        objectForks = self.getList(objcet: ForkInfoObject.self)

        return objectForks
    }
    
    public func deleteFork(_ uuid: String) {
        if let object = objectForks.first(where: { $0.uuid == uuid }) {
            self.delete(object)
            
            let _ = loadForks()
        }
    }
}
