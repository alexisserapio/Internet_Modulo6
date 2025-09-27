//
//  SafariViewController.swift
//  Internet
//
//  Created by UNAM on 26/09/25.
//
import SafariServices
class SafariViewController: UIViewController{
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        if let url = URL(string: "https://apod.nasa.gov/apod/"){
            let sfvc = SFSafariViewController(url: url)
            self.present(sfvc, animated: true)
        }
    }
}
