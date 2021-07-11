//
//  ViewController.swift
//  AirTableExample
//
//  Created by Kinjal Pipaliya on 10/07/21.
//

import UIKit
import SwiftAirtable

class ViewController: UIViewController {
    
    // MARK: - Public
    
    // Generate this at https://api.airtable.com
    let apiKey = "keyEcvhKRGfKfR6uG"
    
    // The link to the base you want to fetch
    let apiBaseUrl = "https://api.airtable.com/v0/app4PdlNuCvjGUeEN"
    
    // The object schema to be used when fetching from Airtable
    let schema = User.schema
    
    // The name of the table inside the base
    let table = "Contacts"
    
    var userArray = [User]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(UINib(nibName: "CodeTableViewCell", bundle: nil), forCellReuseIdentifier: "CodeTableViewCell")
        }
    }
    
    // The component that adds a loading indicative to a view
    var loadingComponent: LoadingComponent!
}

extension ViewController {
    var airtable: Airtable {
        return Airtable(apiKey: self.apiKey, apiBaseUrl: self.apiBaseUrl, schema: self.schema)
    }
}

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAndReload(using: self.airtable)
    }
    
    // MARK: - Actions
    @IBAction func didPressReload(_ sender: UIBarButtonItem) {
        updateAndReload(using: self.airtable)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeTableViewCell", for: indexPath) as! CodeTableViewCell
        cell.name.text = self.userArray[indexPath.row].name
        cell.contact.text = self.userArray[indexPath.row].contact
        return cell
    }
}

// MARK: - Private
extension ViewController {
    
    private func updateAndReload(using airtable: Airtable) {
        
        self.loadingComponent = LoadingComponent(targetView: self.tableView)
        self.loadingComponent.addLoadingIndicator()
        
        let table = self.table
        airtable.fetchAll(table: table) { [weak self] (objects: [User], error: Error?) in
            
            DispatchQueue.main.async {
                self?.loadingComponent.removeLoadingIndicators()
            }
            
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self?.userArray = objects
                    print("Result:\(objects)")
        
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
