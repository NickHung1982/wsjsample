//
//  MainTableViewController.swift
//  WSJ
//
//  Created by Nick on 5/13/19.
//  Copyright © 2019 NickOwn. All rights reserved.
//

import UIKit


class MainTableViewController: UITableViewController {
    let viewModel = MainViewModel(Source: .Business)
    
    lazy var loadingIdicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting UIBarButtonItem
        let leftButton = UIBarButtonItem(customView: loadingIdicator)
        self.navigationItem.setLeftBarButton(leftButton, animated: true)
        let rightButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(changeSource))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        
        //register tableview cell
        self.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseID)
        
        initBinding()
        viewModel.start()
    }

    @objc func changeSource() {
        let alertController = UIAlertController(title: "RSS Source", message: nil, preferredStyle: .actionSheet)
        
        for name in WSJRSSSource.allCases {
            
           alertController.addAction(UIAlertAction(title: "\(name)",
                    style: .default,
                    handler: { (action) in
              self.viewModel.changeSource(source: name)
           }))
        }
       
        let cancel = UIAlertAction(title: "DISMISS", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func initBinding() {
        viewModel.rssItems.addObserver(fireNow: false) { [weak self] ([RSS]) in
            self?.tableView.reloadData()
        }
        
        viewModel.isTableViewHidden.addObserver { [weak self] (isHidden) in
            self?.tableView.isHidden = isHidden
        }
        
        viewModel.title.addObserver { [weak self] (title) in
            print("now title: \(title)")
            self?.navigationItem.title = title
        }
        
        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.loadingIdicator.startAnimating()
            } else {
                self?.loadingIdicator.stopAnimating()
            }
        }
        
    }

   
}

extension MainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rssItems.value.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseID, for: indexPath) as? MainTableViewCell ?? MainTableViewCell()
        
        cell.setup(feed: viewModel.rssItems.value[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel.rssItems.value.count {
           let webVC = webviewViewController()
           webVC.weburl = URL(string: viewModel.rssItems.value[indexPath.row].link)!
           self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
}
