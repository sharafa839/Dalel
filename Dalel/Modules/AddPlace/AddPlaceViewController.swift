//
//  AddPlaceViewController.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit
import iOSDropDown
import Gallery
import CoreLocation
class AddPlaceViewController: UIViewController, GalleryControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var welcomeToDalel: UILabel!{
        didSet{
            welcomeToDalel.text = "welcomeToDelel"
        }
    }
    @IBOutlet weak var addYourPlaceLabel: UILabel!{
        didSet{
            addYourPlaceLabel.text = "add your place"
        }
    }
    @IBOutlet weak var nameEnTextField: UITextField!{
        didSet{
            nameEnTextField.placeholder = "add your place name"
            nameEnTextField.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var nameArTextField: UITextField!{
        didSet{
            nameArTextField.placeholder = "add your place nameAr"
            nameArTextField.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var descriptionEnTextField:UITextField!{
        didSet{
            descriptionEnTextField.placeholder = "add your place description"
            descriptionEnTextField.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var descriptionArTextField: UITextField!{
        didSet{
            descriptionArTextField.placeholder = "add your place descriptionAr"
            descriptionArTextField.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    
    @IBOutlet weak var CategoryTextField: DropDown!{
        didSet{
            CategoryTextField.text = "add your category"
        }
    }
    @IBOutlet weak var phoneTextField: UITextField!{
        didSet{
            phoneTextField.placeholder = "add your phone"
            phoneTextField.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    @IBOutlet weak var addressTextField: UITextField!{
        didSet{
            addressTextField.placeholder = "add your address"
            addressTextField.floatView(raduis: 10, color: UIColor(named: "MainColor") ?? UIColor())
        }
    }
    
    @IBOutlet weak var addPhotos: UIButton!{
        didSet{
            addPhotos.setTitle("addPhoto", for: .normal)
            addPhotos.target(forAction: #selector(updateProfile), withSender: self)
        }
    }
    @IBOutlet weak var addPlace: UIButton!{
        didSet{
            addPlace.setTitle("addPlace".localizede, for: .normal)
            addPlace.floatButton(raduis: 15)
        }
    }
    var pickedImg: UIImage?
    var arrayOfImage:[UIImage?] = []
    var gallary = GalleryController()
    let categoryViewModel = HomeViewModel()
    var category = [CategoriesModelPayload]()
    let viewModel = AddPlaceViewModel()
    var categoryIds = [String]()
    var selectedCategory = String()
    let locationManager = CLLocationManager()
    
    var place : PlacesModelPayload?
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
        subscribeViewModels()
        locationManager.delegate = self
        setupViewModel()
        print(locationManager.location?.coordinate)
        getSelectedCategory()
        subscribeViewModel()
        if place != nil {
            getData(places: place!)
        }
    }
    
    func getData(places:PlacesModelPayload?){
        nameArTextField.text = places?.arName ?? ""
        nameEnTextField.text  = places?.enName ?? ""
        descriptionArTextField.text = places?.arDescription ?? ""
        descriptionEnTextField.text = places?.enDescription ?? ""
        CategoryTextField.text = places?.category?.arName ?? ""
        phoneTextField.text = places?.phone ?? ""
        addressTextField.text = places?.address ?? ""
        selectedCategory = places?.category?.id ?? ""
   
    }
    
    func setupViewModel(){

        viewModel.onLoading.subscribe { isLoading in
            if isLoading.element ?? false {
                ActivityIndicatorManager.shared.showProgressView()
            }else {
                ActivityIndicatorManager.shared.hideProgressView()
            }
        }.disposed(by: viewModel.disposeBag)
        categoryViewModel.onLoading.subscribe { isLoading in
            if isLoading.element ?? false {
                ActivityIndicatorManager.shared.showProgressView()
            }else {
                ActivityIndicatorManager.shared.hideProgressView()
            }
        }.disposed(by: viewModel.disposeBag)
        
    }
    
    @IBAction func addPhotosAction(_ sender: Any) {
        updateProfile()
    }
    
    func subscribeViewModel(){
        viewModel.onSuccess.subscribe { [weak self]center in
            guard let id = center.element?.id else {return}
            let vc = AddServiceViewController(id: id)
            vc.modalPresentationStyle = .overFullScreen
            self?.present(vc, animated: true, completion: nil)
        }.disposed(by: viewModel.disposeBag)

    }
    
    @objc func updateProfile(){
        gallary = GalleryController()
        gallary.delegate = self
            Config.tabsToShow = [.cameraTab,.imageTab]
            Config.Camera.imageLimit = 1
            self.present(self.gallary,animated: true,completion: nil)
    }
    
    func getCategories(){
        categoryViewModel.getCategory()
        
    }
    
    func subscribeViewModels(){
        categoryViewModel.onSuccess.subscribe { categories in
            guard let cats = categories.element else {return}
            for i in cats {
                self.CategoryTextField.optionArray += [i.nameByLang ?? ""]
                self.categoryIds += [i.id ?? ""]
            }
           
        }.disposed(by: categoryViewModel.disposeBag)

    }
    
    func getSelectedCategory(){
        CategoryTextField.didSelect {[weak self] selectedText, index, id in
            self?.selectedCategory = self?.categoryIds[index] ?? ""
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func addCenter(_ sender: UIButton) {
        guard let nameAr = nameArTextField.text , !nameAr.isEmpty else {return}
        guard let nameEn = nameEnTextField.text , !nameEn.isEmpty else {return}
        guard let descriptionAr = descriptionArTextField.text , !descriptionAr.isEmpty else {return}
        
        guard let descriptionEn = descriptionEnTextField.text , !descriptionEn.isEmpty else {return}
        guard let phone = phoneTextField.text , !phone.isEmpty else {return}
        guard let address = addressTextField.text , !address.isEmpty else {return}
        guard !selectedCategory.isEmpty else {return}
        if place == nil {
            addPlace.secAnimation()

        print(selectedCategory)
        self.viewModel.uploadCenter(image: pickedImg ?? UIImage(), arName: nameAr, enName: nameEn, desccriptionen: descriptionEn, arDescription: descriptionAr, phone: phone, address: address, lat: String(locationManager.location?.coordinate.latitude ?? 0), lon: String(locationManager.location?.coordinate.longitude ?? 0), categoryID: selectedCategory)
        }else {
            addPlace.secAnimation()

            updateCenter(image: pickedImg ?? UIImage(), nameAr: nameAr, nameEn: nameEn, descriptionAr: descriptionAr, descriptionEn: descriptionEn, phone: phone, address: address, lat: String(locationManager.location?.coordinate.latitude ?? 0), lon: String(locationManager.location?.coordinate.longitude ?? 0), category: place?.id ?? "")
        }

    }
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { [weak self] (resolvedImage) in
               
             
                    self?.arrayOfImage = resolvedImage
                    self?.pickedImg = self?.arrayOfImage.first as? UIImage
           
        controller.dismiss(animated: true, completion: nil)
            }}
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)

    }
    
}

extension AddPlaceViewController{
    func updateCenter(image:UIImage,nameAr:String,nameEn:String,descriptionAr:String,descriptionEn:String,phone:String,address:String,lat:String,lon:String,category:String){
        let parms =
        ["en_name":nameEn,"ar_name":nameAr,"en_description":descriptionEn,"ar_description":descriptionAr,"phone":phone,"address":address,"latitude":lat,"longitude":lon,"category_id":category,"_method":"PATCH"]
        APIs.registerProvider(id: place?.id ?? "", image:pickedImg ?? UIImage(), params: parms) { [weak self] ( err:Error?, centerModel:AddCenterModel?, code:Int?) in
            if [200,201].contains(centerModel?.code){
                HelperK.showSuccess(title: "updated".localizede, subtitle: "")
                self?.dismiss(animated: true, completion: nil)
            }
            
        }
    }
}
