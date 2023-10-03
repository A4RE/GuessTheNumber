//
//  SettingsTableViewController.swift
//  GuessTheNumber
//
//  Created by Андрей Коваленко on 03.10.2023.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    @IBOutlet weak var switchTimer: UISwitch!
    
    @IBOutlet weak var timeGameLabel: UILabel!
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    // MARK: - ACTIONS
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSetting.timerState = sender.isOn
    }
    
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    // MARK: - FUNCTIONS
    func loadSettings() {
        timeGameLabel.text =  "\(Settings.shared.currentSetting.timeForGame) сек"
        switchTimer.isOn = Settings.shared.currentSetting.timerState
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
            }
        default:
            break
        }
    }
}
