import UIKit

class HistoryTableViewCell: UITableViewCell {
    static let identifier = "HistoryTableViewCellID"
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(resultLabel)
        contentView.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            detailLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
