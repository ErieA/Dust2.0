//
//  requirementsViewController.swift
//  Dust2.0
//
//  Created by Erie M. Adames on 4/26/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import UIKit

class requirementsViewController: UIViewController {
    var req : Response!
    var tableView : UITableView!
    var reuseIdentifier : String = "reqReuseIdentifier"
    var cellHeight : CGFloat = 40
    var fwsLabel : UILabel!
    var pbs_mqrLabel : UILabel!
    var asCoursesLabel : UILabel!
    var breadthLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 5
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.dataSource = self
        tableView.register(requirementTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        setupRequirementLabels()
        
        setupConstraints()
    }
    func setupRequirementLabels() {
        let reqsMet = extractReqs(req: req)
        fwsLabel = UILabel()
        fwsLabel.translatesAutoresizingMaskIntoConstraints = false
        fwsLabel.backgroundColor = .white
        if meetsFWS(reqsMet) {
            fwsLabel.text = "  FWS requirements met"
            fwsLabel.textColor = .blue
        } else {
            fwsLabel.text = "  FWS requirements NOT met"
            fwsLabel.textColor = .red
        }
        view.addSubview(fwsLabel)
        
        pbs_mqrLabel = UILabel()
        pbs_mqrLabel.backgroundColor = .white
        pbs_mqrLabel.translatesAutoresizingMaskIntoConstraints = false
        if meetsPBS_MQR_AS(reqsMet) {
            pbs_mqrLabel.text = "  PBS and MQR requirements met"
            pbs_mqrLabel.textColor = .blue
        } else {
            pbs_mqrLabel.text = "  PBS and MQR requirements NOT met"
            pbs_mqrLabel.textColor = .red
        }
        view.addSubview(pbs_mqrLabel)
        
        asCoursesLabel = UILabel()
        asCoursesLabel.backgroundColor = .white
        asCoursesLabel.translatesAutoresizingMaskIntoConstraints = false
        if meetsOthers(reqsMet) {
            asCoursesLabel.text = "  A&S category requirements met"
            asCoursesLabel.textColor = .blue
        } else {
            asCoursesLabel.text = "  A&S category requirements NOT met"
            asCoursesLabel.textColor = .red
        }
        view.addSubview(asCoursesLabel)
        
        breadthLabel = UILabel()
        breadthLabel.backgroundColor = .white
        breadthLabel.translatesAutoresizingMaskIntoConstraints = false
        if meetsBreadth(reqsMet) {
            breadthLabel.text = "  Breadth requirements met"
            breadthLabel.textColor = .blue
        } else {
            breadthLabel.text = "  Breadth requirements NOT met"
            breadthLabel.textColor = .red
        }
        view.addSubview(breadthLabel)
        
    }
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: fwsLabel.topAnchor)
            ])
        NSLayoutConstraint.activate([
            fwsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            fwsLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            fwsLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            fwsLabel.bottomAnchor.constraint(equalTo: pbs_mqrLabel.topAnchor),
            fwsLabel.heightAnchor.constraint(equalToConstant: cellHeight)
            ])
        NSLayoutConstraint.activate([
            pbs_mqrLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pbs_mqrLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pbs_mqrLabel.topAnchor.constraint(equalTo: fwsLabel.bottomAnchor),
            pbs_mqrLabel.bottomAnchor.constraint(equalTo: asCoursesLabel.topAnchor),
            pbs_mqrLabel.heightAnchor.constraint(equalToConstant: cellHeight)
            ])
        NSLayoutConstraint.activate([
            asCoursesLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            asCoursesLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            asCoursesLabel.topAnchor.constraint(equalTo: pbs_mqrLabel.bottomAnchor),
            asCoursesLabel.bottomAnchor.constraint(equalTo: breadthLabel.topAnchor),
            asCoursesLabel.heightAnchor.constraint(equalToConstant: cellHeight)
            ])
        NSLayoutConstraint.activate([
            breadthLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            breadthLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            breadthLabel.topAnchor.constraint(equalTo: asCoursesLabel.bottomAnchor),
            breadthLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            breadthLabel.heightAnchor.constraint(equalToConstant: cellHeight)
            ])
        
    }
    
    init(response: Response) {
        self.req = response
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func extractReqs(req: Response) -> [String] {
        var reqsMet : [String] = []
        for d in req.data {
            for var r in d.distributions {
                if r != "" || r != "class was not found.. probably user error" {
                    if r == "First-Year Writing Seminar." {
                        r = "(FWS)"
                    }
                    reqsMet.append(r)
                }
            }
        }
        return reqsMet
    }
    func meetsFWS(_ reqs: [String]) -> Bool {
        var numFWS = 0
        for r in reqs {
            if r == "(FWS)" {
                numFWS += 1
            }
            if numFWS == 2 {
                break
            }
        }
        if numFWS >= 2 {
            return true
        } else {
            return false
        }
    }
    func meetsPBS_MQR_AS(_ reqs: [String]) -> Bool {
        var numPBS_AS = 0
        var numMQR_AS = 0
        for r in reqs {
            if r == "(PBS-AS)" || r == "(PBS)" {
                numPBS_AS += 1
            }
            if r == "(MQR-AS)" || r == "(PBS)" {
                numMQR_AS += 1
            }
        }
        if (numPBS_AS >= 2 && numMQR_AS >= 2) || (numPBS_AS >= 3 && numMQR_AS >= 1) {
            return true
        } else {
            return false
        }
    }
    func meetsOthers(_ req: [String]) -> Bool {
        var numCA_AS = 0
        var numHA_AS = 0
        var numKCM_AS = 0
        var numLA_AS = 0
        var numSBA_AS = 0
        for r in req {
            if r == "(CA-AS)" || r == "(CA)" {
               numCA_AS += 1
            }
            if r == "(HA-AS)" || r == "(HA)" {
                numHA_AS += 1
            }
            if r == "(KCM-AS)" || r == "(KCM)" {
                numKCM_AS += 1
            }
            if r == "(LA-AS)" || r == "(LA)"{
                numLA_AS += 1
            }
            if r == "(SBA-AS)" || r == "(SBA)" {
                numSBA_AS += 1
            }
        }
        if (numCA_AS >= 1 && numHA_AS >= 1 && numKCM_AS >= 1 && numLA_AS >= 1)
            || (numSBA_AS >= 1 && numHA_AS >= 1 && numKCM_AS >= 1 && numLA_AS >= 1)
            || (numCA_AS >= 1 && numSBA_AS >= 1 && numKCM_AS >= 1 && numLA_AS >= 1)
            || (numCA_AS >= 1 && numHA_AS >= 1 && numSBA_AS >= 1 && numLA_AS >= 1)
            || (numCA_AS >= 1 && numHA_AS >= 1 && numKCM_AS >= 1 && numSBA_AS >= 1) {
            return true
        } else {
            return false
        }
    }
    func meetsBreadth(_ req: [String]) -> Bool {
        var numGB = 0
        var numHB = 0
        var numGHB = 0
        for r in req {
            if r == "(GB)" {
                numGB += 1
            }
            if r == "(HB)" {
                numHB += 1
            }
            if r == "(GHB)" {
                numGHB += 1
            }
        }
        if (numGB >= 1 && numHB >= 1) || (numGHB >= 1) {
            return true
        } else {
            return false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension requirementsViewController: UITableViewDataSource {
    
    /// Tell the table view how many rows should be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return req.data.count
        }
    
    /// Tell the table view what cell to display for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! requirementTableViewCell
        let course = req.data[indexPath.row]
        cell.configure(for: course)
        cell.selectionStyle = .none
        return cell
    }
    
}

extension requirementsViewController: UITableViewDelegate {
    
    /// Tell the table view what height to use for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    
}
