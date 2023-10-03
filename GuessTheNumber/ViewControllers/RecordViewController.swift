//
//  RecordViewController.swift
//  GuessTheNumber
//
//  Created by Андрей Коваленко on 03.10.2023.
//

import UIKit

class RecordViewController: UIViewController {
    // MARK: - PROPERTIES
    @IBOutlet weak var recordLabel: UILabel!
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.gameRecord)
        if record != 0 {
            recordLabel.text = "Ваш рекорд: \(record) сек"
            recordLabel.textColor = UIColor(named: "RedColor")
        } else {
            recordLabel.text = "Рекорд не установлен"
        }
    }
    // MARK: - ACTIONS
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true)
    }
}
