//
//  YumeModel.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/18.
//

import UIKit
import RealmSwift

class Yume: Object {
    @objc dynamic var imageData: Data?
    @objc dynamic var title: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var limitDay: Date = Date()
    @objc dynamic var priolity: String = ""
    @objc dynamic var memo: String = ""
    @objc dynamic var createDate: Date = Date()
    @objc dynamic var id : String = NSUUID().uuidString
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Yume {
    
    // realmにデータを保存
    static func addData(yume: Yume) {
        let realm = try! Realm()
        try! realm.write{
            realm.add(yume, update: .modified)
        }
    }
    // realmからデータを取得
    static func getAllYumeData() -> Results<Yume> {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        var results: Results<Yume>
        results = realm.objects(Yume.self)
        return results
    }
    
    static func delete(title: String) {
        let realm = try! Realm()
        let result = realm.objects(Yume.self).filter("title == %@",title)
        try! realm.write {
            realm.delete(result)
        }
    }
    
    static func deleteAll() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        let result = realm.objects(Yume.self)
        try! realm.write {
            realm.delete(result)
        }
    }
}

