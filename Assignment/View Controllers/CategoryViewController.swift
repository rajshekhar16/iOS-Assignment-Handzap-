//
//  ViewController.swift
//  Assignment
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

protocol CategorySelectionProtocol: class
{
    func didSelectCategories(categoriesSelected: Int)
}

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var selectedCategoryView: UIView!
    @IBOutlet weak var categorySelectionLabel: UILabel!

    weak var delegate: CategorySelectionProtocol?
    
    var cellWidth = CGFloat()
    var cellSize = CGRect()
    var selectionCount = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.categoriesCV.dataSource = self
        self.categoriesCV.delegate = self
        
        self.categoriesCV.register(UINib.init(nibName: Nib.kCategoryCollCell, bundle: nil), forCellWithReuseIdentifier: Identifier.kCategoryCollCell)
        
        self.categorySelectionLabel.text = ""
        self.title = "Post Categories"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(addTapped))

        self.createGradientLayer()
        
    }
    
    @objc func addTapped(){
        self.delegate?.didSelectCategories(categoriesSelected: self.selectionCount)
        self.navigationController?.popViewController(animated: true)
    }
}


extension CategoryViewController:UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenWidth = UIScreen.main.bounds.size.width
        let cellWidth = floor((screenWidth-5) / 3)
        return CGSize.init(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.init(top: 1, left: 0, bottom: 1, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.kCategoryCollCell, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollCell
        
     
        if cell.isFlipped == false
        {
            if self.selectionCount < 3
            {
                
            self.selectionCount = self.selectionCount + 1
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                cell.isFlipped = true
                cell.categoryImageView.isHidden = true
                cell.contentView.backgroundColor = UIColor.init(red: 211.0/255.0, green: 244.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                cell.updateView()
            }, completion: nil)
            }
        }
        else
        {
            self.selectionCount = self.selectionCount - 1
            
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                cell.isFlipped = false
                cell.categoryImageView.isHidden = false
                cell.contentView.backgroundColor = UIColor.white
                cell.updateView()
            }, completion: nil)
        }
        
        self.categorySelectionLabel.text = "\(self.selectionCount) Selected"
        
        if self.selectionCount == 0
        {
            self.categorySelectionLabel.isHidden = true
        }
        else
        {
            self.categorySelectionLabel.isHidden = false
        }
            
   
    }
    
    func createGradientLayer()
    {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        let topColor = UIColor.init(red: 57.0/255.0, green: 158.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        let bottomColor = UIColor.init(red: 39.0/255.0, green: 108.0/255.0, blue: 131.0/255.0, alpha: 1.0)

        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        self.selectedCategoryView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func categorySelectionButtonTapped(sender: UIButton)
    {
        self.delegate?.didSelectCategories(categoriesSelected: self.selectionCount)
    }
    
}

