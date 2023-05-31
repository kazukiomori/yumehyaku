//
//  CategoryViewController.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/31.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    var categoryArray = ["未分類", "旅行", "自己啓発", "資格", "仕事", "健康・美容", "家族・恋人", "欲しいもの", "ライフスタイル"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = categoryArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vcNum = navigationController?.viewControllers.count else { return }
        if let controller = navigationController?.viewControllers[vcNum - 2] as? InputGoalViewController {
            controller.categoryButton.setTitle(categoryArray[indexPath.row], for: .normal) 
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

