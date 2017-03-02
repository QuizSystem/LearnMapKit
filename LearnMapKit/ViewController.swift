//
//  ViewController.swift
//  LearnMapKit
//
//  Created by Nguyen Van Thieu B on 3/2/17.
//  Copyright © 2017 Thieu Mao. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var annotationArray:[CustomAnnotation] = [CustomAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
//        if let currentLocation = locationManager.location?.coordinate {
//            let image = UIImage(named: "framgia")!
//            let newImage = imageWithImage(image: image, scaledToSize: CGSize(width: 20, height: 20))
//            let annotation = CustomAnnotation(title: "Framgia", subtitle: "13F Keang Nam", coordinate: CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude), image: newImage)
//            mapView.addAnnotation(annotation)
//        }
        addAnnotationsOnMapView()
        mapView.addAnnotations(annotationArray)
    }
    
    func drawLineTwoLocation(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D) {
        // Step 1
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destionationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // Step 2
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destionationPlacemark)
        
        // Step 3
        let directRequest = MKDirectionsRequest()
        directRequest.source = sourceMapItem
        directRequest.destination = destinationMapItem
        directRequest.transportType = .automobile
        
        // Step 4
        let directions = MKDirections(request: directRequest)
        directions.calculate { (reponse: MKDirectionsResponse?, error: Error?) in
            if error == nil {
                if let route = reponse?.routes.first {
                    self.mapView.add(route.polyline, level: .aboveRoads)
                    let rect = route.polyline.boundingMapRect
                    self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsetsMake(40, 40, 20, 20), animated: true)
                }
            } else {
                print("Mao", error?.localizedDescription)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        let region = MKCoordinateRegion(center: (currentLocation?.coordinate)!, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }

    func addAnnotationsOnMapView() {
        if let currentLocation = locationManager.location?.coordinate {
            let image = UIImage(named: "framgia")!
            let newImage = imageWithImage(image: image, scaledToSize: CGSize(width: 20, height: 20))
            let sourceAnnotation = CustomAnnotation(title: "Framgia", subtitle: "13F Keang Nam", coordinate: CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude), image: newImage)
            annotationArray.append(sourceAnnotation)
            
            //20.980878, 105.800978
            let destinationLocation = CLLocationCoordinate2D(latitude: 20.980878, longitude: 105.800978)
            let destinationAnnotation = CustomAnnotation(title: "Framgia", subtitle: "13F Keang Nam", coordinate: CLLocationCoordinate2D(latitude: destinationLocation.latitude, longitude: destinationLocation.longitude), image: newImage)
            annotationArray.append(destinationAnnotation)
            
            drawLineTwoLocation(sourceLocation: currentLocation, destinationLocation: destinationLocation)
        }
        

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let myAnnotation = annotation as? CustomAnnotation {
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomPinannotationView")
            if pinView == nil {
                pinView = MKAnnotationView(annotation: myAnnotation, reuseIdentifier: "CustomPinannotationView")
                pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                pinView?.canShowCallout = true
                pinView?.calloutOffset = CGPoint(x: 0, y: 4)
                pinView?.contentMode = .center
            } else {
                pinView?.annotation = annotation
            }
            pinView?.image = myAnnotation.image
            return pinView
        }
        return nil
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3.0
        return renderer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

