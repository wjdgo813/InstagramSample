//
//  ViewController.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 09/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

final class ProfileViewController: BaseViewController {

    @IBOutlet private weak var profileCollectionView: UICollectionView!
    
    private let viewModel = ProfileViewModel()
    private var dataSource : RxCollectionViewSectionedAnimatedDataSource<SectionOfMedia>?
    private var disposeBag: DisposeBag{
        return viewModel.disposeBag
    }
    
    
    override func setupUI() {
        self.setupCollectionView()
    }
    
    
    override func setupBind() {
        self.bindInput()
        self.bindOutput()
    }
    
    
    private func bindInput(){
        self.rx.viewWillAppear.bind(to: self.viewModel.profileTrigger)
            .disposed(by:self.disposeBag)
    }
    
    
    private func bindOutput(){
        guard let dataSource = self.dataSource,
            let media = self.viewModel.media
        else { return }
        
        media.drive(self.profileCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
}


//MARK: Set UIViewController
extension ProfileViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    private func setupCollectionView(){
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell:collectionViewDataSourceUI().0,
            configureSupplementaryView:collectionViewDataSourceUI().1
        )
        
        self.profileCollectionView.backgroundColor = UIColor.white
        self.profileCollectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        self.profileCollectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderIdentifier)
    }
}

//MARK: CollectionView DataSoruce
extension ProfileViewController{
    private func collectionViewDataSourceUI() -> (
        CollectionViewSectionedDataSource<SectionOfMedia>.ConfigureCell,
        CollectionViewSectionedDataSource<SectionOfMedia>.ConfigureSupplementaryView){
            return (collectionViewDataSourceConfigureCell(),
                    collectionViewDataSourceConfigureConfigureSupplementaryView())
    }
    
    
    
    private func collectionViewDataSourceConfigureCell() -> CollectionViewSectionedDataSource<SectionOfMedia>.ConfigureCell{
        return { (dataSource, collectionView, indexPath, item) in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCell{
                cell.contentData = item
                cell.setupUI()
                return cell
            }

            return UICollectionViewCell()
        }
    }
    
    
    private func collectionViewDataSourceConfigureConfigureSupplementaryView() -> CollectionViewSectionedDataSource<SectionOfMedia>.ConfigureSupplementaryView{
        return {
             (dataSource ,collectionView, kind, indexPath) in
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: profileHeaderIdentifier, for: indexPath) as? ProfileHeaderView{
                header.nameLabel?.text = dataSource[indexPath.row].header.data?.fullName ?? "JHH"
                return header
            }
            return UICollectionReusableView()
        }
    }
}

//MARK: CollectionView FlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 3, height: 50)
    }
}
