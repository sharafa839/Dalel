//
//  SchoolDetailsViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit
import CoreLocation
import GoogleMaps

class SchoolDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var _1stButton: UIButton!
    @IBOutlet weak var _2stButton: UIButton!
    @IBOutlet weak var _3stButton: UIButton!
    @IBOutlet weak var _4stButton: UIButton!
    @IBOutlet weak var _5stButton: UIButton!
    @IBOutlet weak var rateInTextLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var ourServicesLabel: UILabel!
    
    @IBOutlet weak var ourServicesDescriptionLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var kindDescriptionLabel: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!
    @IBOutlet weak var locationDescriptionLabel: UILabel!
    @IBOutlet weak var callUsLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!{
        didSet{
            favoriteButton.imageView?.tintColor = .gray
        }
    }
    
    
    var centerId:String?
    var singleCenter:SingleCenterPayload?
    let viewModel = SchoolDetailsViewModel()
    var reviews = [ReviewsModelPayload]()
    init(centerId:String) {
        self.centerId = centerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModel()
        subscribeViewModel()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func attachViewModel(){
        viewModel.getCenterData(id: centerId ?? "")
        viewModel.getCenterReviews(id: centerId ?? "")
    }
    
    func subscribeViewModel(){
        viewModel.singleCenter.subscribe {[weak self] center in
            guard let singleCenter = center.element else {
                return
            }
            self?.setupUI(singleCenter: singleCenter)
           
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.reviews.subscribe { [weak self]review in
            guard let review = review.element else {return}
            self?.reviews.append(contentsOf: review)
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.markAsFavorite.subscribe {[weak self] isFavorite in
            guard let favorite = isFavorite.element else {return}
            self?.favoriteButton.imageView?.tintColor = favorite ? .red : .gray
        }.disposed(by: viewModel.disposeBag)

    }
    
    func setupUI(singleCenter:SingleCenterPayload?){
        guard let center = singleCenter else {return}
   
        
        if LocalizationManager.shared.getLanguage() == .Arabic {
        schoolNameLabel.text = singleCenter?.arName
            detailDescriptionLabel.text = singleCenter?.arDescription
            kindDescriptionLabel.text = singleCenter?.category?.arName?.html2String
         
        } else {
            schoolNameLabel.text = singleCenter?.enName
            detailDescriptionLabel.text = singleCenter?.enDescription?.html2String
            kindDescriptionLabel.text = singleCenter?.category?.enName

        }
        phoneNumberButton.setTitle(singleCenter?.phone, for: .normal)
        phoneNumberButton.target(forAction: #selector(callUs), withSender: self)
        if center.isFavorited ?? false {
            favoriteButton.imageView?.tintColor = .red
        }else {
            favoriteButton.imageView?.tintColor = .gray
        }
        ourServicesDescriptionLabel.text = singleCenter?.services?.first?.title ?? ""
        averageRate(rate: center.averageRate ?? "5")
        getAddress(lat: singleCenter?.latitude ?? "0", lon: singleCenter?.longitude ?? "0") {[weak self] location in
            self?.locationDescriptionLabel.text = location

        }
    }
    
    func setupTableView(){
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentTableViewCell.nib, forCellReuseIdentifier: CommentTableViewCell.identifier)
    }
    
   private func getAddress(lat:String,lon:String ,currentAdd : @escaping( _ returnAddress :String)->Void){
            var currentAddress = String()
        let latitude: CLLocationDegrees = Double(lat)!
        let longitude: CLLocationDegrees = Double(lon)!
        let source = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(source) { response , error in
                if let address = response?.firstResult() {
                    let lines = address.lines! as [String]

                    currentAddress = lines.joined(separator: "\n")

                    currentAdd(currentAddress)
                }}}

         @objc private func callUs(phone:String){
              HelperK.openCalling(phone: phone)
          }
    
    private func averageRate(rate:String){
        rateInTextLabel.text = "\(rate)/5"
        switch rate {
        case "1":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .gray
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case "2":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case "3":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case "4":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .systemYellow
            _5stButton.imageView?.tintColor = .gray
            
        case "5":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .systemYellow
            _5stButton.imageView?.tintColor = .systemYellow
            
        default:
            _1stButton.imageView?.tintColor = .gray
            _2stButton.imageView?.tintColor = .gray
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        }
    }


    @IBAction func makeFavoriteButton(_ sender: Any) {
        if singleCenter?.isFavorited ?? false {
            viewModel.makeUnFavorite(id: centerId ?? "")
        }else {
            viewModel.makeFavorite(id: centerId ?? "")
        }
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addCommentAction(_ sender: Any) {
        let AddCommentVc = AddCommentViewController()
        navigationController?.pushViewController(AddCommentVc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as! CommentTableViewCell
        cell.configure(review: reviews[indexPath.row])
        return cell
    }
}