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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
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

