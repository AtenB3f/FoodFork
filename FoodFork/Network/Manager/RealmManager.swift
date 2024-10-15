//
//  RealmManager.swift
//  FoodFork
//
//  Created by Ivy Moon on 9/30/24.
//

import Foundation
import Realm
import RealmSwift


class Dog: Object {
    // @Persisted -> 앱을 종료해도 유지되어야 할 때 사용하는 프로퍼티
    @Persisted var name: String
    @Persisted var age: Int
}

public final class RealmManager {
    
//    static let shared = RealmManager()
//    private init() {
//        
//    }
    
    let realm = try! Realm()
    var token: NotificationToken?
    
    // 추가
    public func add(_ object: Object) {
        try! realm.write {
            realm.add(object)
        }
        
        // 반응형
//        token = object.observe { change in
//            switch change {
//            case .change(let properties):
//                for property in properties {
//                    print("Property '\(property.name)' changed to '\(property.newValue!)'");
//                }
//            case .error(let error):
//                print("An error occurred: (error)")
//            case .deleted:
//                print("The object was deleted.")
//            }
//        }
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
        realm.delete(object)
    }
    
    // 리스트 얻기
    public func getList() {
        
    }
}
