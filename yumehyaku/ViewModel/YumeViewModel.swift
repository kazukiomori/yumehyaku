//
//  YumeViewModel.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/18.
//

import Foundation
import RealmSwift

class YumeViewModel {

    // WeightModelでrealmから取り出したデータをWeight型の配列にしてviewに渡す
    func fetchAllData() -> [Yume] {
        var yumeList: [Yume] = []
        let results = Yume.getAllYumeData()
        for result in results {
            let yume = Yume()
            yume.title = result.title
            yume.imageData = result.imageData
            yume.priolity = result.priolity
            yume.category = result.category
            yume.limitDay = result.limitDay
            yume.memo = result.memo
            yume.createDate = result.createDate
            yumeList.append(yume)
        }
        return yumeList
    }
    
    // viewで入力した値をWeight型の変数にまとめて、WeightModelでrealmに保存する
    func addData(title: String, image: UIImage?, category: String, limitDay: Date, memo: String, createDate: Date){
        let yume = Yume()
        yume.title = title
        if image != nil {
            yume.imageData = image!.pngData()
        }
        yume.category = category
        yume.limitDay = limitDay
        yume.memo = memo
        yume.createDate = createDate
        Yume.addData(yume: yume)
    }
}
