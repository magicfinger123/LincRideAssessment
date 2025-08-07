

#  LincRideAssessment – Points of Interest Finder App

## 1. How to Run the App

### 1.1 Requirements

Demo: View the demo:
   https://drive.google.com/file/d/1XpDq138huRa6xi9GAC1NET8fLTnChGjM/view?usp=sharing
1. macOS with Xcode 15 or later  
2. iOS 17.0+  
3. Swift 5+  
4. Internet connection (for search/autocomplete)

### 1.2 Setup Instructions
1. Clone or download this repository:
   git clone https://github.com/magicfinger123/LincRideAssessment.git


2. Open `LincRideAssessment.xcodeproj` in Xcode.
3. Ensure your development team is set under **Signing & Capabilities**.
4. Select a simulator or real device.
5. Run the app.


## 2. Features

1. Shows user’s current location on Apple Map.
2. Search for nearby places using Apple’s **MKLocalSearch API**.
3. Display results as **map annotations**.
4. Tap a place to view:

   * Place details
   * Static map preview
   * Look Around preview (if available)
   * Option to save places to favorites
5. Offline persistence using **Realm**.
6. Autocomplete with **MKLocalSearchCompleter**.

---

## 3. Assumptions Made

1. Look Around may not be available for all Points of Interest (POIs).
2. Places are saved by ID and location.
3. Autocomplete suggestions are capped at 10.
4. Favorites are assumed to be offline-safe once saved.

---

## 4. Limitations / Areas for Improvement

1. No pagination for search results.
2. No visual feedback when no results are found.
3. Only basic error alerting.
4. UI can be enhanced for:

   * Accessibility
   * Dark mode support
   * Look Around not embedded in a full-screen modal.

---

## 5. How I Approached the Problem

### 5.1 Architecture: MVVM

1. **ViewModels** – Handle logic, search, and persistence.
2. **Views** – Built using **SwiftUI**.
3. **Services** – Handle location, search, and persistence.

### 5.2 Key Goals

* Modularity
* Code readability
* Leverage modern MapKit + SwiftUI integrations

---

## 6.  Trade-offs & Challenges

1. Chose **Realm** over **CoreData** for quicker setup and easier use.
2. Created a lightweight `Place` model instead of using full `MKMapItem` objects for Realm persistence.
3. **Look Around** support is limited by Apple’s API availability in certain regions.

---

## 7. Unit Tests

1. **MapViewModelTests** – Verifies:

   * Region updates
   * POI search
   * Annotation creation
2. **SavedPlacesViewModelTests** – Confirms:

   * Realm save behavior
   * Realm delete behavior

---

## 8. Folder Structure

```
LincRideAssessment
├── LincRideAssessment
│   ├── assets/
│   │   └── Assets.xcassets
│   ├── main/
│   │   └── LincRideAssessmentApp.swift
│   ├── models/
│   │   └── Place.swift
│   ├── realm/
│   │   ├── FavoritePlace.swift
│   │   └── RealmManager.swift
│   ├── service/
│   │   ├── LocationManager.swift
│   │   ├── RealSearchService.swift
│   │   └── SearchService.swift
│   ├── viewModels/
│   │   ├── MapViewModel.swift
│   │   ├── SavedPlacesViewModel.swift
│   │   └── SearchCompleterViewModel.swift
│   ├── views/
│   │   ├── mapView/
│   │   │   ├── MainMapView.swift
│   │   │   └── MapViewSection.swift
│   │   ├── placeDetails/
│   │   │   ├── LookAroundViewController.swift
│   │   │   └── PlaceDetailSheet.swift
│   │   ├── savedPlaceView/
│   │   │   ├── SavedPlaceMapView.swift
│   │   │   └── SavedPlacesView.swift
│   │   ├── search/
│   │   └── tabView/
│   └── Info.plist
├── LincRideAssessmentTests/
│   ├── LincRideAssessmentTests.swift
│   ├── MapViewModelTests.swift
│   ├── MockRealmManager.swift
│   ├── MockSearchService.swift
│   └── SavedPlacesViewModelTests.swift
└── LincRideAssessmentUITests/
    └── LincRideAssessmentUITests.swift
```

---

## 9. Dependencies

1. **RealmSwift** – via Swift Package Manager
2. Native frameworks:

   * MapKit
   * CoreLocation
   * SwiftUI

---

## 10. Contact

* **Name**: Michael Ossai
* 📧 **Email**: [ossaimike8@gmail.com](mailto:ossaimike8@gmail.com)
* 📱 **Phone**: +2347086737758

