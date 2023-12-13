import UIKit

class HistoryTableViewController: UITableViewController {
    var gameRecords: [GameRecord] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as! HistoryTableViewCell

        let gameRecord = gameRecords[indexPath.row]
        let message = "range: \(gameRecord.start) ~ \(gameRecord.end)  , input: \(gameRecord.input)"
        
        cell.resultLabel.textColor = .red
        if gameRecord.result {
            cell.resultLabel.textColor = .green
        }
        
        cell.resultLabel.text = "\(gameRecord.result)"
        cell.detailLabel.text = message
        
        return cell
    }
}
