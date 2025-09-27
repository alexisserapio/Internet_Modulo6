//
//  WebViewController.swift
//  Internet
//
//  Created by UNAM on 26/09/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{
    
    var webView: WKWebView!
    var actI: UIActivityIndicatorView!

    override func viewDidLoad() {
            super.viewDidLoad()
            webView = WKWebView(frame:view.bounds)
            webView.navigationDelegate = self
            self.view.addSubview(webView)
            actI = UIActivityIndicatorView()
            actI.center = view.center
            self.view.addSubview(actI)
            actI.hidesWhenStopped = true
            actI.style = .large
            actI.tintColor = .red
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let urlStr = "https://www.tic.unam.mx/"
            if let url = URL(string: urlStr) {
                let request = URLRequest(url:url)
                webView.load(request)
                actI.startAnimating()
            }
        }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        actI.stopAnimating()
        let alert = UIAlertController(title:"atención!", message:"No fue posible cargar la página web", preferredStyle:.alert)
        let btnAceptar = UIAlertAction(title:"ok", style:.default, handler:nil)
        alert.addAction(btnAceptar)
        self.present(alert, animated:true, completion:nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        actI.stopAnimating()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
