//
//  CustomAnnotation.swift
//  LearnMapKit
//
//  Created by Nguyen Van Thieu B on 3/2/17.
//  Copyright © 2017 Thieu Mao. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {

//    // Center latitude and longitude of the annotation view.
//    // The implementation of this property must be KVO compliant.
//    public var coordinate: CLLocationCoordinate2D { get }
//    
//    
//    // Title and subtitle for use by selection UI.
//    optional public var title: String? { get }
//    
//    optional public var subtitle: String? { get }

    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    
    var subtitle: String?
    
//    var image: UIImage?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }

}
