//
//  MatchListVC.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 13/02/24.
//

import UIKit

class MatchListVC: UIViewController {
    //MARK: -  @IBOutlet
    @IBOutlet weak var tblMatches: UITableView!
    
     
    //MARK: -  Properties
    
    private var viewModel = MatchViewModel()
    var marrMatches = [MatchModel]()
    
     
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utility.shared.showLoader(on: self.view)
        
        configuration()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

//MARK: -  API Call Functions
extension MatchListVC{
    
    // this is work like viewDidLoad
    func configuration(){
        tblMatches.register(UINib(nibName: Constant.TVC_MATCH_LIST_TVC, bundle: nil), forCellReuseIdentifier: Constant.TVC_MATCH_LIST_TVC)
        tblMatches.backgroundColor = .systemGroupedBackground
        initViewModel()
        
    }
    
    func initViewModel(){
        viewModel.fetchFirstMatchDataApi()
        observeEvent()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print("data loading")
                
            case .stopLoading:
                print("loading finished")
                DispatchQueue.main.async {
                    Utility.shared.hideLoader()
                }
                
            case .dataLoaded:
                self.marrMatches.removeAll()
                if let model = self.viewModel.matchResponce2{
                    self.marrMatches.append(model)
                }
                if let model = self.viewModel.matchResponce1{
                    self.marrMatches.append(model)
                }
                
                DispatchQueue.main.async {
                    self.tblMatches.reloadData()
                }
                
            case .network(let error):
                DispatchQueue.main.async {
                    Utility.shared.showAlert(title: "Something went wrong.", message: "Don't  worry nothing went wrong from your side.It's server issue it will fix soon.", view: self)
                }
                
                print("Error in ViewController",error ?? "Error at ObserEvnt")
                
            }
            
        }
    }
}


//MARK: -  UITableViewDelegate, UITableViewDataSource
extension MatchListVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marrMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.TVC_MATCH_LIST_TVC, for: indexPath) as? MatchListTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.matchDetail = marrMatches[indexPath.row]
        cell.contentView.backgroundColor = .systemGroupedBackground
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VC_MATCH_DETAIL) as? MatchDetailVC else { return }
        nextVC.matchResponce = marrMatches[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


