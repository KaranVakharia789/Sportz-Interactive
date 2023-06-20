//
//  MatchModel.swift
//  Sportz-Interactive
//
//  Created by Karan Vakharia on 20/06/23.
//

import Foundation

class MatchDetailModel {
    var teamHome : String?
    var teamAway : String?
    var series : Series?
    var venue : Venue?
    var teams : Teams?
}
class Series {
    var Matchid : String = ""
    var Name : String = ""
    var Status : String = ""
    var Tour : String = ""
    var Tour_Name : String = ""
}

class Venue {
    var Name : String = ""
    var Vanueid : String = ""
}
class Teams {
    var Name_Full : String? = ""
    var Name_Short: String? = ""
    var Players : Player? = nil
}

class Player {
    var Position : String? = ""
    var Name_Full : String? = ""
    var Iskeeper : Bool?
    var Iscaptain : Bool?
    var Batting : NSDictionary?
    var Bowling : NSDictionary?
}
