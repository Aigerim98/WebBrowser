//
//  MasterViewController.swift
//  WebBrowser
//
//  Created by Aigerim Abdurakhmanova on 05.07.2022.
//

import UIKit
import WebKit

class MasterViewController: UIViewController {

    private lazy var webpages: [Webpage] = allPages
    
    private var favoritePages: [Webpage] = []
    
    private var allPages: [Webpage] = [Webpage(name: "Apple", url: "https://www.apple.com")]
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func AddButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add website", message: "Fill all the fields", preferredStyle: .alert)
            alert.addTextField { (textField:UITextField) in
                textField.placeholder = "Enter title"
            }
            alert.addTextField { (textField:UITextField) in
                textField.placeholder = "Enter url"
            }
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [self] (action:UIAlertAction) in
                guard let firstTextField = alert.textFields?[0], let name = firstTextField.text, firstTextField.hasText else {return}
                guard let secondTextField = alert.textFields?[1], let url = secondTextField.text, secondTextField.hasText else {return}
                let webpage = Webpage(name: name, url: url)
                allPages.append(webpage)
                webpages.append(webpage)
                tableView.reloadData()
            }))
            self.present(alert, animated: true, completion: nil)
    }

    @IBAction func switchBetweenPages(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            webpages = allPages
        case 1:
            webpages = favoritePages
        default:
            break
        }
        tableView.reloadData()
    }
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        webpages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.configureCell(with: webpages[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController.makeDetailsViewController(name: webpages[indexPath.row].name, url: webpages[indexPath.row].url)
        vc.favoritePageDelegate = self
        splitViewController?.showDetailViewController(vc, sender: self)
    }
}

extension MasterViewController: AddFavoritePageDelegate {
    
    func addFavorite(webPage: Webpage) {
        self.favoritePages.append(webPage)
        tableView.reloadData()
    }
    
//    func deleteFavorite(webPage: Webpage) {
//        if let index = favoritePages.firstIndex(where: {$0.name == webPage.name && $0.url == webPage.url}) {
//            favoritePages.remove(at: index)
//            tableView.reloadData()
//            print(index)
//        }
//    }
    
}

