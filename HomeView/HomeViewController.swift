import Foundation
import UIKit

class HomeViewController: UIViewController {
    private let service = HomeService()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        view.addSubview(resultLabel)
        setUpContraints()
        fetchData()
    }
    
    private func setUpContraints() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func fetchData() {
        service.fetchUser { [weak self] result in
            DispatchQueue.main.async {
                guard let result = result else {
                    self?.resultLabel.text = "Error fetching data"
                    return
                }
                let names = result.map { "\($0.name) - \($0.email)" }.joined(separator: "\n\n")
                self?.resultLabel.text = names
            }
        }
    }
}
