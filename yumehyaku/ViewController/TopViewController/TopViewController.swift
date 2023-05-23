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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        navigationItemSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItemSet()
    }
    
    func navigationItemSet() {
        navigationItem.title = "目標"
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addBarButtonItem.tintColor = .systemPink
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc func addButtonTapped() {
        let storyBoard = UIStoryboard(name: "InputGoalViewController", bundle: nil)
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: "InputGoalViewController") as? InputGoalViewController else { return }
        self.navigationController?.show(nextViewController, sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allYumeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YumelistCell", for: indexPath) as? YumelistCell else { return UITableViewCell()}
        cell.titleLabel.text = allYumeList[indexPath.row].title
        if allYumeList[indexPath.row].imageData != nil {
            cell.yumeImageView.image = UIImage(data: allYumeList[indexPath.row].imageData!)
        }
        cell.limitLabel.text = allYumeList[indexPath.row].limit
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

