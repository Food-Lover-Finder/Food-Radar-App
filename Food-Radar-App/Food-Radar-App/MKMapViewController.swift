//
//  MKMapViewController.swift
//  Food-Radar-App
//
//  Created by Alicia Isler on 11/27/21.
//


import SwiftUI
import MapKit
import UIKit

//search bar
class MKMapViewController: UIViewController, UISearchBarDelegate {


    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }

    
    
    @IBSegueAction func mapsSwiftUI(_ coder: NSCoder) -> UIViewController? {
        let hostingController = UIHostingController(coder: coder, rootView: ContentView())
        hostingController!.view.backgroundColor = UIColor.clear;
        return hostingController
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        //ignoring user
        self.view.isUserInteractionEnabled = false

        //Activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        self.view.addSubview(activityIndicator)

        //hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        searchRequest.region = mapView.region
        // searchRequest.naturalLanguageQuery = "restaraunt"


        let activeSearch = MKLocalSearch(request: searchRequest)


        activeSearch.start {  (response, error) in

        guard let response = response else {
        activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = false
        return

        }
        
        for item in response.mapItems {
        if let name = item.name,
        let location = item.placemark.location {
        print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
            }
        }

        if response == nil {
            print("ERROR")
        }else{
            //REMOVE ANNOTAIONS
            let annotations = self.mapView.annotations
            self.mapView.removeAnnotations(annotations)

            //getting data
            let lattitude = response.boundingRegion.center.latitude
            let longitude = response.boundingRegion.center.longitude

            //create annotations
            let annotation = MKPointAnnotation()
            annotation.title = searchBar.text
            annotation.coordinate = CLLocationCoordinate2DMake(lattitude, longitude)
            self.mapView.addAnnotation(annotation)

            //zooming in on coordinates
//            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude, longitude)
//            let span = (latitudeDelta: 0.1, longitudeDelta: 0.1)
//            let region = (center: coordinate, span: span).self
//
//            var isAnimating: Bool = false
//
//            func setRegion(_ region: MKCoordinateRegion,
//                                       animated: Bool){
//                var isAnimating: Bool = true
//
//                if (animated) {
//                    isAnimating = true
//                    }
//                }
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)

                    }

                }
            }

        
        @IBOutlet weak var mapView: MKMapView!
        
        
            override func viewDidLoad() {
                super.viewDidLoad()
        
                // Do any additional setup after loading the view.
            }
        
            override func viewWillAppear(_ animated: Bool)
            {
                self.navigationController?.navigationBar.isHidden = false
            }
        
        
    }


//Swift Ui Map
class Coordinator: NSObject, MKMapViewDelegate  {
    var control: MapView
    init(_ control: MapView)  {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView] )  {
        if let annotationView =  views.first    {
            if let annotation = annotationView.annotation   {
                if annotation is MKUserLocation {
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
            
    }
}

    

struct MapView: UIViewRepresentable {
    
    let landmarks: [Landmark]
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
}

// Location Manager
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate   {
    func locationManager (_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print (status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
}

//Landmarks

struct Landmark {
    
    let placemark: MKPlacemark
    var id: UUID  {
        return UUID()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D  {
        self.placemark.coordinate
    }
}

//Landmark Annotation
final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}

//class MKMapViewController: UIViewController, UISearchBarDelegate {
//
//
//    @IBAction func searchButton(_ sender: Any) {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.delegate = self
//        present(searchController, animated: true, completion: nil)
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        //ignoring user
//        self.view.isUserInteractionEnabled = false
//
//        //Activity indicator
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.style = UIActivityIndicatorView.Style.medium
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.startAnimating()
//
//        self.view.addSubview(activityIndicator)
//
//        //hide search bar
//        searchBar.resignFirstResponder()
//        dismiss(animated: true, completion: nil)
//
//        //create the search request
//        let searchRequest = MKLocalSearch.Request()
//        searchRequest.naturalLanguageQuery = searchBar.text
//        searchRequest.region = mapView.region
//       // searchRequest.naturalLanguageQuery = "restaraunt"
//
//
//        let activeSearch = MKLocalSearch(request: searchRequest)
//
//
//        activeSearch.start {  (response, error) in
//
//            guard let response = response else {
//            activityIndicator.stopAnimating()
//            self.view.isUserInteractionEnabled = false
//            return
//
//            }
//
//            for item in response.mapItems {
//                    if let name = item.name,
//                        let location = item.placemark.location {
//                        print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
//                    }
//                }
//
//            if response: Sting? == nil
//            {
//                print("ERROR")
//            }
//            else
//            {
//                //REMOVE ANNOTAIONS
//                let annotations = self.mapView.annotations
//                self.mapView.removeAnnotations(annotations)
//
//                //getting data
//                let lattitude = response.boundingRegion.center.latitude
//                let longitude = response.boundingRegion.center.longitude
//
//                //create annotations
//                let annotation = MKPointAnnotation()
//                annotation.title = searchBar.text
//                annotation.coordinate = CLLocationCoordinate2DMake(lattitude, longitude)
//                self.mapView.addAnnotation(annotation)
//
//                //zooming in on coordinates
//                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude, longitude)
//                let span = (latitudeDelta: 0.1, longitudeDelta: 0.1)
//                let region = (center: coordinate, span: span).self
//
//                var isAnimating: Bool = false
//
//                func setRegion(_ region: MKCoordinateRegion,
//                               animated: Bool)
//                {
//                    var isAnimating: Bool = true
//
//                    if (animated)
//                      {
//                          isAnimating = true
//                      }
//                }
//                self.mapView.showAnnotations(mapView.annotations, animated: true)
//
//
//
//
//            }
//
//        }
//    }
//
//
//    @IBOutlet weak var mapView: MKMapView!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillAppear(_ animated: Bool)
//    {
//        self.navigationController?.navigationBar.isHidden = false
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
