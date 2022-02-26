//
//  MapPlacesViewController.swift
//  Dalel
//
//  Created by  on 21/02/2022.
//

import UIKit
import GoogleMaps
class MapPlacesViewController: UIViewController {

    @IBOutlet weak var dismissBack: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    let viewModel = HomeViewModel()
    var centersOnMap = [CenterModelPayload]()
    override func viewDidLoad() {
        super.viewDidLoad()
getCenters()
        subscribeViewModel()
        mapView.addSubview(dismissBack)
    }

    func getCenters(){
        viewModel.listAllCenters()
    }

    func subscribeViewModel(){
        viewModel.centersResponse.subscribe { [weak self]centers in
            guard let allCenters = centers.element else {return}
            self?.centersOnMap.append(contentsOf: allCenters)
            self?.centersOnMap.forEach { centerlocation in
                let lon =  centerlocation.longitude.map {Double($0) ?? 0.0}
                let lat =  centerlocation.latitude.map {Double($0) ?? 0.0}
                self?.drawOnMap(lat: lat ?? 0.0, lon: lon ?? 0.0)
                }
            
        }.disposed(by: viewModel.disposeBag)

    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func drawOnMap(lat:Double,lon:Double){
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        
    }

}
