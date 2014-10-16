//
//  IconPickerTableViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/15/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerTableViewController;

@protocol IconPickerControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerTableViewController *)iconPicker didPickIcon:(NSString*) iconName;


@end

@interface IconPickerTableViewController : UITableViewController

@property (nonatomic,weak) id <IconPickerControllerDelegate> delegate;

@end
