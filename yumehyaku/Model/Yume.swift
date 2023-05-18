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
    @objc dynamic var limit: String = ""
    @objc dynamic var memo: String = ""
    @objc dynamic var createDate: String = ""
}

extension Yume {
    
    // realmにデータを保存
    static func addData(yume: Yume) {
        let realm = try! Realm()
        try! realm.write{
            realm.add(yume)
        }
    }
    // realmからデータを取得
    static func getAllWeightData() -> Results<Yume> {
//        let config = RealmSwift.Realm.Configuration(schemaVersion: 1)
//        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        var results: Results<Yume>
        results = realm.objects(Yume.self)
        return results
    }
}

