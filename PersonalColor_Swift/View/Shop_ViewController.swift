//
//  Shop_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/19.
//

import UIKit
import MapKit

class Shop_ViewController: UIViewController {

    
    
    
    @IBOutlet var map_view: MKMapView!
    let location = CLLocationCoordinate2D(latitude: 37.494375, longitude: 127.029926)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        f_map()
     
                
    }
    
    func f_map(){
        smap_view.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "더조은!!!!"
        annotation.coordinate = location
        smap_view.addAnnotation(annotation)

    }

    
    @IBOutlet var smap_view: MKMapView!
    
}


