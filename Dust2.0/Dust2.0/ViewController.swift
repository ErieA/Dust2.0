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
protocol fieldUpdatersProtocol {
    func update(_ clss: String, type: String)
    func currentYr() -> String
    func currentSem() -> String
}
class ViewController: UIViewController, fieldUpdatersProtocol {
    func update(_ clss: String, type: String) {
        if type == "Class" {
            self.currentClass = clss
        } else if type == "Year" {
            self.currentYear = Int(clss) ?? -1
        } else if type == "Semester" {
            self.currentSemester = clss
        }
    }
    func currentYr() -> String {
        return String(currentYear)
    }
    func currentSem() -> String{
        return currentSemester
    }
    
    var currentClass : String = ""
    var currentYear : Int = -1
    var currentSemester : String = ""
    var classLabel: UILabel!
    var yearLabel: UILabel!
    var semesterLabel: UILabel!
    var classNumLabel: UILabel!
    
    var classField: dropDown!
    var yearField: dropDown!
    var semesterField: dropDown!
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
        
        classNumField = UITextField()
        classNumField.translatesAutoresizingMaskIntoConstraints = false
        classNumField.isEnabled = true
        classNumField.delegate = self
        classNumField.layer.cornerRadius = 5
        classNumField.layer.borderWidth = 1
        classNumField.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(classNumField)
        
        addButton = UIButton()
        addButton.layer.cornerRadius = 5
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.gray.cgColor
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("  Add Course  ", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(classAdder), for: .touchUpInside)
        view.addSubview(addButton)
        
        checkCoursesButton = UIButton()
        checkCoursesButton.layer.cornerRadius = 5
        checkCoursesButton.layer.borderWidth = 1
        checkCoursesButton.layer.borderColor = UIColor.gray.cgColor
        checkCoursesButton.translatesAutoresizingMaskIntoConstraints = false
        checkCoursesButton.setTitle("  Check Requirements  ", for: .normal)
        checkCoursesButton.setTitleColor(.black, for: .normal)
        checkCoursesButton.addTarget(self, action: #selector(checkRequirements), for: .touchUpInside)
        view.addSubview(checkCoursesButton)
        
        classTableView = UITableView(frame: .zero)
        classTableView.translatesAutoresizingMaskIntoConstraints = false
        classTableView.delegate = self
        classTableView.dataSource = self
        classTableView.register(courseTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(classTableView)
        
        classField = dropDown(frame: CGRect(x: 0, y: 0, width: 0, height: 0), options: [], type: "Class")
        classField.layer.cornerRadius = 5
        classField.layer.borderWidth = 1
        classField.layer.borderColor = UIColor.gray.cgColor
        classField.updateDelegate = self
        classField.translatesAutoresizingMaskIntoConstraints = false
        classField.isEnabled = true
        classField.setTitle("Select Subject", for: .normal)
        classField.setTitleColor(.black, for: .normal)
        view.addSubview(classField)
        
        let semesterOptions = ["FA", "WI", "SP", "SU"]
        semesterField = dropDown(frame: CGRect(x: 0, y: 0, width: 0, height: 0), options: semesterOptions, type: "Semester")
        semesterField.layer.cornerRadius = 5
        semesterField.layer.borderWidth = 1
        semesterField.layer.borderColor = UIColor.gray.cgColor
        semesterField.updateDelegate = self
        semesterField.translatesAutoresizingMaskIntoConstraints = false
        semesterField.isEnabled = true
        semesterField.setTitle("Select Semester", for: .normal)
        semesterField.setTitleColor(.black, for: .normal)
        view.addSubview(semesterField)
        
        let yearOptions = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20"]
        yearField = dropDown(frame: CGRect(x: 0, y: 0, width: 0, height: 0), options: yearOptions.reversed(), type: "Year")
        yearField.layer.cornerRadius = 5
        yearField.layer.borderWidth = 1
        yearField.layer.borderColor = UIColor.gray.cgColor
        yearField.updateDelegate = self
        yearField.translatesAutoresizingMaskIntoConstraints = false
        yearField.isEnabled = true
        yearField.setTitle("Select Year", for: .normal)
        yearField.setTitleColor(.black, for: .normal)
        view.addSubview(yearField)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            yearLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            yearLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            yearField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            yearField.topAnchor.constraint(equalTo: yearLabel.topAnchor),
            yearField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            semesterLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            semesterLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            semesterField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            semesterField.topAnchor.constraint(equalTo: semesterLabel.topAnchor),
            semesterField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            classLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classLabel.topAnchor.constraint(equalTo: semesterLabel.bottomAnchor, constant: padding)
            ])
        NSLayoutConstraint.activate([
            classNumLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classNumLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            classField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classField.topAnchor.constraint(equalTo: classLabel.topAnchor),
            classField.widthAnchor.constraint(equalToConstant: 150)
            ])
        NSLayoutConstraint.activate([
            classNumField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classNumField.topAnchor.constraint(equalTo: classNumLabel.topAnchor),
            classNumField.widthAnchor.constraint(equalToConstant: 150),
            classNumField.heightAnchor.constraint(equalTo: classField.heightAnchor)
            ])
        
        
        NSLayoutConstraint.activate([
            classTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding),
            classTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding),
            classTableView.topAnchor.constraint(equalTo: classNumField.bottomAnchor, constant: padding),
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
        let course = currentClass
        let classNum = Int(classNumField.text ?? "-1") ?? -1
        let semester = currentSemester
        let year = currentYear
        if course != "", classNum != -1, semester != "", year != -1 {
            if semester == "FA" {
                let newClass = Class(course: course, courseNum: classNum, yearTaken: year, semesterTaken: .FA)
                if courses.firstIndex(of: newClass) == nil {
                    courses.append(newClass)
                    classTableView.reloadData()
                }
            } else if semester == "WI" {
                let newClass = Class(course: course, courseNum: classNum, yearTaken: year, semesterTaken: .WI)
                if courses.firstIndex(of: newClass) == nil {
                    courses.append(newClass)
                    classTableView.reloadData()
                }
            } else if semester == "SP" {
                let newClass = Class(course: course, courseNum: classNum, yearTaken: year, semesterTaken: .SP)
                if courses.firstIndex(of: newClass) == nil {
                    courses.append(newClass)
                    classTableView.reloadData()
                }
            } else {
                let newClass = Class(course: course, courseNum: classNum, yearTaken: year, semesterTaken: .SU)
                if courses.firstIndex(of: newClass) == nil {
                    courses.append(newClass)
                    classTableView.reloadData()
                }
            }
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
            let newjson : [String : Any] = [
                "courses" : jsonObj
            ]
            NetworkManager.checkRequirements(classes: newjson) { response in
                DispatchQueue.main.async {
                    let controller = requirementsViewController(response: response)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
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
        //DELETE HERE
    }
    
    /// Tell the table view what should happen if we deselect a row
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            courses.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
extension ViewController: cellUpdaterDelegate {
    func updateCell(index: Int, cell: courseTableViewCell, course: String, courseNum: Int, semester: String, year: Int) {
    }
        
}

extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == yearField || textField == classNumField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else {
            return true
        }
    }
}

protocol dropDownProtocol {
    func dropDownButtonPressed(str: String, type: String)
}

class dropDown : UIButton, dropDownProtocol {
    func dropDownButtonPressed(str: String, type: String) {
        self.setTitle(str, for: .normal)
        self.closeDropDown()
        updateDelegate.update(str, type: type)
    }
    
    
    var dropView : dropDownView!
    var height = NSLayoutConstraint()
    var isOpen = false
    var type : String!
    var updateDelegate : fieldUpdatersProtocol!
    
