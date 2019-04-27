//
//  ViewController.swift
//  Dust2.0
//
//  Created by Erie M. Adames on 4/26/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import UIKit
protocol cellUpdaterDelegate: class {
    func updateCell(index: Int, cell: courseTableViewCell, course: String, courseNum: Int, semester: String, year: Int)
}
class ViewController: UIViewController {
    var classLabel: UILabel!
    var yearLabel: UILabel!
    var semesterLabel: UILabel!
    var classNumLabel: UILabel!
    
    var classField: UITextField!
    var yearField: UITextField!
    var semesterField: UITextField!
    var classNumField: UITextField!
    
    var padding: CGFloat = 16
    
    var addButton: UIButton!
    var checkCoursesButton: UIButton!
    
    var courses: [Class] = []
    
    let cellReuseIdentifier = "addedClassReuseIdentifier"
    let cellHeight : CGFloat = 40
    var classTableView : UITableView!
    
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
        
        classTableView = UITableView(frame: .zero)
        classTableView.translatesAutoresizingMaskIntoConstraints = false
        classTableView.delegate = self
        classTableView.dataSource = self
        classTableView.register(courseTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(classTableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            classLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            classNumLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classNumLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            semesterLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            semesterLabel.topAnchor.constraint(equalTo: classNumLabel.bottomAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            yearLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            yearLabel.topAnchor.constraint(equalTo: semesterLabel.bottomAnchor, constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            classField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classField.topAnchor.constraint(equalTo: classLabel.topAnchor),
            classField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            classNumField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classNumField.topAnchor.constraint(equalTo: classNumLabel.topAnchor),
            classNumField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            semesterField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            semesterField.topAnchor.constraint(equalTo: semesterLabel.topAnchor),
            semesterField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            yearField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            yearField.topAnchor.constraint(equalTo: yearLabel.topAnchor),
            yearField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            classTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classTableView.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: padding),
            classTableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -padding)
            ])
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            addButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding)
            ])
        NSLayoutConstraint.activate([
            checkCoursesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            checkCoursesButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding)
            ])
    }
    
    @objc func classAdder() {
        let course = classField.text
        let classNum = classNumField.text
        let semester = semesterField.text
        let year = yearField.text
        if let c = course, c != "", let cn = classNum, cn != "", let s = semester, s != "", let y = year, y != ""{
            let newClass = Class(course: c, courseNum: 1101, yearTaken: 2018, semesterTaken: .FA)
            courses.append(newClass)
            classTableView.reloadData()
        } else {
            
        }
        
    }
    
    @objc func checkRequirements() {
        if !courses.isEmpty {
            var jsonObj : [Any] = []
            for course in courses {
                let jsonObjCourse : [String:Any] = [
                    "subject" : course.course,
                    "number" : course.courseNum,
                    "semester": course.getSem(),
                    "year" : course.yearTaken,
                ]
                jsonObj.append(jsonObjCourse)
            }
            let c1 = Course(course: "FA18 MATH 1920", distributions: ["(MQR-AS)","",""])
            let c2 = Course(course: "SP16 CS 1110", distributions: ["(MQR)","",""])
            let c3 = Course(course: "SP19 MUSIC 3480", distributions: ["CA-AS","(GB)",""])
            let c4 = Course(course: "SP19 INFO 3300", distributions: ["","",""])
            
            let data = Data(requirements: [c1,c2,c3,c4])
            let response = Response(success: true, data: data)
            let controller = requirementsViewController(response: response)
            navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource {
    
    /// Tell the table view how many rows should be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    /// Tell the table view what cell to display for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! courseTableViewCell
        
        let course = courses[indexPath.row]
        cell.configure(for: course)
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    /// Tell the table view what height to use for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    /// Tell the table view what should happen if we select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    /// Tell the table view what should happen if we deselect a row
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
}
extension ViewController: cellUpdaterDelegate {
    func updateCell(index: Int, cell: courseTableViewCell, course: String, courseNum: Int, semester: String, year: Int) {
    }
        
}

