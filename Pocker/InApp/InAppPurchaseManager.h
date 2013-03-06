//
//  InAppPurchaseManager.h
//  GamePlanner
//
//  Created by Aditya on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"


@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate>{
	SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}
- (void)requestProUpgradeProductData;
@end
