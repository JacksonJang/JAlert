import UIKit
import JAlert

class BasicViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data:[String] = [
        "default",
        "Add buttonTitles",
        "Add completion",
        "Only title",
        "Only message"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension BasicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleListCell.identifier, for: indexPath) as! ExampleListCell
        let index = indexPath.row
        
        cell.titleLabel.text = data[index]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        switch index {
        case 0:
            JAlert.configuration(config: JConfig())
            JAlert.show(title: "title test",
                        message: "message test")
            break;
        case 1:
            JAlert.configuration(config: JConfig())
            JAlert.show(title: "title test", message: "message test", buttonTitles: ["YES", "NO"])
            break;
        case 2:
            JAlert.configuration(config: JConfig())
            JAlert.show(title: "title test",
                        message: "message test",
                        buttonTitles: ["YES", "NO"]) { (index) in
                print("index : ", index)
            }
            break;
        case 3:
            JAlert.configuration(config: JConfig())
            JAlert.show(title: "title test")
            break;
        case 4:
            JAlert.configuration(config: JConfig())
            JAlert.show(message:"message test")
            break;
        default:
            print("not exist")
        }
    }
}
