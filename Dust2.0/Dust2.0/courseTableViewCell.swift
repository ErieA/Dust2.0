//
//  courseTableViewCell.swift
//  Dust2.0
//
//  Created by Erie M. Adames on 4/26/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import UIKit

class courseTableViewCell: UITableViewCell {

    var subjectLabel : UILabel!
    var numberLabel : UILabel!
    var semesterLabel : UILabel!
    var yearLabel : UILabel!
    
    let padding : CGFloat = 8
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        subjectLabel = UILabel()
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subjectLabel)
        
        numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(numberLabel)
        
        semesterLabel = UILabel()
        semesterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(semesterLabel)
        
        yearLabel = UILabel()
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(yearLabel)
        
        setupConstraints()
        
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            subjectLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            subjectLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            numberLabel.leftAnchor.constraint(equalTo: subjectLabel.rightAnchor, constant: padding),
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            semesterLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: padding),
            semesterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            yearLabel.leftAnchor.constraint(equalTo: semesterLabel.rightAnchor, constant: padding),
            yearLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding)
            ])
    }
    
    func configure(for course: Class) {
        subjectLabel.text = course.course
        numberLabel.text = String(course.courseNum)
        semesterLabel.text = course.getSem()
        yearLabel.text = String(course.yearTaken)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


