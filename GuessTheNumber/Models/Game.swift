//
//  Game.swift
//  GuessTheNumber
//
//  Created by Андрей Коваленко on 01.10.2023.
//

import Foundation

enum GameStatuses {
    case start
    case win
    case lose
}

class Game {
    
    struct Item {
        var title: String
        var isFound: Bool = false
        var isError: Bool = false
    }
    var isNewRecord: Bool = false
    private let data = Array(1...99)
    var status: GameStatuses = .start {
        didSet {
            if status != .start {
                if status == .win {
                    let newRecord = timeForGame - secondsGame
                    let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.gameRecord)
                    if record == 0 || newRecord < record {
                        UserDefaults.standard.setValue(newRecord, forKey: KeysUserDefaults.gameRecord)
                        isNewRecord = true
                    }
                }
                stopGame()
            }
        }
    }
    var items: [Item] = []
    private var timeForGame: Int
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame)
        }
    }
    private var timer: Timer?
    private var countItems: Int
    
    var nextItem: Item?
    private var updateTimer:((GameStatuses, Int)->())
    init(countItems: Int, updateTimer: @escaping (_ status: GameStatuses, _ seconds: Int) -> ()) {
        self.countItems = countItems
        self.timeForGame = Settings.shared.currentSetting.timeForGame
        self.secondsGame = self.timeForGame
        self.updateTimer = updateTimer
        setUpGame()
    }
    
    private func setUpGame() {
        isNewRecord = false
        var digits = data.shuffled()
        items.removeAll()
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        nextItem = items.shuffled().first
        
        if Settings.shared.currentSetting.timerState {
            updateTimer(status, secondsGame)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                self?.secondsGame -= 1
            })
        }
    }
    
    func check(index: Int) {
        
        guard status == .start else {
            return
        }
        
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { item in
                item.isFound == false
            })
        } else {
            items[index].isError = true
        }
        if nextItem == nil {
            status = .win
            
        }
    }
    
    func stopGame() {
        timer?.invalidate()
    }
    
    func newGame() {
        status = .start
        self.secondsGame = self.timeForGame
        setUpGame()
    }
}

extension Int {
    func secondsToString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
