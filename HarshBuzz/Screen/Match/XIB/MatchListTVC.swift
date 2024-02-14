//
//  MatchListTVC.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 14/02/24.
//

import UIKit

class MatchListTVC: UITableViewCell {
    
    
    //MARK: -  @IBOutlet
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblVenue: UILabel!
    
    @IBOutlet weak var lblTeamNames: UILabel!
   
    @IBOutlet weak var lblTourName: UILabel!
    
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var viewBg: UIView!{
        didSet{
            viewBg.layer.cornerRadius = 10
        }
    }
    
    //MARK: -  Properties
    var matchDetail : MatchModel?{
        didSet{
            configureMatchDetails()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureMatchDetails(){
       
       guard let matchDetail else { return }
        
        lblTeamNames.text = "\(matchDetail.Teams.firstTeam.nameShort) VS \(matchDetail.Teams.secondTeam.nameShort)"
        lblDate.text = "Date & Time : \(matchDetail.Matchdetail.Match.Date) - \(matchDetail.Matchdetail.Match.Time)"
       
        lblVenue.text = "Venue : \(matchDetail.Matchdetail.Venue.Name)"
        lblTourName.text = (matchDetail.Matchdetail.Series.TourName)
        lblResult.text = (matchDetail.Matchdetail.Result)
      
   }
    
}
