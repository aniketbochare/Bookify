//
//  BookListTableViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/4/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "BookListTableViewController.h"
#import "BookListItem.h"
#import "DetailBookViewController.h"

@interface BookListTableViewController ()

@end

@implementation BookListTableViewController

{
    NSMutableArray *_books;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _books = [[NSMutableArray alloc] initWithCapacity:20];
    
    
    BookListItem *book;
    
    book = [[BookListItem alloc] init];
    book.bookTitle = @"History";
    book.checked = NO;
    [_books addObject:book];
    
    book = [[BookListItem alloc] init];
    book.bookTitle = @"Geography";
    book.checked = YES;
    [_books addObject:book];
    
    book = [[BookListItem alloc] init];
    book.bookTitle = @"Software Engineering";
    book.checked = YES;
    [_books addObject:book];
    
    book = [[BookListItem alloc] init];
    book.bookTitle = @"Social Science";
    book.checked = NO;
    [_books addObject:book];
    
    book = [[BookListItem alloc] init];
    book.bookTitle = @"Music";
    book.checked = YES;
    [_books addObject:book];
    
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
    return [_books count];
}


- (void)configureCheckmarkForCell:(UITableViewCell *)cell withBook:(BookListItem *)book
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    
    if (book.checked) {
        label.text = @"√";
    } else {
        label.text = @"";
    }
}


- (void)configureTextForCell:(UITableViewCell *)cell withBook:(BookListItem *)book
{
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = book.bookTitle;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookListCell" forIndexPath:indexPath];
    BookListItem *book = _books[indexPath.row];
    [self configureCheckmarkForCell:cell withBook:book];
    [self configureTextForCell:cell withBook:book];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BookListItem *book = _books[indexPath.row];
    book.checked = !book.checked;
    [self configureCheckmarkForCell:cell withBook:book];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
 This function helps to add the object to instance variable array. Can be used for testing and was tied to add button before got overriden by the segue.
 
- (IBAction)addBook
{
    NSInteger lastRowIndex = [_books count];
    BookListItem* books = [[BookListItem alloc]init];
    books.bookTitle = @"New Book";
    books.checked = NO;
    [_books addObject:books];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_books removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
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
    
    if ([segue.identifier isEqualToString:@"AddBook"]) {
        
        NSLog(@"Inside If");
        // 1 the destination view controller here does not connect to viewcontroller but to the navigation controller.
        UINavigationController *navigationController = segue.destinationViewController;
        
        // 2 Get the reference of the view controller from top view controller of the navigation controller and then cast it to match the addbookview controller.
        DetailBookViewController *controller = (DetailBookViewController *) navigationController.topViewController;
        
        //3 Assign self as the delegate to get messages from AddViewController if anything happens.
        controller.delegate = self;
        
        
    }
    else if ([segue.identifier isEqualToString:@"EditBook"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        DetailBookViewController *controller = (DetailBookViewController *) navigationController.topViewController;
        controller.delegate = self;
        NSLog(@"Assigned Delegate");
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.bookToEdit = _books[indexPath.row];
    }
    
}


#pragma AddBookViewControllerDelegate Methods


- (void)addBookViewControllerDidCancel: (DetailBookViewController *)controller
{
    NSLog(@"Calledhere");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addBookViewController: (DetailBookViewController *)controller didFinishAddingBook:(BookListItem*)book{
    
    //Get last row Index for addition
    NSInteger lastRowIndex = [_books count];
    
    //Add Book to the _books instance variable.
    [_books addObject:book];
    
    //Get Index path for the index last row.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    //Add the indexpaths to the array as we can add multiple rows.
    NSArray *indexPaths = @[indexPath];
    
    //This funtion is important as it calls the delegate functions to create row view at NSIndexpath and redraws the cell. Use this always for adding row to a table view.
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)addBookViewController: (DetailBookViewController *)controller didFinishEditingBook:(BookListItem*)book{
    
    NSInteger editBookIndex = [_books indexOfObject:book];
    NSIndexPath *editIndexPath = [NSIndexPath indexPathForRow:editBookIndex inSection:0];
    
    //Get that cell with this indexpath
    
    UITableViewCell *editCell = [self.tableView cellForRowAtIndexPath:editIndexPath];
    
    [self configureTextForCell:editCell withBook:book];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}




@end
