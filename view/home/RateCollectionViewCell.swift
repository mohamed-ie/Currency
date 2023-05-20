//
//  RateCollectionViewCell.swift
//  Currency
//
//  Created by Mohamed Ibrahim on 20/05/2023.
//

import UIKit

class RateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
    }
    
    func setValues(name: String, value: String){
        self.name.text = name
        self.value.text = value
    }

}
