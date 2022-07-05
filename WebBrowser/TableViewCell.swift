//
//  TableViewCell.swift
//  WebBrowser
//
//  Created by Aigerim Abdurakhmanova on 05.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(with name: String) {
        labelText.text = name
    }
}
