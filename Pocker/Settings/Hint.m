//
//  Setings.m
//  VideoApp
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "Hint.h"
#import "HintDetail.h"
#import "JSONParser.h"

#import "registerview.h"


//#define kFeatureA1Id @"com.demo.poker"

@implementation Hint

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}


- (void)dealloc
{
    [hintCell release];
    [moreInfoLabel release];
    [myTable release];
    [indicator release];
    [dailyHintTxt release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewWillAppear:(BOOL)animated
{
    [indicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;

    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/GetHints.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    NSLog(@"%@",parser);
    
}

-(void)newsParse:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
    
    [hintMoreInfiArry removeAllObjects];
    [hintMoreInfiArry addObjectsFromArray:[[[dic valueForKey:@"ArrayOfHints"] objectAtIndex:0] valueForKey:@"ArrayOfMore"]];
    dailyHintTxt.text = [[[dic valueForKey:@"ArrayOfHints"] objectAtIndex:0] valueForKey:@"HintText"];
    [myTable reloadData];
    [indicator stopAnimating];
    

}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Customize the number of sections in the table view.



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

    
    
    NSString *email = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
    
    if (email) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;
        
        [indicator startAnimating];
        
        NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/CheckUserArticle.php?email=%@&article=%@",email, [[hintMoreInfiArry objectAtIndex:indexPath.row] valueForKey:@"ArticleId"]];
        
        articleID = [[[hintMoreInfiArry objectAtIndex:indexPath.row] valueForKey:@"ArticleId"] intValue];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(articleChk:) andHandler:self]; 
        NSLog(@"%@",parser);

        
    }else {
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:nil message:@"Não há usuário registrado para efetuar a compra" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
      
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    registerview *uf = [[registerview alloc]init];
    [self.navigationController pushViewController:uf animated:YES];
    [uf release];
 
    
}



-(void)articleChk:(NSDictionary*)dic
{

    NSLog(@"%@",dic);
    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;

    
    if ([[[[dic valueForKey:@"ArrayOfUserArticle"] objectAtIndex:0] valueForKey:@"Purchased"]isEqualToString:@"N"]) {
        
        [[MKStoreManager sharedManager] buyFeature:kFeatureA1Id];

    }
    else {
        HintDetail *de = [[HintDetail alloc]init];
        [self.navigationController pushViewController:de animated:YES];
        [de release];
    }

    
}


- (void)productPurchased:(NSString *)productId
{
    
    NSString *email = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/NewArticlePurchase.php?email=%@&article=%d",email, articleID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(articlePurchse:) andHandler:self]; 
    NSLog(@"%@",parser);
    
    [indicator stopAnimating];

    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;

//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Article Successfully subscribed !" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];      
//    
    
    
}

-(void)articlePurchse:(NSDictionary*)pi
{

    [indicator stopAnimating];

    
//    
//    if ([pi valueForKey:@"ReturnMessage"]) {
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:[pi valueForKey:@"ReturnMessage"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];      
//
//        
//    }
//    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hintMoreInfiArry count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        [[NSBundle mainBundle] loadNibNamed:@"HintCell" owner:self options:nil];
        cell=hintCell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    }
    
    if ([hintMoreInfiArry count]) {
        
        moreInfoLabel.text = [[hintMoreInfiArry objectAtIndex:indexPath.row] valueForKey:@"MoreTitle"];
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
    
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  self.title= @"";
    self.navigationItem.title =@"DICA DO DIA";
    
    
	[MKStoreManager setDelegate:self];
	[MKStoreManager sharedManager];

    
    hintMoreInfiArry = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}



- (void)viewDidUnload
{
    hintMoreInfiArry=nil;
    [hintMoreInfiArry release];
    [hintCell release];
    hintCell = nil;
    [moreInfoLabel release];
    moreInfoLabel = nil;
    [myTable release];
    myTable = nil;
    [indicator release];
    indicator = nil;
    [dailyHintTxt release];
    dailyHintTxt = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)moreInfoPressed:(id)sender {
    

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Não há usuário registrado para efetuar a compra" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
  
}



@end
