//
//  StateViewController.swift
//  Smart Air Visul
//
//  Created by Nutnutcha Hanggitthagul on 26/12/2562 BE.
//  Copyright © 2562 Nutnutcha Hanggitthagul. All rights reserved.
//

import Foundation
import Moya

class StateViewController: UITableViewController {
    
    private var filteredStates: [State] = [] {
           didSet { didSetFilteredStates(oldValue) } }
    private var states: [State] = [] {
        didSet { didSetStates(oldValue) } }
    
    let stateRequest = AirVisualRequest()
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateRequest
            .requestStatesData(
                callback: { [weak self] in
                    self?.handleResponse(result: $0) })
        tableView.rowHeight = 44.0
    }
    
    private func handleResponse(result: Result<StatesData, Error>) {
        switch result {
        case .success(let statesData):
            states = statesData.data
        case .failure(let error):
            print("error: \(error)")
        }
    }
    
    private func didSetStates(_ oldValue: [State]) {
        tableView.reloadData()
    }
    
    private func didSetFilteredStates(_ oldValue: [State]) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedStateIndex = tableView.indexPathForSelectedRow?.row {
            let state: State
            
            if (searchBar.text ?? "").isEmpty {
                state = states[selectedStateIndex]
            } else {
                state = filteredStates[selectedStateIndex]
            }
            
            let destinationViewController = segue.destination as? CitiesViewController
            destinationViewController?.state = state
        }
    }
}

extension StateViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchBar.text ?? "").isEmpty {
            return states.count
        } else {
            return filteredStates.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StateTableViewCell", for: indexPath) as? StateTableViewCell {
            let state: State
            
            if searchBar.text?.isEmpty == true {
                state = states[indexPath.row]
            } else {
                state = filteredStates[indexPath.row]
            }
            
            cell.state = state.state
            return cell
        } else {
            fatalError()
        }
    }
    
}

extension StateViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchLogic(from: searchText)
    }
    
}

extension StateViewController {
    
    func handleSearchLogic(from searchText: String) {
        filteredStates = states.filter { $0.state.lowercased().hasPrefix(searchText.lowercased()) }
    }
    
}
