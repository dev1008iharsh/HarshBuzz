//
//  MatchDetailVC.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 13/02/24.
//
 
import UIKit

class MatchDetailVC: UIViewController {
  
    //MARK: -  @IBOutlet
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var tblTeam1: UITableView!
    @IBOutlet weak var tblTeam2: UITableView!
    @IBOutlet weak var lblPlayerOfMatch: UILabel!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblScore1: UILabel!
    @IBOutlet weak var lblScore2: UILabel!
    
    
    //MARK: -  Properties
    private var marrTeamPlayer1 = [[String: String]]()
    private var marrTeamPlayer2 = [[String: String]]()
    private var viewModel = MatchViewModel()
    var matchResponce : MatchModel!
    
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("*** matchResponce - \(String(describing: matchResponce))")
        
        self.title = "Players"
        tableConfiguration()
        setPlayerDetailData()
        getPlayerDetails()
    }
    
    //MARK: -  SetUp Screen
    func setPlayerDetailData(){
        
        lblTeamName.text = "\(matchResponce.Teams.firstTeam.nameFull) VS \(matchResponce.Teams.secondTeam.nameFull)"
 
        if matchResponce.Innings.count == 2 {
            lblScore1.text = "\(matchResponce.Teams.firstTeam.nameShort) : \(matchResponce.Innings[0].Total)/\(matchResponce.Innings[1].Wickets) (\(matchResponce.Innings[0].Overs))"
            lblScore2.text = "\(matchResponce.Teams.secondTeam.nameShort) : \(matchResponce.Innings[1].Total)/\(matchResponce.Innings[1].Wickets) (\(matchResponce.Innings[1].Overs))"
        }
       
        
        lblResult.text = (matchResponce.Matchdetail.Result)
        lblPlayerOfMatch.text = "Player of the match : \(matchResponce.Matchdetail.PlayerMatch)"
        
    }
   
    
    func getPlayerDetails(){
        let dictTeamPlayer1 = matchResponce.Teams.firstTeam.players
        let dictTeamPlayer2 = matchResponce.Teams.secondTeam.players
        
        for (_, player) in dictTeamPlayer1 {
            let nameFull = player.nameFull
            let battingStyle = player.batting.style
            let bowlingStyle = player.bowling?.style ?? "Do Not Bowling"
            let isKeeper = (player.isKeeper ?? false) ? "1":"0"
            let isCaptain = (player.isCaptain ?? false) ? "1":"0"
             
            let requiredDict: [String: String] = [
                "name": nameFull,
                "batting_style": battingStyle,
                "bowling_style": bowlingStyle,
                "isKeeper": isKeeper,
                "isCaptain": isCaptain
            ]
        
            marrTeamPlayer1.append(requiredDict)
        }
        
        for (_, player) in dictTeamPlayer2 {
            let nameFull = player.nameFull
            let battingStyle = player.batting.style
            let bowlingStyle = player.bowling?.style ?? ""
            let isKeeper = (player.isKeeper ?? false) ? "1":"0"
            let isCaptain = (player.isCaptain ?? false) ? "1":"0"
          
            let requiredDict: [String: String] = [
                "name": nameFull,
                "batting_style": battingStyle,
                "bowling_style": bowlingStyle,
                "isKeeper": isKeeper,
                "isCaptain": isCaptain
            ]
        
            marrTeamPlayer2.append(requiredDict)
        }
       
        self.tblTeam1.reloadData()
        self.tblTeam2.reloadData()
         
    }
    
    func tableConfiguration(){
        tblTeam1.showsVerticalScrollIndicator = false
        tblTeam2.showsVerticalScrollIndicator = false
        tblTeam1.register(UINib(nibName: Constant.TVC_PLAYER_LIST_TVC, bundle: nil), forCellReuseIdentifier: Constant.TVC_PLAYER_LIST_TVC)
        tblTeam2.register(UINib(nibName: Constant.TVC_PLAYER_LIST_TVC, bundle: nil), forCellReuseIdentifier: Constant.TVC_PLAYER_LIST_TVC)
    }
    
}
 
//MARK: -  UITableViewDelegate, UITableViewDataSource
extension MatchDetailVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblTeam1{
            return marrTeamPlayer1.count
        }else{
            return marrTeamPlayer2.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.TVC_PLAYER_LIST_TVC, for: indexPath) as? PlayerListTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let arrayToShow = (tableView == tblTeam1 ? marrTeamPlayer1 : marrTeamPlayer2)
        
        
        if (arrayToShow[indexPath.row]["isKeeper"] == "1") || (arrayToShow[indexPath.row]["isCaptain"] == "1"){
            
            if (arrayToShow[indexPath.row]["isKeeper"] == "1") && (arrayToShow[indexPath.row]["isCaptain"] == "1"){
                cell.lblPlayer.textColor = .systemBlue
                cell.lblPlayer.text = "\(arrayToShow[indexPath.row]["name"] ?? "") (C & WK)"
                
            }else if (arrayToShow[indexPath.row]["isKeeper"] == "1"){
                cell.lblPlayer.textColor = .systemPurple
                cell.lblPlayer.text = "\(arrayToShow[indexPath.row]["name"] ?? "") (WK)"
            }else{
                cell.lblPlayer.textColor = .systemRed
                cell.lblPlayer.text = "\(arrayToShow[indexPath.row]["name"] ?? "") (C)"
            }
            
        }else{
            cell.lblPlayer.textColor = .label
            cell.lblPlayer.text = arrayToShow[indexPath.row]["name"]
        }
         
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arrayToShow = (tableView == tblTeam1 ? marrTeamPlayer1 : marrTeamPlayer2)
        Utility.shared.showAlert(title: (arrayToShow[indexPath.row]["name"] ?? ""), message: "Batting Style : \(arrayToShow[indexPath.row]["batting_style"] ?? "") \nBowling Style : \(arrayToShow[indexPath.row]["bowling_style"] ?? "")" , view: self)
    }
    
}
