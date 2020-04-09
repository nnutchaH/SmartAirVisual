//
//  CitiesViewController.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 2/1/2563 BE.
//  Copyright © 2563 Nutnutcha Hanggitthagul. All rights reserved.
//

import Foundation
import Moya

class CitiesViewController: UITableViewController {
    
    private var filteredCities: [City] = [] {
        didSet { didSetFilteredCities(oldValue) } }
    private var cities: [City] = [] {
        didSet { didSetCities(oldValue) } }
    
    private let CityRequest = AirVisualRequest()
    var state: State?
    
    @IBOutlet private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CityRequest
            .requestCitiesData(
                state: state?.state ?? "", callback: { [weak self] in
                    self?.handleResponse(result: $0) })
        tableView.rowHeight = 44.0
    }
    
    private func handleResponse(result: Result<CitiesData, Error>) {
        switch result {
        case .success(let citiesData):
            cities = citiesData.data
        case .failure(let error):
            print("error: \(error)")
        }
    }
    
    private func didSetCities(_ oldValue: [City]) {
        tableView.reloadData()
    }
    
    private func didSetFilteredCities(_ oldValue: [City]) {
        tableView.reloadData()
    }
    
    
}

extension CitiesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCityIndex = indexPath.row
        let city: City
        
        if (searchBar.text ?? "").isEmpty {
            city = cities[selectedCityIndex]
        } else {
            city = filteredCities[selectedCityIndex]
        }
        
        let destinationViewController = navigationController?.viewControllers.first as? AqiViewController
        destinationViewController?.city = city
        destinationViewController?.state = state
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchBar.text ?? "").isEmpty {
            return cities.count
        } else {
            return filteredCities.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesTableViewCell", for: indexPath) as? CitiesTableViewCell {
            let city: City
            
            if searchBar.text?.isEmpty == true {
                city = cities[indexPath.row]
            } else {
                city = filteredCities[indexPath.row]
            }
            
            cell.cities = city.city
            return cell
        } else {
            fatalError()
        }
    }
}

extension CitiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchLogic(from: searchText)
    }
    
}

extension CitiesViewController {
    
    func handleSearchLogic(from searchText: String) {
        filteredCities = cities.filter { $0.city.lowercased().hasPrefix(searchText.lowercased()) }
    }
    
}







