//
//  DataTableViewCell.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 08/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCheck2: UILabel!
    @IBOutlet weak var lblCheck: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
