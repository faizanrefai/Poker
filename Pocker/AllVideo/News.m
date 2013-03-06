//
//  AllVideo.m
//  VideoApp
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "News.h"
#import "JSONParser.h"

@implementation News
@synthesize newsDetailArry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [myTable release];
    [newsCell release];
    [imageViw release];
    [dateLabel release];
    [sourcelabel release];
    [descriptionLabel release];
    [indicator release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 //   self.title= @"";
    self.navigationItem.title =@"NOTÍCIAS";

    newsDetailArry  =[[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [indicator startAnimating];
    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/GetNews.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    NSLog(@"%@",parser);
    
}

-(void)newsParse:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
    [indicator stopAnimating];
    
    [newsDetailArry removeAllObjects];
    [newsDetailArry addObjectsFromArray:[dic valueForKey:@"ArrayOfNews"]];
    [myTable reloadData];
    
}

- (void)viewDidUnload
{
    newsDetailArry=nil ;
    [newsDetailArry release];
    [myTable release];
    myTable = nil;
    [newsCell release];
    newsCell = nil;
    [imageViw release];
    imageViw = nil;
    [dateLabel release];
    dateLabel = nil;
    [sourcelabel release];
    sourcelabel = nil;
    [descriptionLabel release];
    descriptionLabel = nil;
    [indicator release];
    indicator = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsDetailArry count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
        cell = newsCell;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    if ([newsDetailArry count]) {
       
        NSString *str = [[[newsDetailArry objectAtIndex:indexPath.row] valueForKey:@"NewsImage"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        imageViw.imageURL = [NSURL URLWithString:str] ;
        
        dateLabel.text = [[newsDetailArry objectAtIndex:indexPath.row] valueForKey:@"NewsDate"];
     //   sourcelabel.text=[[newsDetailArry objectAtIndex:indexPath.row] valueForKey:@"NewsSource"];
        descriptionLabel.text = [[newsDetailArry objectAtIndex:indexPath.row] valueForKey:@"NewsTitle"];        
    }
    // Configure the cell.

    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert)
 {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   NSString*stri =  [[newsDetailArry objectAtIndex:indexPath.row] valueForKey:@"NewsLink"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:stri]];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
