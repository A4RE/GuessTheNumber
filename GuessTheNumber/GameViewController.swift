//
//  GameViewController.swift
//  GuessTheNumber
//
//  Created by Андрей Коваленко on 01.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var newGameButton: UIButton!
    lazy var game = Game(countItems: buttons.count, time: 60) { [weak self] status, time in
        guard let self = self else { return }
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
    
    }
    
    @IBAction func firstButtonPress(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {
            return
        }
        
        game.check(index: buttonIndex)
        updateUI()
        
    }
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setUpScreen()
    }
    
    private func setUpScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)

            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {

            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    guard let self = self else { return }
                    self.buttons[index].backgroundColor = .purple
                } completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.buttons[index].backgroundColor = UIColor(named: "RedColor")
                    self.game.items[index].isError = false
                }

            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    private func updateInfoGame(with status: GameStatuses) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = UIColor(named: "RedColor")
            newGameButton.isHidden = false
        }
    }
}
