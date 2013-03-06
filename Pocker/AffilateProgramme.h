//
//  AffilateProgramme.h
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"


@interface AffilateProgramme : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
    IBOutlet UIActivityIndicatorView *indicator;
    NSMutableArray *affilProgArry;
    
    IBOutlet UITableViewCell *afficell;
    IBOutlet EGOImageView *web;
    
}


@property (nonatomic,retain)NSMutableArray *newsDetailArry;


@property (nonatomic, retain) IBOutlet UITableView *mytable;








@end
