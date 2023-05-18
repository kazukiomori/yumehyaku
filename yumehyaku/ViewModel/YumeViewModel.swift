//
//  YumeViewModel.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/18.
//

import Foundation
import RealmSwift

class WeightViewModel {

    // WeightModelでrealmから取り出したデータをWeight型の配列にしてviewに渡す
    func fetchAllData() -> [Yume] {
        var yumeList: [Yume] = []
        let results = Yume.getAllWeightData()
        for result in results {
            let yume = Yume()
            yume.title = result.title
            yume.imageData = result.imageData
            yume.category = result.category
            yume.limit = result.limit
            yume.memo = result.memo
            yume.createDate = result.createDate
            yumeList.append(yume)
        }
        return yumeList
    }
    
    // viewで入力した値をWeight型の変数にまとめて、WeightModelでrealmに保存する
    func addData(title: String, image: UIImage?, category: String, limit: String, memo: String, createDate: String){
        let yume = Yume()
        yume.title = title
        if image != nil {
            yume.imageData = image!.pngData()
        }
        yume.category = category
        yume.limit = limit
        yume.memo = memo
        yume.createDate = createDate
        Yume.addData(yume: yume)
    }
}
