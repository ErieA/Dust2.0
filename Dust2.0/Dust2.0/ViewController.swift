//
//  ViewController.swift
//  Dust2.0
//
//  Created by Erie M. Adames on 4/26/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var classLabel: UILabel!
    var yearLabel: UILabel!
    var semesterLabel: UILabel!
    var classNumLabel: UILabel!
    
    var classField: UITextField!
    var yearField: UITextField!
    var semesterField: UITextField!
    var classNumField: UITextField!
    
    var padding: CGFloat = 32
    
    var addButton: UIButton!
    var checkCoursesButton: UIButton!
    
    var courses: [Class] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        title = "Dust 2.0"
        
        classLabel = UILabel()
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.text = "Course Area:"
        view.addSubview(classLabel)
        
        yearLabel = UILabel()
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.text = "Year:"
        view.addSubview(yearLabel)
        
        classNumLabel = UILabel()
        classNumLabel.translatesAutoresizingMaskIntoConstraints = false
        classNumLabel.text = "Course Number:"
        view.addSubview(classNumLabel)
        
        semesterLabel = UILabel()
        semesterLabel.translatesAutoresizingMaskIntoConstraints = false
        semesterLabel.text = "Semester:"
        view.addSubview(semesterLabel)
        
        classField = UITextField()
        classField.translatesAutoresizingMaskIntoConstraints = false
        classField.isEnabled = true
        classField.borderStyle = .roundedRect
        view.addSubview(classField)

        classNumField = UITextField()
        classNumField.translatesAutoresizingMaskIntoConstraints = false
        classNumField.isEnabled = true
        classNumField.borderStyle = .roundedRect
        view.addSubview(classNumField)

        yearField = UITextField()
        yearField.translatesAutoresizingMaskIntoConstraints = false
        yearField.isEnabled = true
        yearField.borderStyle = .roundedRect
        view.addSubview(yearField)

        semesterField = UITextField()
        semesterField.translatesAutoresizingMaskIntoConstraints = false
        semesterField.isEnabled = true
        semesterField.borderStyle = .roundedRect
        view.addSubview(semesterField)

        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add Course", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(classAdder), for: .touchUpInside)
        view.addSubview(addButton)
        
        checkCoursesButton = UIButton()
        checkCoursesButton.translatesAutoresizingMaskIntoConstraints = false
        checkCoursesButton.setTitle("Check Requirements", for: .normal)
        checkCoursesButton.setTitleColor(.black, for: .normal)
        checkCoursesButton.addTarget(self, action: #selector(checkRequirements), for: .touchUpInside)
        view.addSubview(checkCoursesButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            classLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            classNumLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classNumLabel.topAnchor.constraint(equalTo: classLabel.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            semesterLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            semesterLabel.topAnchor.constraint(equalTo: classNumLabel.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            yearLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            yearLabel.topAnchor.constraint(equalTo: semesterLabel.topAnchor, constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            classField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            classField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            classNumField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classNumField.topAnchor.constraint(equalTo: classField.topAnchor, constant: padding),
            classNumField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            semesterField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            semesterField.topAnchor.constraint(equalTo: classNumField.topAnchor, constant: padding),
            semesterField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            yearField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            yearField.topAnchor.constraint(equalTo: semesterField.topAnchor, constant: padding),
            yearField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            addButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            checkCoursesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            checkCoursesButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: -padding)
            ])
    }
    
    @objc func classAdder() {
        let course = classField.text
        let classNum = classNumField.text
        let semester = semesterField.text
        let year = yearField.text
        if let c = course, let _ = classNum, let _ = semester, let _ = year {
            let newClass = Class(course: c, courseNum: 1101, yearTaken: 2018, semesterTaken: .FA)
            courses.append(newClass)
            print(courses)
        } else {
            
        }
        
    }
    
    @objc func checkRequirements() {
        if !courses.isEmpty {
            
        }
    }


}

