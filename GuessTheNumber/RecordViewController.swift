//
//  RecordViewController.swift
//  GuessTheNumber
//
//  Created by Андрей Коваленко on 03.10.2023.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
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
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true)
    }
    


}
