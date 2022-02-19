//
//  SideMenueViewController.swift
//  Dalel
//
//  Created by Shgardi on 18/02/2022.
//

import UIKit

class SideMenueViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = SideMuneViewModel()
  

    override public func viewDidLoad() {
        super.viewDidLoad()
        addTableViewCell()
    }
    func addTableViewCell(){
        tableView.register(SideMenuTableViewCell.nib, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        tableView.rowHeight = 60
        
    }
    // MARK: - Private Methods

}
extension SideMenueViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as! SideMenuTableViewCell
        cell.configure(sideMenu: viewModel.sidesMenu[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sidesMenu.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            dismiss(animated: true, completion: nil)
        case 1 :
            let vc = LanguageViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        case 2 :
            let vc = AddPlaceViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        case 3:
            let vc = PlacesTableViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        case 4:
            let vc = ContactUsViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        case 5:
            let vc = OurVisionViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        case 6:
            let vc = OurGoalViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        case 7:
            let vc = TermsAndConditionViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        case 8:
            let social = TermsAndConditionViewController()
            social.modalPresentationStyle = .automatic
            present(social, animated: true, completion: nil)
        case 9:
            HelperK.deletUserDefaults()
            let login = LoginViewController.loadFromNib()
            let vc = UINavigationController(rootViewController: login)
            AppUtilities.changeRoot(root: vc, animated: true, completion: nil)
        default:
            let vc = OurVisionViewController()
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
            
        }
    }
}