    init(frame: CGRect, options: [String], type: String) {
        super.init(frame: frame)
        self.type = type
        dropView = dropDownView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), options: options, type: type)
        dropView.delegate = self
        dropView.updateDelegate = updateDelegate
        dropView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        setupConstraints()
        self.superview?.bringSubviewToFront(dropView)
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dropView.rightAnchor.constraint(equalTo: self.rightAnchor),
            dropView.leftAnchor.constraint(equalTo: self.leftAnchor),
            dropView.topAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if updateDelegate.currentSem() != "" && updateDelegate.currentYr() != "-1"  && type == "Class" {
            let semester = updateDelegate.currentSem() + updateDelegate.currentYr()
            NetworkManager.getSemesterClasses(semester: semester) { (response) in
                self.dropView.updateOptions(newOptions: response.data)
            }
        }
        if isOpen {
            isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5) {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }
        } else {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            if self.dropView.tableView.contentSize.height > 200 {
                self.height.constant = 300
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5) {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }
        }
    }
    
    func closeDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5) {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }
    }
}

class dropDownView : UIView, UITableViewDelegate, UITableViewDataSource {
    var options : [String]!
    var tableView : UITableView!
    var delegate : dropDownProtocol!
    var updateDelegate : fieldUpdatersProtocol!
    var type : String!

    init(frame: CGRect, options: [String], type: String) {
        super.init(frame: frame)
        self.options = options
        self.type = type
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        setupConstraints()
    }
    func updateOptions(newOptions: [String]) {
        options = newOptions
        tableView.reloadData()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownButtonPressed(str: options[indexPath.row], type: type)
        
    }
}
