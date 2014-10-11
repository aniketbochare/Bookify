//
//  BooksTableViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "BooksTableViewController.h"
#import "BookListItem.h"
#import "PagesTableViewController.h"
#import "PageListItem.h"


@interface BooksTableViewController ()

@end


@implementation BooksTableViewController

{
    NSMutableArray *_books;
}

 -(id)initWithCoder:(NSCoder *)aDecoder
 {
 if ((self = [super initWithCoder:aDecoder]))
 {
 [self loadBookListItems];
 }
 return self;
 }


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Inside View did load");
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_books count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Inside cellforrowatindexpath");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"Assigning values to cell");
    
    BookListItem *book = _books[indexPath.row];
    cell.textLabel.text = book.BookTitle;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookListItem *book = _books[indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowPages" sender:book];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_books removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
   // [self savePageListItems];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];}

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
    
    if ([segue.identifier isEqualToString:@"ShowPages"]) {
       PagesTableViewController *controller = segue.destinationViewController;
        controller.selectedBook = sender;
    }
    else if ([segue.identifier isEqualToString:@"EditBook"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        BookDetailViewController *controller = (BookDetailViewController*)navigationController.topViewController;
        controller.delegate = self;
        controller.bookToEdit = nil;
    }
    
}

#pragma BookDetailViewControllerDelegate Methods


- (void)bookDetailViewControllerDidCancel: (BookDetailViewController *)controller
{
    NSLog(@"Calledhere");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)bookDetailViewController: (PageDetailViewController *)controller didFinishAddingBook:(BookListItem*)book{
    
    //Get last row Index for addition
    NSInteger lastRowIndex = [_books count];
    
    //Add Page to the _pages instance variable.
    [_books addObject:book];
    
    //Get Index path for the index last row.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    //Add the indexpaths to the array as we can add multiple rows.
    NSArray *indexPaths = @[indexPath];
    
    //This funtion is important as it calls the delegate functions to create row view at NSIndexpath and redraws the cell. Use this always for adding row to a table view.
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
  //  [self saveBookListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)bookDetailViewController: (BookDetailViewController *)controller didFinishEditingBook:(BookListItem *)book:(BookListItem*)book{
    
    NSInteger editBookIndex = [_books indexOfObject:book];
    NSIndexPath *editIndexPath = [NSIndexPath indexPathForRow:editBookIndex inSection:0];
    
    //Get that cell with this indexpath
    
    UITableViewCell *editCell = [self.tableView cellForRowAtIndexPath:editIndexPath];
    
  //  [self configureTextForCell:editCell withPage:book];
    
 //   [self saveBookListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //Creating segue manually instead of using storyboard.
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditBookNavigationController"];
    
    BookDetailViewController *bookDetailViewController = (BookDetailViewController*) navigationController.topViewController;
    bookDetailViewController.delegate =self;
    BookListItem *book = _books[indexPath.row];
    bookDetailViewController.bookToEdit = book;
    
    //Presenting navigation controller programatically
    NSLog(@"Calling present");
    [self presentViewController:navigationController animated:YES completion:nil];
    
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
 return [[self pathToDocumentDirectory] stringByAppendingPathComponent:@"BookList.plist"];
 }
 
 - (void)saveBookListItems
 {
 NSMutableData *data = [[NSMutableData alloc] init];
 NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
 [archiver encodeObject:_books forKey:@"BookListItem"];
 [archiver finishEncoding];
 [data writeToFile:[self pathTotheFile] atomically:YES];
 }
 
 - (void)loadBookListItems {
 NSString *path = [self pathTotheFile];
 if ([[NSFileManager defaultManager] fileExistsAtPath:path])
 {
 NSData *data = [[NSData alloc] initWithContentsOfFile:path];
 NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
 _books = [unarchiver decodeObjectForKey:@"BookListItem"];
 [unarchiver finishDecoding];
 }
 else
 {
 _books = [[NSMutableArray alloc] initWithCapacity:20];
 }
 }




@end
