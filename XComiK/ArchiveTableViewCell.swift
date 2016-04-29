//
//  ArchiveTableViewCell.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {
    
    var comic: Comic? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicNum: UILabel!
    @IBOutlet weak var comicDate: UILabel!
    @IBOutlet weak var comicAbstract: UILabel!
    
    func updateCell() {
        comicTitle.text = comic!.cTitle
        comicNum.text = "#\(comic!.cNum)"
        comicDate.text = comic!.displayDate()
        comicAbstract.text = comic!.cAltText
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
