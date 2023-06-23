//
//  InputGoalViewController.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/20.
//

import UIKit
import YPImagePicker

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
    let viewModel = YumeViewModel()
    var saveBarButtonItem: UIBarButtonItem!
    var calendar = Calendar.current
    var targetDay = Date()
    var isEditPage: Bool = false
    
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
        limitLabel.text = Date().toString()
        datePicker.minimumDate = Date()
        if imageView.image == nil {
            let defaultImage = UIImage(systemName: "photo")
            imageView.image = defaultImage
        }
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:))))
    }
    
    @objc func tappedImage(_ sender: UITapGestureRecognizer) {
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.library.maxNumberOfItems = 1
        
        let picker = YPImagePicker(configuration: config)
        picker.modalPresentationStyle = .fullScreen
        
        self.present(picker, animated: true, completion: nil)
        
        didFinishPickingMedia(picker)
    }
    
    func didFinishPickingMedia (_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: true, completion: nil)
            guard let selectedImage = items.singlePhoto?.image else {return}
            self.imageView.image = selectedImage
        }
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
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let dateComponents = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: calendar.startOfDay(for: sender.date))
        guard let limitDay = dateComponents.day else {return}
        limitLabel.text = "\(sender.date.toString())  \(limitDay)日後"
        targetDay = sender.date
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let yumeTitle = titleTextField.text, !yumeTitle.isEmpty else {
            messageAlert.shared.showErrorMessage(title: "エラー", body: "タイトルを入力してください。")
            return
        }
        
        guard let memo = memoTextView.text, !memo.isEmpty else {
            messageAlert.shared.showErrorMessage(title: "エラー", body: "メモを入力してください。")
            return
        }
        
        guard let category = categoryButton.currentTitle else { return }
        
        viewModel.addData(title: yumeTitle, image: imageView.image, category: category, limitDay: targetDay, memo: memo, createDate: Date())
        
        messageAlert.shared.showSuccessMessage(title: "成功", body: "登録に成功しました。")
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension InputGoalViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImageView else {return}
        self.imageView = selectedImage
    }
}
