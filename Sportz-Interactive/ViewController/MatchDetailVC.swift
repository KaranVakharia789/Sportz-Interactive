//
//  MatchDetailVC.swift
//  Sportz-Interactive
//
//  Created by Karan Vakharia on 20/06/23.
//

import UIKit

class MatchDetailVC: UIViewController {

    //MARK: - OUTLETS
    
    @IBOutlet weak var tblPlayer: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    //MARK: - VARIABLE
    
    var matchDic = NSMutableDictionary()
    var arrPlayer = [Player]()
    var arrTitle = NSMutableArray()
    //MARK: - LIFECYCLE METHID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblPlayer.register(UINib(nibName: "PlayerCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
        setAllPlayer()
        
    }
    
    //MARK: - PLAYER DATA
    
    func setAllPlayer() {
        let data = ((matchDic.value(forKey: "TEAM") as? NSDictionary)?.allValues).map({$0})
        let arrAllPlayer = data as? NSArray
        for allPlayeritem in (arrAllPlayer ?? []) {
            let allArray = (((allPlayeritem as? NSDictionary)?.value(forKey: "Players") as? NSDictionary)?.allValues).map({$0})
            let teamArray = (allPlayeritem as? NSDictionary)?.value(forKey: "Name_Short") as? String ?? ""
            arrTitle.insert(teamArray, at: arrTitle.count)
            let playerArray = allArray as? NSArray
            for item in (playerArray ?? []) {
                let playerData = item as? NSDictionary
                let playerObj = Player()
                playerObj.Position = playerData?.value(forKey: "Position") as? String
                playerObj.Name_Full = playerData?.value(forKey: "Name_Full") as? String
                playerObj.Iskeeper = playerData?.value(forKey: "Iskeeper") as? Bool
                playerObj.Iscaptain = playerData?.value(forKey: "Iscaptain") as? Bool
                playerObj.Batting = playerData?.value(forKey: "Batting") as? NSDictionary
                playerObj.Bowling = playerData?.value(forKey: "Bowling") as? NSDictionary
                arrPlayer.insert(playerObj, at: arrPlayer.count)
            }
        }
        segment.setTitle(arrTitle[1] as? String, forSegmentAt: 1)
        segment.setTitle(arrTitle[0] as? String, forSegmentAt: 2)
        
        self.tblPlayer.reloadData()
    }
    
    func setPlayerData(_ key: String) {
        let data = (matchDic.value(forKey: "TEAM")).map({$0}) as? NSDictionary
        
        let arr = ((((data?.value(forKey: key).map({$0}) as? NSDictionary)?.value(forKey: "Players")) as? NSDictionary)?.allValues).map({$0})
        let playerArray = arr as? NSArray
        for item in (playerArray ?? []) {
            let playerData = item as? NSDictionary
            let playerObj = Player()
            playerObj.Position = playerData?.value(forKey: "Position") as? String
            playerObj.Name_Full = playerData?.value(forKey: "Name_Full") as? String
            playerObj.Iskeeper = playerData?.value(forKey: "Iskeeper") as? Bool
            playerObj.Iscaptain = playerData?.value(forKey: "Iscaptain") as? Bool
            playerObj.Batting = playerData?.value(forKey: "Batting") as? NSDictionary
            playerObj.Bowling = playerData?.value(forKey: "Bowling") as? NSDictionary
            arrPlayer.insert(playerObj, at: arrPlayer.count)
        }
        self.tblPlayer.reloadData()
    }
    
    //MARK: - UISEGMENT ACTION
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        arrPlayer.removeAll()
        switch sender.selectedSegmentIndex {
        case 0:
            setAllPlayer()
        case 1:
            setPlayerData(matchDic.value(forKey: "teamHome") as? String ?? "")
        case 2:
            setPlayerData(matchDic.value(forKey: "teamAway") as? String ?? "")
        default:
            print("NIL")
        }
    }
    
}
extension MatchDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        let array = arrPlayer[indexPath.row]
        if ((array.Iskeeper ?? false) && (array.Iscaptain ?? false)) {
            cell.lblPlayer.text = (arrPlayer[indexPath.row].Name_Full ?? "") + "  -Wc" + "  -C"
        } else if array.Iskeeper ?? false {
            cell.lblPlayer.text = (array.Name_Full ?? "") + "  -Wc"
        } else if array.Iscaptain ?? false {
            cell.lblPlayer.text = (array.Name_Full ?? "") + "  -C"
        }
        else {
            cell.lblPlayer.text = array.Name_Full
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let titleBat = arrPlayer[indexPath.row].Batting
        let titleBall = arrPlayer[indexPath.row].Bowling
        
        Utils.ShowAlert(Title: titleBat?.value(forKey: "Style") as? String ?? "", Message: titleBall?.value(forKey: "Style") as? String ?? "", viewController: self)
    }
    
    
}
