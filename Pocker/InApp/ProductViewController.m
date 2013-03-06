//
//  ProductViewController.m
//  InAppDemo
//
//  Created by Ashish on 20/04/11.
//  Copyright 2011 GlobalLogic Inc. All rights reserved.
//

#import "ProductViewController.h"


@implementation ProductViewController
@synthesize tableView = _tableView;
@synthesize products = _products;
@synthesize activity  = _activity;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Purchase Team";
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
									 initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
									 target:self
									 action:@selector(onCancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];

	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
									 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
									 target:self
									 action:@selector(onDone:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
    
	
	[MKStoreManager setDelegate:self];
	[MKStoreManager sharedManager];
	
}
- (void)onCancel:(id)inSender
{
	[self dismissModalViewControllerAnimated:YES];
}
- (void)onDone:(id)inSender
{
	[self dismissModalViewControllerAnimated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_products release];
	[_tableView release];
	[_activity release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section  
{  
	return [_products count];  
}   

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
	static NSString *identifier = @"Cell";  
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];  
	if (cell == nil)
	{  
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
	}   
	
	NSUInteger row = [indexPath row];  
	SKProduct *thisProduct = [_products objectAtIndex:row];  
	cell.textLabel.text = thisProduct.localizedTitle;
	cell.detailTextLabel.text =    [NSString stringWithFormat:@"$%0.02f",[thisProduct.price doubleValue]];   
	
	return cell;  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_activity.hidden = NO;

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	SKProduct *product = [_products objectAtIndex:indexPath.row];
	NSLog(@"%@",product.productIdentifier);
	[[MKStoreManager sharedManager] buyFeature:product.productIdentifier];
}
#pragma mark -
#pragma mark MKStoreKitDelegate
- (void)productFetchComplete
{
	_activity.hidden = YES;
	self.products = [MKStoreManager sharedManager].purchasableObjects;
	[_tableView reloadData];
}
- (void)productPurchased:(NSString *)productId
{
    
    
	_activity.hidden = YES;
	UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setMessage:@"You have purchased product successfully"];
	[alert addButtonWithTitle:@"OK"];
	//[alert show];
	[alert release];
	[self downloadProduct];
    
    
}
- (void)downloadProduct
{
    
    
//#TODO: This URL is not correct and also we have perform here Asynchronous file downloading
    
    
	NSURL *url = [NSURL URLWithString:@"http://www.iphonedevnation.com/tutorials/ForestGreen.mp3"];
	NSData *data = [NSData dataWithContentsOfURL:url];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *file = [NSString stringWithFormat:@"%@/Song.mp3", documentsDirectory];
	[data writeToFile:file atomically:YES];	
    
    
    
}




@end
