//
//  Setings.h
//  VideoApp
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "MKStoreManager.h"
#import "PockerAppDelegate.h"

@interface Hint : UIViewController <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,MKStoreKitDelegate> {
    
    IBOutlet UITextView *dailyHintTxt;
    IBOutlet UITableViewCell *hintCell;
    IBOutlet UILabel *moreInfoLabel;
    IBOutlet UITableView *myTable;
    IBOutlet UIActivityIndicatorView *indicator;
    NSMutableArray *hintMoreInfiArry;

    int articleID;
    

}


- (void)productPurchased:(NSString *)productId;
- (void)transactionCanceled;

- (IBAction)moreInfoPressed:(id)sender;




@end
