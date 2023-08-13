
import UIKit

protocol SendDataProtocol {
    func receiveData(data:SampleData)
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    var sampleData = SampleData()
    var sampleDatas = [SampleData](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.sampleDatas) {
                UserDefaults.standard.setValue(encoded, forKey: "sampleDatas")
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let decoder: JSONDecoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: "SampleData") as? Data,
           let sampleDatas = try? decoder.decode([SampleData].self, from: data) {
            self.sampleDatas = sampleDatas
            tableView.reloadData()
        }
    }
    
}



extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let celldata = self.sampleDatas[indexPath.row]
        
//        cell.titleLabel.text = celldata.title
//        cell.contentsLabel.text = celldata.contents
//        guard let pd = celldata.photo else {return cell}
//        cell.photoImageView.image =  UIImage(data: pd)
        
        return cell
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        let celldata = self.sampleDatas[indexPath.row]
        
//        cell.titleLabel.text = celldata.title
//        cell.contentsLabel.text = celldata.contents
//        guard let pd = celldata.photo else {return cell}
//        cell.photoImageView.image =  UIImage(data: pd)
        
        return cell
    }
    
}

extension ViewController:SendDataProtocol{
    func receiveData(data: SampleData) {
        self.sampleDatas.append(data)
    }
}
