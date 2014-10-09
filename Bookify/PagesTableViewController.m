//
//  PagesTableViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/4/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "PagesTableViewController.h"
#import "PageListItem.h"
#import "PageDetailViewController.h"
#import "BookListItem.h"

@interface PagesTableViewController ()

@end

@implementation PagesTableViewController

{
    NSMutableArray *_pages;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self loadPageListItems];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = self.selectedBook.BookTitle;
  
    /*Used for testing NSMutableArray *_pages object creation*/
    
   /* NSLog(@"Documents folder is %@", [self pathToDocumentDirectory]);
    NSLog(@"Data file path is %@", [self pathTotheFile]);
    
    _pages = [[NSMutableArray alloc] initWithCapacity:20];
    
    
    PageListItem *page;
    
    page = [[PageListItem alloc] init];
    page.PageTitle = @"History";
    page.checked = NO;
    [_pages addObject:page];
    
    page = [[PageListItem alloc] init];
    page.PageTitle = @"Geography";
    page.checked = YES;
    [_pages addObject:page];
    
    page = [[PageListItem alloc] init];
    page.PageTitle = @"Software Engineering";
    page.checked = YES;
    [_pages addObject:page];
    
    page = [[PageListItem alloc] init];
    page.PageTitle = @"Social Science";
    page.checked = NO;
    [_pages addObject:page];
    
    page = [[PageListItem alloc] init];
    page.PageTitle = @"Music";
    page.checked = YES;
    [_pages addObject:page];
    */
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_pages count];
}


- (void)configureCheckmarkForCell:(UITableViewCell *)cell withPage:(PageListItem *)page
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    
    if (page.checked) {
        label.text = @"√";
    } else {
        label.text = @"";
    }
}


- (void)configureTextForCell:(UITableViewCell *)cell withPage:(PageListItem *)page
{
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = page.PageTitle;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PageListCell" forIndexPath:indexPath];
    PageListItem *page = _pages[indexPath.row];
    [self configureCheckmarkForCell:cell withPage:page];
    [self configureTextForCell:cell withPage:page];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PageListItem *page = _pages[indexPath.row];
    page.checked = !page.checked;
    [self configureCheckmarkForCell:cell withPage:page];
    [self savePageListItems];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
 This function helps to add the object to instance variable array. Can be used for testing and was tied to add button before got overriden by the segue.
 
- (IBAction)addBook
{
    NSInteger lastRowIndex = [_pages count];
    PageListItem* pages = [[PageListItem alloc]init];
    pages.PageTitle = @"New Page";
    pages.checked = NO;
    [_pages addObject:pages];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_pages removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [self savePageListItems];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //NSLog(segue.identifier);
    
    if ([segue.identifier isEqualToString:@"AddPage"]) {
        
        NSLog(@"Inside If");
        // 1 the destination view controller here does not connect to viewcontroller but to the navigation controller.
        UINavigationController *navigationController = segue.destinationViewController;
        
        // 2 Get the reference of the view controller from top view controller of the navigation controller and then cast it to match the addpageview controller.
        PageDetailViewController *controller = (PageDetailViewController *) navigationController.topViewController;
        
        //3 Assign self as the delegate to get messages from AddViewController if anything happens.
        controller.delegate = self;
        
        
    }
    else if ([segue.identifier isEqualToString:@"EditPage"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        PageDetailViewController *controller = (PageDetailViewController *) navigationController.topViewController;
        controller.delegate = self;
        NSLog(@"Assigned Delegate");
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.pageToEdit = _pages[indexPath.row];
    }
    
}


#pragma PageDetailViewControllerDelegate Methods


- (void)pageDetailViewControllerDidCancel: (PageDetailViewController *)controller
{
    NSLog(@"Calledhere");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pageDetailViewController: (PageDetailViewController *)controller didFinishAddingPage:(PageListItem*)page{
    
    //Get last row Index for addition
    NSInteger lastRowIndex = [_pages count];
    
    //Add Page to the _pages instance variable.
    [_pages addObject:page];
    
    //Get Index path for the index last row.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    //Add the indexpaths to the array as we can add multiple rows.
    NSArray *indexPaths = @[indexPath];
    
    //This funtion is important as it calls the delegate functions to create row view at NSIndexpath and redraws the cell. Use this always for adding row to a table view.
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self savePageListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)pageDetailViewController: (PageDetailViewController *)controller didFinishEditingPage:(PageListItem*)page{
    
    NSInteger editPageIndex = [_pages indexOfObject:page];
    NSIndexPath *editIndexPath = [NSIndexPath indexPathForRow:editPageIndex inSection:0];
    
    //Get that cell with this indexpath
    
    UITableViewCell *editCell = [self.tableView cellForRowAtIndexPath:editIndexPath];
    
    [self configureTextForCell:editCell withPage:page];
    
    [self savePageListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

/*Adding persistance to the data. Data stores in document directory and hence sandboxed*/

- (NSString *)pathToDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths firstObject];
    return documentsDirectoryPath;
}

- (NSString *)pathTotheFile
{
    return [[self pathToDocumentDirectory] stringByAppendingPathComponent:@"PageList.plist"];
}

- (void)savePageListItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_pages forKey:@"PageListItem"];
    [archiver finishEncoding];
    [data writeToFile:[self pathTotheFile] atomically:YES];
}

- (void)loadPageListItems {
    NSString *path = [self pathTotheFile];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _pages = [unarchiver decodeObjectForKey:@"PageListItem"];
        [unarchiver finishDecoding];
    }
    else
    {
        _pages = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

@end
