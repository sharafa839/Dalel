//
//  AppDelegate.swift
//  Dalel
//
//  Created by Shgardi on 29/01/2022.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate , CLLocationManagerDelegate{

    var window: UIWindow?
    let locationManager = CLLocationManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        Router.setLaunch(window: window)
        GMSServices.provideAPIKey("AIzaSyD1fbW1OdbVEOd-vnP3VcaTeaooVrjmsSs")

        
        return true
    }



    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled()  {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
         
        }}
}

