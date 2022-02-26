//
//  NotificationViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = NotificationViewModel()
    var notifications = [NotificationModelPayload]()
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModel()
        subscribeViewModel()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.identifier)
    }
    
    func attachViewModel(){
        viewModel.getNotifications()
    }
    
    func subscribeViewModel(){
        viewModel.notificationList.subscribe {[weak self] notificationList in
            guard let notification = notificationList.element else {return}
            if notification.isEmpty {
                self?.tableView.reloadData()
                HelperK.showError(title: "no Notification".localizede, subtitle: "")
            }else{
                self?.notifications.append(contentsOf: notification)
                self?.tableView.reloadData()
            }
            
        }.disposed(by: viewModel.disposeBag)

    }
    

}
extension NotificationViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath)as! NotificationTableViewCell
        cell.configure(model: notifications[indexPath.row])
        return cell
    }
    
    
}
