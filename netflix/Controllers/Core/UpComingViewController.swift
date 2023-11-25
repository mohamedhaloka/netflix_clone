//
//  UpComingViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 04/11/2023.
//

import UIKit

class UpComingViewController: UIViewController {

    var items : [MovieItemResponse] = []
    
    var page : Int = 1
    
    let tableView : UITableView = {
        let uiTableView : UITableView = UITableView()
        uiTableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.idntifier)
        return uiTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Upcomig Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        getUpcomingMovies()
    }
    
    
    private func getUpcomingMovies(){
        APICaller.shared.getMovies(urlString: "\(Constants.baseUrl)3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=\(page)") { result in
            switch(result){
            case .success(let movies):
                self.items.append(contentsOf: movies);
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break;
            case .failure(let error):
                self.page = self.page - 1
                print("Error whild getting data \(error.localizedDescription)")
                break;
            }
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    

}


extension UpComingViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.idntifier, for: indexPath) as?  UpComingTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(movie: items[indexPath.row])
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieTitle = items[indexPath.row].original_name ?? items[indexPath.row].original_title else {
            return
        }
        
        APICaller.shared.getYoutubeVideoDetials(videoTitle: movieTitle) { result in
            switch(result){
            case .success(let video):
                DispatchQueue.main.async {
                    
                    let vc = MovieDetailsViewController()
                    vc.configure(videoData: video, movieDetails: self.items[indexPath.row])
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                break;
            case .failure(let error):
                print("ERROR VIDEO DATA \(error.localizedDescription)")
                break;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            self.page = self.page + 1
            getUpcomingMovies()
        }
    }
}
