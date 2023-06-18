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
    var doubleArray: [[String]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        navigationItemSet()
        viewModel.deleteAllData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItemSet()
        fetchData()
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
        // カテゴリ
        for _ in 1..<Array(Set(allYumeList)).count {
            doubleArray.append([])
        }
        for yume in allYumeList {
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex != 1 {
            return allYumeList.count
        } else {
            for i in 1..<Array(Set(allYumeList)).count {
                
            }
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YumelistCell", for: indexPath) as? YumelistCell else { return UITableViewCell()}
        let segmentIndex = segment.selectedSegmentIndex
        switch segmentIndex {
        case 0:
            cell.titleLabel.text = allYumeList[indexPath.row].title
            if allYumeList[indexPath.row].imageData != nil {
                cell.yumeImageView.image = UIImage(data: allYumeList[indexPath.row].imageData!)
            }
            cell.limitLabel.text = allYumeList[indexPath.row].limitDay.toString()
        case 1:
            _ = allYumeList.sorted(by: {
                $0.category < $1.category
            })
            cell.titleLabel.text = allYumeList[indexPath.row].title
            if allYumeList[indexPath.row].imageData != nil {
                cell.yumeImageView.image = UIImage(data: allYumeList[indexPath.row].imageData!)
            }
            cell.limitLabel.text = allYumeList[indexPath.row].limitDay.toString()
        default:
            _ = allYumeList.sorted(by: {
                $0.limitDay.compare($1.limitDay) == .orderedAscending
            })
            cell.titleLabel.text = allYumeList[indexPath.row].title
            if allYumeList[indexPath.row].imageData != nil {
                cell.yumeImageView.image = UIImage(data: allYumeList[indexPath.row].imageData!)
            }
            cell.limitLabel.text = allYumeList[indexPath.row].limitDay.toString()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if allYumeList.count > 0,  segment.selectedSegmentIndex == 1{
            return allYumeList[section].category
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segment.selectedSegmentIndex != 1 {
            return 1
        } else {
            return Array(Set(allYumeList)).count
        }
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

