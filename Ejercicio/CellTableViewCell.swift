//
//  CellTableViewCell.swift
//  Ejercicio
//
//  Created by Fabian Romero Sotelo on 10/18/18.
//  Copyright © 2018 Fabian Romero Sotelo. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var precio: UILabel!
    
    @IBOutlet weak var ubicacion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
