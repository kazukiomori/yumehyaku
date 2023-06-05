//
//  InputGoalViewController.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/20.
//

import UIKit

class InputGoalViewController: UIViewController {
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDiscription: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    let viewModel = WeightViewModel()
    var saveBarButtonItem: UIBarButtonItem!
    var calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItemSet()
        setView()
    }
    
    func navigationItemSet() {
        navigationItem.title = "目標"
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButtonTapped))
        saveBarButtonItem.tintColor = .systemPink
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    func setView() {
        imageDiscription.numberOfLines = 0
        imageDiscription.text = "イラストを設定して、リストをより具体的にしましょう。"
        categoryButton.setTitleColor(.black, for: .normal)
        priorityButton.setTitleColor(.black, for: .normal)
        datePicker.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "CategoryViewController", bundle: nil)
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController else { return }
        self.navigationController?.show(nextViewController, sender: nil)
    }
    
    @IBAction func priorityButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "優先度を選択してください", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 表示させたいタイトル1ボタンが押された時の処理をクロージャ実装する
        let action1 = UIAlertAction(title: "高", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.priorityButton.setTitle("高", for: .normal)
        })
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let action2 = UIAlertAction(title: "中", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.priorityButton.setTitle("中", for: .normal)
        })
        let action3 = UIAlertAction(title: "低", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.priorityButton.setTitle("低", for: .normal)
        })
        
        // 閉じるボタンが押された時の処理をクロージャ実装する
        //UIAlertActionのスタイルがCancelなので赤く表示される
        let close = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
        })
        
        //UIAlertControllerにタイトル1ボタンとタイトル2ボタンと閉じるボタンをActionを追加
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(close)
        
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        formatter.timeZone = TimeZone(abbreviation: "JST")
        sender.timeZone = TimeZone(abbreviation: "JST")!
        calendar.timeZone = TimeZone(abbreviation: "JST")!
//        let currentDate = calendar.startOfDay(for: Date())
        let currentDate = Date()
        let targetDay = sender.date
        let dateComponents = calendar.dateComponents([.day], from: currentDate, to: targetDay)
        guard let limitDay = dateComponents.day else {return}
        limitLabel.text = "\(formatter.string(from: sender.date))  \(limitDay)日後"
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //        viewModel.addData(title: <#T##String#>, image: <#T##UIImage?#>, category: <#T##String#>, limit: <#T##String#>, memo: <#T##String#>, createDate: <#T##String#>)
                
                messageAlert.shared.showSuccessMessage(title: NSLocalizedString("success", comment: ""), body: NSLocalizedString("successfullySavedMenu", comment: ""))
                self.navigationController?.popViewController(animated: false)
            }

}
