//
//  ViewController.swift
//  MovieList
//
//  Created by codeteki private Ltd on 23/12/20.
//

import UIKit
import SDWebImage

protocol homeViewDelegate{
    func didSelectName(name:String)
}
class ViewController: UIViewController, UISearchBarDelegate {

    var pageNumber:Int?
    //var delegate:homeViewDelegate?
    var completionBlock : ((String) -> Void)? // block variable
    
    @IBOutlet weak var movieSearch: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var users:Dynamic<[Search]> = Dynamic([Search]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        movieSearch.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
//        print("PageNumber \(pageNumber!)")
        // Do any additional setup after loading the view.
        users.bindAndFire { (users) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        callAPI(movieName: searchBar.text!)
    }
    
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        callAPI(movieName: searchBar.text!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       callAPI(movieName: "avatar")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func callAPI(movieName:String)  {
        let urlString = "http://www.omdbapi.com/?s=\(movieName)&apikey=2f36849d"
        ApiManager.shared.httpGet(urlString: urlString) { (user, errorStr) in
            if (user?.search != nil){
                DispatchQueue.main.async {
                    self.users.value = user!.search!
                }
            }else{
               // NSToastView.nsShowToast(errorStr)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getNamesStr(name:String, repeat:Int) -> String {
        var retStr = ""
        for _ in 0...`repeat` {
            retStr = retStr + " " + name
        }
        return retStr
    }

}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10;
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
//        let headerLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 5, width: UIScreen.main.bounds.width - 20, height: 15))
//        headerLabel.text = " Movies"
//        headerView.addSubview(headerLabel)
//        return headerView
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (users.value.count == 0)  {
//            return 0 }
//        else  {
//            return 6
//        }
        return users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "tableviewcell") as? CustomTableViewCell
        cell.updateUI()
        cell.nameLabel.text = users.value[indexPath.row].title
        cell.typeLabel.text = users.value[indexPath.row].type
        cell.designationLabel.text = users.value[indexPath.row].year
        cell.profileImageView.sd_setImage(with: URL(string: users.value[indexPath.row].poster!), placeholderImage: UIImage(named: "sharuk"), options: .allowInvalidSSLCertificates, completed: nil)
//        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2.0
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let name = users.value[indexPath.row]
//        delegate?.didSelectName(name: name)
      //  completionBlock!("")
      //  self.navigationController?.popViewController(animated: true)
    }
    
    
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func updateUI() {
        self.nameLabel.layer.shadowColor = UIColor.black.cgColor
        self.nameLabel.layer.shadowRadius = 10.0
        self.nameLabel.layer.shadowOffset = CGSize(width: 5, height: 4)
        self.nameLabel.layer.shadowOpacity = 1
        self.nameLabel.layer.masksToBounds = false
        self.nameLabel.clipsToBounds = false
    }
    
    
}

