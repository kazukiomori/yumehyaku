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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigationItemSet() {
        navigationItem.title = "目標"
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButtonTapped))
        saveBarButtonItem.tintColor = .systemPink
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func priorityButtonTapped(_ sender: Any) {
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        //        viewModel.addData(title: <#T##String#>, image: <#T##UIImage?#>, category: <#T##String#>, limit: <#T##String#>, memo: <#T##String#>, createDate: <#T##String#>)
                
                messageAlert.shared.showSuccessMessage(title: NSLocalizedString("success", comment: ""), body: NSLocalizedString("successfullySavedMenu", comment: ""))
                self.navigationController?.popViewController(animated: false)
            }

}
