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
#import "DataModel.h"


@interface BooksTableViewController ()

@end


@implementation BooksTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Inside View did load");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //Making self delegate so that this controller gets messages for state of navigation controller.
    self.navigationController.delegate = self;
    
    //Getting default values saved if app was terminated ever.
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"BookListItemIndex"];
    
    //If it was terminated it will have index of table and hence we check for non -1 value here.
    
    if (index>=0 && index< self.dataModel.books.count) {
        BookListItem *book = self.dataModel.books[index];
        [self performSegueWithIdentifier:@"ShowPages" sender:book];
    }
    

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
    NSLog(@"Inside numberOfRowsInSection ");
    NSLog(@"Count of section = %ld and row =%lu", (long)section,(unsigned long)self.dataModel.books.count);
    return [self.dataModel.books count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Inside cellforrowatindexpath");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"Assigning values to cell");
    
    BookListItem *book = self.dataModel.books[indexPath.row];
    cell.textLabel.text = book.BookTitle;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Adding to remember screen when apps gets terminated and user is back to same place when it is launched.
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"BookListItemIndex"];
    BookListItem *book = self.dataModel.books[indexPath.row];
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
    
    [self.dataModel.books removeObjectAtIndex:indexPath.row];
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
    else if ([segue.identifier isEqualToString:@"AddBook"])
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
    NSInteger lastRowIndex = [self.dataModel.books count];
    
    //Add Page to the book instance variable.
    [self.dataModel.books addObject:book];
    
    //Get Index path for the index last row.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:0];
    //Add the indexpaths to the array as we can add multiple rows.
    NSArray *indexPaths = @[indexPath];
    
    //This funtion is important as it calls the delegate functions to create row view at NSIndexpath and redraws the cell. Use this always for adding row to a table view.
    NSLog(@"Count of row  before =%lu", (unsigned long)self.dataModel.books.count);
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
   NSLog(@"Count of row  after =%lu", (unsigned long)self.dataModel.books.count);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)bookDetailViewController: (BookDetailViewController *)controller didFinishEditingBook:(BookListItem *)book{
    
    NSInteger editBookIndex = [self.dataModel.books indexOfObject:book];
    NSIndexPath *editIndexPath = [NSIndexPath indexPathForRow:editBookIndex inSection:0];
    
    //Get that cell with this indexpath
    
    UITableViewCell *editCell = [self.tableView cellForRowAtIndexPath:editIndexPath];
    
    editCell.textLabel.text =book.BookTitle;
    
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
    BookListItem *book = self.dataModel.books[indexPath.row];
    bookDetailViewController.bookToEdit = book;
    
    //Presenting navigation controller programatically
    NSLog(@"Calling present");
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

//Implementing the navigation controller delegate to handle back events and save an index which is not in range for array (0 to n-1)
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"BookListItemIndex"];
    }
}



@end
