//
//  TopViewController.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/15.
//

import UIKit

class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var allYumeList: [Yume] = []
    var addBarButtonItem: UIBarButtonItem!
    let viewModel = YumeViewModel()
    var doubleArray: [[Yume]] = [[]]
    var calendar = Calendar.current
    var targetDay = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        navigationItemSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItemSet()
        fetchData()
        makeDoubleArray(allYumeList: allYumeList)
    }
    
    func fetchData() {
        self.allYumeList = viewModel.fetchAllData()
        tableView.reloadData()
    }
    
    func deleteDate(title: String) {
        viewModel.deleteData(title: title)
        tableView.reloadData()
    }
    
    func navigationItemSet() {
        navigationItem.title = "目標"
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addBarButtonItem.tintColor = .systemPink
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    func makeDoubleArray(allYumeList: [Yume]) {
        for item in allYumeList {
            // カテゴリが既存の多重配列内に存在するかを検索
            if let index = doubleArray.firstIndex(where: { $0.first?.category == item.category }) {
                // 既存のカテゴリに追加
                doubleArray[index].append(item)
            } else {
                // 新しいカテゴリを作成して追加
                doubleArray.append([item])
            }
        }
    }
    
    @objc func addButtonTapped() {
        let storyBoard = UIStoryboard(name: "InputGoalViewController", bundle: nil)
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: "InputGoalViewController") as? InputGoalViewController else { return }
        self.navigationController?.show(nextViewController, sender: nil)
    }
    @IBAction func onTappedSegment(_ sender: Any) {
        tableView.reloadData()
    }
    
    // cellの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex != 1 {
            return allYumeList.count
        } else {
//            let category = getCategory(forSection: section)
//            let categoryItems = allYumeList.filter { $0.category == category }
            return doubleArray[section].count
        }
    }
    
    // cellの表示内容を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YumelistCell", for: indexPath) as? YumelistCell else { return UITableViewCell()}
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let segmentIndex = segment.selectedSegmentIndex
        switch segmentIndex {
        case 0:
            let sortedItems = allYumeList.sorted{
                $0.createDate < $1.createDate
            }
            cell.titleLabel.text = sortedItems[indexPath.row].title
            if sortedItems[indexPath.row].imageData != nil {
                cell.yumeImageView.image = UIImage(data: sortedItems[indexPath.row].imageData!)
            }
            let dateComponents = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: calendar.startOfDay(for: sortedItems[indexPath.row].limitDay))
            guard let limitDay = dateComponents.day else {return UITableViewCell()}
            cell.limitDayLabel.text = "期限は\(limitDay)日後"
        case 1:
            let item = doubleArray[indexPath.section][indexPath.row]
            cell.titleLabel.text = item.title
            if item.imageData != nil {
                cell.yumeImageView.image = UIImage(data: item.imageData!)
            }
            let dateComponents = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: calendar.startOfDay(for: item.limitDay))
            guard let limitDay = dateComponents.day else {return UITableViewCell()}
            cell.limitDayLabel.text = "期限は\(limitDay)日後"
        default:
            let sortedItems = allYumeList.sorted{
                $0.limitDay < $1.limitDay
            }
            cell.titleLabel.text = sortedItems[indexPath.row].title
            if sortedItems[indexPath.row].imageData != nil {
                cell.yumeImageView.image = UIImage(data: sortedItems[indexPath.row].imageData!)
            }
            let dateComponents = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: calendar.startOfDay(for: sortedItems[indexPath.row].limitDay))
            guard let limitDay = dateComponents.day else {return UITableViewCell()}
            cell.limitDayLabel.text = "期限は\(limitDay)日後"
        }
        return cell
    }
    // cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if allYumeList.count > 0,  segment.selectedSegmentIndex == 1{
            return getCategory(forSection: section)
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segment.selectedSegmentIndex != 1 {
            return 1
        } else {
            return doubleArray.count
        }
    }
    
    // セクション番号からカテゴリを取得する
    private func getCategory(forSection section: Int) -> String {
        let category = doubleArray[section].first?.category ?? ""
        return category
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive,
                                            title: "削除") { (action, view, completionHandler) in
                self.showAlert(deleteIndexPath: indexPath)
                completionHandler(true)
            }
            action.backgroundColor = .orange
            let configuration = UISwipeActionsConfiguration(actions: [action])
            return configuration
        }
        
        func showAlert(deleteIndexPath indexPath: IndexPath) {
            let dialog = UIAlertController(title: "注意",
                                           message: "本当に削除しますか？",
                                           preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "削除", style: .default, handler: { (_) in
                self.deleteDate(title: self.allYumeList[indexPath.row].title)
                self.allYumeList.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            dialog.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
    
}

