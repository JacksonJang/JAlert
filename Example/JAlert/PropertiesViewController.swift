import UIKit
import JAlert

@available(iOS 11.0, *)
class PropertiesViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(ExampleListCell.self, forCellReuseIdentifier: ExampleListCell.identifier)
        tv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        return tv
    }()
    
    var data:[String] = [
        "Change Margin",
        "Change BorderColor",
        "Change ContentBorderColor",
        "Change Font",
        "Change BackgroundColor"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

@available(iOS 11.0, *)
extension PropertiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleListCell.identifier, for: indexPath) as! ExampleListCell
        let index = indexPath.row
        
        cell.createTitleLabel(text: data[index])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        switch index {
        case 0:
            let config = JConfig()
            config.titleTopMargin = 30
            config.titleLeftMargin = 30
            config.titleRightMargin = 30
            config.betweenTitleAndMessageMargin = 30
            config.messageLeftMargin = 40
            config.messageRightMargin = 40
            config.messageBottomMargin = 30
            JAlert.configuration(config: config)
            
            JAlert.show(title: "title test title test title test title test title test",
                        message: "message test")
            break;
        case 1:
            let config = JConfig()
            config.borderColor = .blue
            JAlert.configuration(config: config)
            JAlert.show(title: "title test title test title test title test title test",
                        message: "message test", buttonTitles: ["OK", "NO"])
        case 2:
            let config = JConfig()
            config.contentBorderWidth = 1.0
            config.contentBorderColor = .red
            JAlert.configuration(config: config)
            JAlert.show(title: "title test title test title test title test title test",
                        message: "message test", buttonTitles: ["OK", "NO"])
        case 3:
            let config = JConfig()
            config.titleFont = .systemFont(ofSize: 20, weight: .bold)
            config.messageFont = .systemFont(ofSize: 20, weight: .bold)
            config.buttonsFont = [
                .systemFont(ofSize: 20, weight: .bold),
                .systemFont(ofSize: 20, weight: .bold)
            ]
            JAlert.configuration(config: config)
            JAlert.show(title: "title test title test title test title test title test",
                        message: "message test", buttonTitles: ["OK", "NO"])
        case 4:
            let config = JConfig()
            config.backgroundColor = .blue
            JAlert.configuration(config: config)
            JAlert.show(title: "title test title test title test title test title test",
                        message: "message test", buttonTitles: ["OK", "NO"])
        default:
            print("not exist")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
