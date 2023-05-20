//
//  HomeViewController.swift
//  Currency
//
//  Created by Mohamed Ibrahim on 20/05/2023.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController ,UICollectionViewDelegateFlowLayout{
    private var viewModel : HomeViewModel?
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupCollectionView()
        setupDateLabel()
        viewModel?.loadLatest(base: baseTextField.text ?? "EUR")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    @IBAction func update(_ sender: Any) {
        viewModel?.loadLatest(base: baseTextField.text ?? "EUR")
    }
    
    
    func initViewModel(){
        viewModel =  HomeViewModelImpl(webservice: ExchangeRatesWebserviceImpl())
    }
    
    func setupCollectionView(){
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel?.rates.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: RateCollectionViewCell.self)){ (row,data,cell) in
            cell.setValues(name: data.key, value: data.value)
        }.disposed(by: disposeBag)
    }
    func setupDateLabel(){
        viewModel?.lastUpdate.bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        return CGSize(width: width, height: width)
    }
}
