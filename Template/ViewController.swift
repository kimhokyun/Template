
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
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        collectionView.delegate = self
//        collectionView.dataSource = self

        
        let decoder: JSONDecoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: "SampleData") as? Data,
           let sampleDatas = try? decoder.decode([SampleData].self, from: data) {
            self.sampleDatas = sampleDatas
            tableView.reloadData()
        }
        
    }
    
    @IBAction func nextPage(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen // fullscreen으로 해야 viewWillAppear 을 호출함
//        vc.feed = self.feed
        self.navigationController?.pushViewController(vc, animated: true)
        self.dismiss(animated: false){
            self.present(vc, animated: false)
        }
    }
}



//extension ViewController:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sampleDatas.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
//        let celldata = self.sampleDatas[indexPath.row]
//
////        cell.titleLabel.text = celldata.title
////        cell.contentsLabel.text = celldata.contents
////        guard let pd = celldata.photo else {return cell}
////        cell.photoImageView.image =  UIImage(data: pd)
//
//        return cell
//    }
//}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 7
        }else{
            //            return sampleDatas.count
            return 42
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
//        let celldata = self.sampleDatas[indexPath.row]
        
        if indexPath.section == 0 {
//            cell.dayLabel.text = "요일"
        }else {
            
        }
        
        
//        cell.titleLabel.text = celldata.title
//        cell.contentsLabel.text = celldata.contents
//        guard let pd = celldata.photo else {return cell}
//        cell.photoImageView.image =  UIImage(data: pd)
        
        return cell
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        let numberOfColumns: CGFloat = 7  // Number of columns in a week
        let cellWidth = collectionView.bounds.width / numberOfColumns
        let cellSize = CGSize(width: cellWidth, height: cellWidth)
        
        return cellSize
    }
    
    // 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 같은 행에 있는 항목 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController:SendDataProtocol{
    func receiveData(data: SampleData) {
        self.sampleDatas.append(data)
    }
}
