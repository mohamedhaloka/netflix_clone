//
//  CollectionViewTableViewCell.swift
//  netflix
//
//  Created by Mohamed Nasr on 07/11/2023.
//

import UIKit

protocol CollectionViewTableViewCellDidCellTapedDelegate : AnyObject {
    func collectionViewTableViewCellDidCellTaped(videoData : VideoModel,movieDetails : MovieItemResponse)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    
    
    var items : [MovieItemResponse] = []
    
    
    weak var delegate : CollectionViewTableViewCellDidCellTapedDelegate?
    
    private let contentCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView;
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemRed
        contentView.addSubview(contentCollectionView)
        
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentCollectionView.frame = contentView.bounds
    }
    
    
    func configure (items : [MovieItemResponse]){
        self.items = items
        
        DispatchQueue.main.async {
            self.contentCollectionView.reloadData()
        }
    }
    
    private func downloadItem(index : Int){
        DataPresentManager.shared.saveItem(movie: items[index]) { result in
            switch result {
            case .success(_):
                print("Saved Successfully")
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
}

extension CollectionViewTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(movie: items[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard delegate != nil  else {
            return 
        }
        
        guard let movieTitle = items[indexPath.row].original_name ?? items[indexPath.row].original_title else {
            return
        }
        
        APICaller.shared.getYoutubeVideoDetials(videoTitle: movieTitle) { result in
            switch(result){
            case .success(let video):
                self.delegate?.collectionViewTableViewCellDidCellTaped(videoData: video,movieDetails: self.items[indexPath.row])
                break;
            case .failure(let error):
                print("ERROR VIDEO DATA \(error.localizedDescription)")
                break;
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(actionProvider:  { _ in
            let downloadedAction = UIAction(title: "Download") { [weak self] _ in
                self?.downloadItem(index: indexPath.row)
            }
            
            return UIMenu(children: [downloadedAction])
        })
        return config
    }
    
    
    
}
