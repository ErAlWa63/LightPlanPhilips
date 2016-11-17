//
//  CreateLightGroupBulbCollectionView.swift
//  LightPlanPhilips
//
//  Created by Erik Waterham on 17/11/2016.
//  Copyright © 2016 The App Academy. All rights reserved.
//
// http://stackoverflow.com/questions/31582378/ios-8-swift-tableview-with-embedded-collectionview
//
// http://stackoverflow.com/questions/17856055/creating-a-uicollectionview-programmatically

import UIKit

class CreateLightGroupBulbCollectionView: UICollectionView {
  
  var collectionView: UICollectionView!
  

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
  
//  public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
//  
//  public init?(coder aDecoder: NSCoder)
//  
//  
//  open var collectionViewLayout: UICollectionViewLayout
//  
//  weak open var delegate: UICollectionViewDelegate?
//  
//  weak open var dataSource: UICollectionViewDataSource?
//  
//  
//  @available(iOS 10.0, *)
//  weak open var prefetchDataSource: UICollectionViewDataSourcePrefetching?
//  
//  @available(iOS 10.0, *)
//  open var isPrefetchingEnabled: Bool
//  
//  
//  open var backgroundView: UIView? // will be automatically resized to track the size of the collection view and placed behind all cells and supplementary views.
//  
//  
//  // For each reuse identifier that the collection view will use, register either a class or a nib from which to instantiate a cell.
//  // If a nib is registered, it must contain exactly 1 top level object which is a UICollectionViewCell.
//  // If a class is registered, it will be instantiated via alloc/initWithFrame:
//  open func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String)
//  
//  open func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
//  
//  
//  open func register(_ viewClass: Swift.AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String)
//  
//  open func register(_ nib: UINib?, forSupplementaryViewOfKind kind: String, withReuseIdentifier identifier: String)
//  
//  
//  open func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell
//  
//  open func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView
//  
//  
//  // These properties control whether items can be selected, and if so, whether multiple items can be simultaneously selected.
//  open var allowsSelection: Bool // default is YES
//  
//  open var allowsMultipleSelection: Bool // default is NO
//  
//  
//  open var indexPathsForSelectedItems: [IndexPath]? { get } // returns nil or an array of selected index paths
//  
//  
//  // returns nil or an array of selected index paths
//  
//  open func selectItem(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition)
//  
//  open func deselectItem(at indexPath: IndexPath, animated: Bool)
//  
//  
//  open func reloadData() // discard the dataSource and delegate data and requery as necessary
//  
//  
//  open func setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool) // transition from one layout to another
//  
//  @available(iOS 7.0, *)
//  open func setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool, completion: ((Bool) -> Swift.Void)? = nil)
//  
//  
//  @available(iOS 7.0, *)
//  open func startInteractiveTransition(to layout: UICollectionViewLayout, completion: UIKit.UICollectionViewLayoutInteractiveTransitionCompletion? = nil) -> UICollectionViewTransitionLayout
//  
//  @available(iOS 7.0, *)
//  open func finishInteractiveTransition()
//  
//  @available(iOS 7.0, *)
//  open func cancelInteractiveTransition()
//  
//  
//  // Information about the current state of the collection view.
//  
//  open var numberOfSections: Int { get }
//  
//  
  open override func numberOfItems(inSection section: Int) -> Int {
    return 2
  }
//
//  
//  open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
//  
//  open func layoutAttributesForSupplementaryElement(ofKind kind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
//  
//  
//  open func indexPathForItem(at point: CGPoint) -> IndexPath?
//  
//  open func indexPath(for cell: UICollectionViewCell) -> IndexPath?
//  
//  
//  open func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell?
//  
//  
//  open var visibleCells: [UICollectionViewCell] { get }
//  
//  open var indexPathsForVisibleItems: [IndexPath] { get }
//  
//  
//  @available(iOS 9.0, *)
//  open func supplementaryView(forElementKind elementKind: String, at indexPath: IndexPath) -> UICollectionReusableView?
//  
//  @available(iOS 9.0, *)
//  open func visibleSupplementaryViews(ofKind elementKind: String) -> [UICollectionReusableView]
//  
//  @available(iOS 9.0, *)
//  open func indexPathsForVisibleSupplementaryElements(ofKind elementKind: String) -> [IndexPath]
//  
//  
//  // Interacting with the collection view.
//  
//  open func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionViewScrollPosition, animated: Bool)
//  
//  
//  // These methods allow dynamic modification of the current set of items in the collection view
//  open func insertSections(_ sections: IndexSet)
//  
//  open func deleteSections(_ sections: IndexSet)
//  
//  open func reloadSections(_ sections: IndexSet)
//  
//  open func moveSection(_ section: Int, toSection newSection: Int)
//  
//  
//  open func insertItems(at indexPaths: [IndexPath])
//  
//  open func deleteItems(at indexPaths: [IndexPath])
//  
//  open func reloadItems(at indexPaths: [IndexPath])
//  
//  open func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath)
//  
//  
//  open func performBatchUpdates(_ updates: (() -> Swift.Void)?, completion: ((Bool) -> Swift.Void)? = nil) // allows multiple insert/delete/reload/move calls to be animated simultaneously. Nestable.
//  
//  
//  // Support for reordering
//  @available(iOS 9.0, *)
//  open func beginInteractiveMovementForItem(at indexPath: IndexPath) -> Bool // returns NO if reordering was prevented from beginning - otherwise YES
//  
//  @available(iOS 9.0, *)
//  open func updateInteractiveMovementTargetPosition(_ targetPosition: CGPoint)
//  
//  @available(iOS 9.0, *)
//  open func endInteractiveMovement()
//  
//  @available(iOS 9.0, *)
//  open func cancelInteractiveMovement()
//  
//  
//  // Support for Focus
//  @available(iOS 9.0, *)
//  open var remembersLastFocusedIndexPath: Bool // defaults to NO. If YES, when focusing on a collection view the last focused index path is focused automatically. If the collection view has never been focused, then the preferred focused index path is used.
//
}

extension CreateLightGroupViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }

//  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//  @available(iOS 6.0, *)
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
//
//  
//  @available(iOS 6.0, *)
//  optional public func numberOfSections(in collectionView: UICollectionView) -> Int
//  
//  
//  // The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//  @available(iOS 6.0, *)
//  optional public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
//  
//  
//  @available(iOS 9.0, *)
//  optional public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
//  
//  @available(iOS 9.0, *)
//  optional public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
//
}
