//
//  CityCell.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/28/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var subjectLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }

}
