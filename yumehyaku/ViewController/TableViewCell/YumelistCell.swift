//
//  YumelistCell.swift
//  yumehyaku
//
//  Created by Kazuki Omori on 2023/05/18.
//

import UIKit

class YumelistCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var yumeImageView: UIImageView!
    @IBOutlet weak var limitDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
