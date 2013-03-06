//
//  AllVideo.h
//  VideoApp
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"


@interface News : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *sourcelabel;
    IBOutlet EGOImageView *imageViw;
    IBOutlet UITableViewCell *newsCell;
    IBOutlet UITableView *myTable;
    IBOutlet UIActivityIndicatorView *indicator;
    
}

@property (nonatomic,retain)NSMutableArray *newsDetailArry;

@end
