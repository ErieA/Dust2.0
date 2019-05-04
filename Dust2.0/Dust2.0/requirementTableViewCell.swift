//
//  requirementTableViewCell.swift
//  Dust2.0
//
//  Created by Erie M. Adames on 4/26/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import UIKit

class requirementTableViewCell: UITableViewCell {

    var subjectLabel : UILabel!
    var distLabel : UILabel!
    
    let padding : CGFloat = 8
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        subjectLabel = UILabel()
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subjectLabel)
        
        distLabel = UILabel()
        distLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(distLabel)
        
        setupConstraints()
        
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            subjectLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            subjectLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            distLabel.leftAnchor.constraint(equalTo: subjectLabel.rightAnchor, constant: padding),
            distLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
            ])
    }
    
    func configure(for course: Course) {
        subjectLabel.text = course.course
        var str : String = ""
        for var s in course.distributions {
            if s == "First-Year Writing Seminar." {
                s = "(FWS)"
            }
            if s != "" {
                if str != "" {
                    str = str + ", " + s
                } else {
                    str = s
                }
            }
        }
        distLabel.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
