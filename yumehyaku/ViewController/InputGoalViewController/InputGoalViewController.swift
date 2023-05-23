//
//  InputGoalViewController.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/20.
//

import UIKit

class InputGoalViewController: UIViewController {
    
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
    
   
    @objc func saveButtonTapped() {
        viewModel.addData(title: <#T##String#>, image: <#T##UIImage?#>, category: <#T##String#>, limit: <#T##String#>, memo: <#T##String#>, createDate: <#T##String#>)
        
        messageAlert.shared.showSuccessMessage(title: NSLocalizedString("success", comment: ""), body: NSLocalizedString("successfullySavedMenu", comment: ""))
        self.navigationController?.popViewController(animated: false)
    }
}
