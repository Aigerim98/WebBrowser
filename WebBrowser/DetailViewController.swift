//
//  DetailViewController.swift
//  WebBrowser
//
//  Created by Aigerim Abdurakhmanova on 04.07.2022.
//

import UIKit
import WebKit

protocol AddFavoritePageDelegate: AnyObject {
    func addFavorite(webPage: Webpage)
   // func deleteFavorite(webPage: Webpage)
}

class DetailViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    private var url: String = "https://www.apple.com"
    private var name: String = "Apple"
    weak var favoritePageDelegate: AddFavoritePageDelegate?
    
    static func makeDetailsViewController(name: String, url: String) -> DetailViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.url = url
        vc.name = name
        vc.title = vc.name
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = name
        loadPage()
        addFavoritePageByTap()
        
        activityIndicator.startAnimating()
        webView.navigationDelegate = self
        activityIndicator.hidesWhenStopped = true
        
        //webView.allowsLinkPreview = false
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func loadPage() {
        guard let url = URL(string: url) else { return }
        let request =  URLRequest(url: url)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func addFavoritePageByTap() {
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGestureRecognizer.delegate = self
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
       
        webView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        var timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.setBackgroundColor), userInfo: nil, repeats: true)
    }
    
    @objc private func handleDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        view.backgroundColor = .systemYellow
        print("double tap")
        
//        guard let name = name else {
//            print("empty")
//            return
//        }
        
        let favoriteWebPage = Webpage(name: name, url: url)
        favoritePageDelegate?.addFavorite(webPage: favoriteWebPage)
        //favoritePageDelegate?.deleteFavorite(webPage: favoriteWebPage)
    }
    
    @objc private func setBackgroundColor() {
        view.backgroundColor = .white
    }

}

extension DetailViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        true
    }
}
