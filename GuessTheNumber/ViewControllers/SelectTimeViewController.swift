//
//  SelectTimeViewController.swift
//  GuessTheNumber
//
//  Created by Андрей Коваленко on 03.10.2023.
//

import UIKit

class SelectTimeViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var data: [Int] = []

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - EXTENSION
extension SelectTimeViewController: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = String(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Settings.shared.currentSetting.timeForGame = data[indexPath.row]
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
