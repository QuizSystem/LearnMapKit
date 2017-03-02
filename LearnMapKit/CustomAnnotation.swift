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

    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    
    var subtitle: String?
    
    var image: UIImage?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, image: UIImage) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = image
        super.init()
    }

}
