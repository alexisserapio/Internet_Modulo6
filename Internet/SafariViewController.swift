//
//  SafariViewController.swift
//  Internet
//
//  Created by UNAM on 26/09/25.
//
import SafariServices

class SafariViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear los botones
        let button1 = UIButton(type: .system)
        button1.setTitle("Mostrar SFViewController", for: .normal)
        button1.backgroundColor = .systemBlue
        button1.setTitleColor(.white, for: .normal)
        button1.layer.cornerRadius = 8
        button1.addTarget(self, action: #selector(boton1Tocado), for: .touchUpInside)
        
        let button2 = UIButton(type: .system)
        button2.setTitle("Abrir Safari", for: .normal)
        button2.backgroundColor = .systemGreen
        button2.setTitleColor(.white, for: .normal)
        button2.layer.cornerRadius = 8
        button2.addTarget(self, action: #selector(boton2Tocado), for: .touchUpInside)
        
        // Crear el stack view
        let stackView = UIStackView(arrangedSubviews: [button1, button2])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Agregar el stack view a la vista principal
        view.addSubview(stackView)
        
        // Constraints del stack view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Acciones de los botones
    @objc func boton1Tocado() {
        if InternetMonitor.shared.hayConexion {
            if let url = URL(string: "https://apod.nasa.gov/apod/") {
                let sfvc = SFSafariViewController(url: url)
                self.present(sfvc, animated: true)
            }
        }
    }
    
    @objc func boton2Tocado() {
        if let url = URL(string: "https://apod.nasa.gov/apod/"){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            }
        }
        print("Botón 2 fue tocado")
    }
}
