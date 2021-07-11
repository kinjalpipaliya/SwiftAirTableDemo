//
//  CodeTableViewCell.swift
//  AirTableExample
//
//  Created by Kinjal Pipaliya on 10/07/21.
//

import UIKit

class CodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contact: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
