//
//  SchoolDetailsViewController.swift
//  Dalel
//
//  Created by  on 29/01/2022.
//

import UIKit
import CoreLocation
import GoogleMaps
import ImageSlideshow
class SchoolDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GMSMapViewDelegate {
    @IBOutlet weak var sliderView: ImageSlideshow!{
        didSet{
            self.sliderView.configSliderShow()
            self.sliderView.setRoundCorners(15)
            self.sliderView.addActionn(vc: self, action: #selector(didTab))
        }
    }
    

    @IBOutlet weak var noCommentLabel: UILabel!{
        didSet{
            noCommentLabel.text = "NoCommentHere".localizede
        }
    }
    @IBOutlet weak var googleMap: GMSMapView!{
        didSet{
            googleMap.settings.zoomGestures = true
        }
    }
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var _1stButton: UIButton!
    @IBOutlet weak var _2stButton: UIButton!
    @IBOutlet weak var _3stButton: UIButton!
    @IBOutlet weak var _4stButton: UIButton!
    @IBOutlet weak var _5stButton: UIButton!
    @IBOutlet weak var rateInTextLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!{
        didSet{
            detailsLabel.text = "Details".localizede
        }
    }
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var ourServicesLabel: UILabel!{
        didSet{
            ourServicesLabel.text = "Our Services".localizede
        }
    }
    
    @IBOutlet weak var ourServicesDescriptionLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!{
        didSet{
            kindLabel.text = "Kind".localizede
        }
    }
    @IBOutlet weak var kindDescriptionLabel: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!{
        didSet{
            loactionLabel.text = "Location".localizede
        }
    }
    @IBOutlet weak var locationDescriptionLabel: UILabel!
    @IBOutlet weak var callUsLabel: UILabel!{
        didSet{
            callUsLabel.text = "Call us".localizede
        }
    }
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!{
        didSet{
            commentLabel.text = "Comments".localizede
        }
    }
    @IBOutlet weak var addCommentButton: UIButton!{
        didSet{
            addCommentButton.setTitle("Add Comment".localizede, for: .normal)
        }
    }
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var categoriesLabel: UILabel!{
        didSet{
            categoriesLabel.text = "show also".localizede
        }
    }
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!{
        didSet{
            favoriteButton.imageView?.tintColor = .gray
        }
    }
    
    @IBOutlet weak var showTimesButton: UIButton!{
        didSet{
            showTimesButton.setTitle("showTime".localizede , for: .normal)
            showTimesButton.floatView(raduis: 15, color: .clear)
        }
    }
    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floating(raduis: 15)
        }
    }
    
    var centerId:String?
    var centersInCategory = [CagtegoryCenterModelPayload]()
    var singleCenter:SingleCenterPayload?
    let viewModel = SchoolDetailsViewModel()
    let homeViewModel = SubHomeViewModel()
    var reviews = [ReviewsModelPayload]()
    var imageSourc = [InputSource]()

    init(centerId:String) {
        self.centerId = centerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModel(id: centerId ?? "")
        subscribeViewModel()
        setupViews()
        setupViewModel()
        // Do any additional setup after loading the view.
    }
    
    @objc func didTab()  {
        sliderView.presentFullScreenController(from: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func attachViewModel(id:String){
        viewModel.getCenterData(id: id )
        viewModel.getCenterReviews(id: id)
    }
    
    func setupViewModel(){
        viewModel.onError.subscribe {  error in
            
            HelperK.showError(title: error.element ?? "", subtitle: "")
        }.disposed(by: viewModel.disposeBag)
        viewModel.onLoading.subscribe { isLoading in
            if isLoading.element ?? false {
                ActivityIndicatorManager.shared.showProgressView()
            }else {
                ActivityIndicatorManager.shared.hideProgressView()
            }
        }.disposed(by: viewModel.disposeBag)

    
    }
    func loadSlider(banner:[MediaLink]){
        for i in banner{
            let urlStr = "https://Dalil-taelim.com" + ((i.link?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
            print(urlStr)
            ActivityIndicatorManager.shared.hideProgressView()
            self.imageSourc.append(KingfisherSource(urlString: urlStr)!)
            DispatchQueue.main.async {
                self.sliderView.setImageInputs(self.imageSourc)
            }
        }
    }
    
    func subscribeViewModel(){
        viewModel.singleCenter.subscribe {[weak self] center in
            guard let singleCenter = center.element else {
                return
            }
            self?.loadSlider(banner: singleCenter.mediaLinks ?? [MediaLink]())
            self?.setupUI(singleCenter: singleCenter)
            self?.singleCenter = singleCenter
            self?.homeViewModel.getCategory(id: singleCenter.category?.id ?? "")

        }.disposed(by: viewModel.disposeBag)
        
        viewModel.reviews.subscribe { [weak self]review in
            guard let review = review.element else {return}
            guard let self = self else {return}

            if self.reviews.isEmpty{
                self.commentTableView.isHidden = true
                
            }
            self.reviews.append(contentsOf: review)
            self.commentTableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.markAsFavorite.subscribe {[weak self] isFavorite in
            guard let favorite = isFavorite.element else {return}
            if favorite {
                self?.favoriteButton.imageView?.tintColor =  .red

            }else{
            self?.favoriteButton.imageView?.tintColor =  .gray
            }
        }.disposed(by: viewModel.disposeBag)
        
        homeViewModel.categories.subscribe { [weak self]centers in
            self?.centersInCategory.append(contentsOf: centers.element ?? [CagtegoryCenterModelPayload]())
            self?.categoryCollectionView.reloadData()
        }.disposed(by: viewModel.disposeBag)


    }
    
    func setupUI(singleCenter:SingleCenterPayload?){
        guard let center = singleCenter else {return}
   
        let position = CLLocationCoordinate2D(latitude: Double(center.latitude ?? "10") ?? 0.0, longitude: Double(center.longitude ?? "10") ?? 0.0)
        let marker = GMSMarker(position: position)
        marker.title = center.nameByLang
        marker.map = googleMap
    
        googleMap.camera = GMSCameraPosition(target: position, zoom: 16)

        if LocalizationManager.shared.getLanguage() == .Arabic {
        schoolNameLabel.text = singleCenter?.arName
            detailDescriptionLabel.text = singleCenter?.arDescription?.html2String
            kindDescriptionLabel.text = singleCenter?.category?.arName?.html2String
         
        } else {
            schoolNameLabel.text = singleCenter?.enName
            detailDescriptionLabel.text = singleCenter?.enDescription?.html2String
            kindDescriptionLabel.text = singleCenter?.category?.enName?.html2String

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
        locationDescriptionLabel.text = singleCenter?.address
    }
    
    func setupViews(){
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentTableViewCell.nib, forCellReuseIdentifier: CommentTableViewCell.identifier)
        commentTableView.rowHeight = 200
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoriesCollectionViewCell.nib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)

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
        let AddCommentVc = AddCommentViewController(id: centerId ?? "")
        navigationController?.pushViewController(AddCommentVc, animated: true)
        
    }
    @IBAction func showButton(_ sender: Any) {
        let Work = WorkTimeTableViewController(workTime: singleCenter?.workTimes ?? [WorkTime]())
        navigationController?.pushViewController(Work, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as! CommentTableViewCell
        cell.configure(review: reviews[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return centersInCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.configureCell(payload: centersInCategory[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = centersInCategory[indexPath.row]
        viewModel.getCenterData(id: item.id ?? "")
        viewModel.getCenterReviews(id: item.id  ?? "")
        if LocalizationManager.shared.getLanguage() == .English{
            schoolNameLabel.text = item.enName
        }else{
            schoolNameLabel.text = item.arName

        }
        subscribeViewModel()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
}
