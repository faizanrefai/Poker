//
//  ProductViewController.h
//  InAppDemo
//
//  Created by Ashish on 20/04/11.
//  Copyright 2011 GlobalLogic Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "MKStoreManager.h"

@interface ProductViewController : UIViewController<MKStoreKitDelegate> {

	@private
	UITableView *_tableView;
	NSMutableArray *_products;
	UIActivityIndicatorView *_activity;
}
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *products;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activity;
- (void)downloadProduct;
@end
