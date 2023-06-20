//
//  HomeVC.swift
//  Sportz-Interactive
//
//  Created by Karan Vakharia on 20/06/23.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var lblMatchDetail: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    

    //MARK: - VARIABLE
    
    let dic = NSMutableDictionary()
    
    //MARK: - LIFECYCLE METHID
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
    }
    
    //MARK: - FETCH DATA FROM API
    
    func fetchData() {
        APIHelper.sharedInstance.getAPI(apiURL: mainURL, delegate: responseAPI)
    }
    func responseAPI( arrResponse :[String:AnyObject]) {
        print(arrResponse)
        let dictionary = arrResponse as NSDictionary
        let matchDetail = dictionary.value(forKey: "Matchdetail") as? NSDictionary
        let series = matchDetail?.value(forKey: "Series") as? NSDictionary
        let venue = matchDetail?.value(forKey: "Venue") as? NSDictionary
        let match = matchDetail?.value(forKey: "Match") as? NSDictionary
        let teamHome = matchDetail?.value(forKey: "Team_Home") as? String
        let teamAway = matchDetail?.value(forKey: "Team_Away") as? String
        let team = dictionary.value(forKey: "Teams") as? NSDictionary
        let date = match?.value(forKey: "Date") as? String
        dic.setValue(team, forKey: "TEAM")
        dic.setValue(teamHome, forKey: "teamHome")
        dic.setValue(teamAway, forKey: "teamAway")
        self.lblDate.text = "Date:- \(Utils.convertDate(date ?? "")) " + ((match?.value(forKey: "Time") as? String) ?? "")
        self.lblTeam.text = (series?.value(forKey: "Tour_Name") as? String ?? "") + "\n \(series?.value(forKey: "Status") as? String ?? "")"
        self.lblMatchDetail.text = "Venue:- " + ((venue?.value(forKey: "Name") as? String) ?? "")
        
    }
    
    //MARK: - UIBUTTON ACTION
    
    @IBAction func btnDetailClicked(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MatchDetailVC") as? MatchDetailVC else {return}
        vc.matchDic = dic
        self.navigationController?.pushViewController(vc, animated: true)

    }

}
