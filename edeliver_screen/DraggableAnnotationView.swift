//
//  DraggableAnnotationView.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 26/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import MapKit
class pinAnnotation:NSObject,MKAnnotation {
        var title:String?
        var subtitle: String?
        var coordinate: CLLocationCoordinate2D
    
    init(title:String,subtitle:String,coordinate:CLLocationCoordinate2D) {
            self.title = title
            self.subtitle = subtitle
            self.coordinate = coordinate
        }

    
}
