//
//  BookDetailViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookListItem.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

{
    NSString *_iconName;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        _iconName = @"Folder";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.bookToEdit != nil)
        {
            self.title = @"Edit Book";
            self.BookTitle.text = self.bookToEdit.BookTitle;
            self.doneBarButton.enabled = YES;
            _iconName = self.bookToEdit.iconName;
        }
    self.iconImageView.image = [UIImage imageNamed:_iconName];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.BookTitle becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel
{
    
    [self.delegate bookDetailViewControllerDidCancel:self];
    
}

- (IBAction)done {
    
    //NSLog(@"Calling Done");
    
    if (self.bookToEdit.BookTitle)
        {
            self.bookToEdit.BookTitle = self.BookTitle.text;
            self.bookToEdit.iconName = _iconName;
            [self.delegate bookDetailViewController:self didFinishEditingBook:self.bookToEdit];
        }
    else
        {
            BookListItem *newbook = [[BookListItem alloc] init];
            newbook.BookTitle = self.BookTitle.text;
            newbook.iconName = _iconName;
            [self.delegate bookDetailViewController:self didFinishAddingBook:newbook];
        }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==1)
    {
        return indexPath;
    }
    else
    {
        return nil;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickIcon"])
    {
        IconPickerTableViewController *controller = segue.destinationViewController;
         NSLog(@"Assigning delegate");
        controller.delegate = self;
    }
}

- (void)iconPicker:(IconPickerTableViewController *)iconPicker didPickIcon:(NSString*)iconName
{
    NSLog(@"Function called");
    NSLog(iconName);
    _iconName = iconName;
     NSLog(@"Memory address %@",[UIImage imageNamed:_iconName]);
    [self.iconImageView setImage:[UIImage imageNamed:_iconName]];
    NSLog(@"Memory address %@",self.iconImageView.image);
    
    [self.navigationController popViewControllerAnimated:YES];

}



@end
