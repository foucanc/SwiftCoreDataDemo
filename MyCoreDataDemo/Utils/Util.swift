//
//  Util.swift
//  MyCoreDataDemo
//
//  Created by Christophe Foucan on 08/06/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit

struct Color {
    static let PICKLED_BLUEWOOD = UIColor(red: 53/255.0, green: 73/255.0, blue: 94/255.0, alpha: 1.0)
}

class MyCustomTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.borderStyle = UITextBorderStyle.none
        
        // Set colors
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.lightGray
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        
        // Set size
        self.frame.size.height = 40
        self.font = .systemFont(ofSize: 16)
        
        // Set bottom line
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        borderLine.backgroundColor = UIColor.lightGray
        self.addSubview(borderLine)
    }
}

class MyCustomButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setTitleColor(Color.PICKLED_BLUEWOOD, for: .normal)
        self.layer.cornerRadius = 4
    }
}
