//
//  ArchiveTableViewCell.swift
//  XComiK
//
//  Created by Luca Peduto on 24/04/16.
//  Copyright © 2016 Eloquent Bit. All rights reserved.
//

import UIKit
import ChameleonFramework

class ArchiveTableViewCell: UITableViewCell {
    
    var comic: Comic? {
        didSet {
            updateCell()
        }
    }
    
    override var highlighted: Bool {
        didSet {
            let selectedView = UIView()
            selectedView.backgroundColor = FlatWatermelon()
            selectedBackgroundView = selectedView
            comicTitle.highlightedTextColor = UIColor.whiteColor()
            comicNum.highlightedTextColor = UIColor.whiteColor()
            comicDate.highlightedTextColor = UIColor.whiteColor()
            comicAbstract.highlightedTextColor = UIColor.whiteColor()
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
