//
//  SwipeMenu.m
//  Trumpd
//
//  Created by Brandon Askea on 1/29/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "SwipeMenu.h"
#import "SwipeMenuCell.h"
#import "SwipeMenuHeaderView.h"
#import "UIColor+GameColors.h"
#import "Constants.h"

@interface SwipeMenu () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate> {
    
    UISwipeGestureRecognizer *leftSwipe;
    NSArray *menuOptions;
    UITableView *tableView;
    SwipeMenuHeaderView *headerView;
}

@end

@implementation SwipeMenu

#pragma mark - SET UP

-(void)configureMenuWithFrame:(CGRect)frame {
    
    // BLUR BACKGROUND
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    blurView.alpha = 0.25;
    
    //SHADOW
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.75;
    self.layer.shadowRadius = 8;
    
    // MENU OPTIONS
    menuOptions = [NSArray arrayWithObjects:@"Share With Friends", @"Turn Off Music", @"Quit, Return to Main Menu", nil];
    
    // TABLE VIEW
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = kSwipeMenuCellLabelHeight + (kSwipeMenuCellLabelTopBottomPadding * 2);
    tableView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor trumpGold];
    tableView.separatorInset = UIEdgeInsetsMake(0, 30, 30, 30);
    [tableView registerClass:[SwipeMenuCell class] forCellReuseIdentifier:@"Cell"];
    headerView = [[SwipeMenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSwipeMenuWidth, kSwipeMenuHeaderHeight + kSwipeMenuHeaderBottomPadding)];
    [headerView configureHeaderWithFrame:headerView.frame];
    tableView.tableHeaderView = headerView;
    
    // DISMISS SWIPE
    leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    leftSwipe.delegate = self;
    [tableView addGestureRecognizer:leftSwipe];
    [self addGestureRecognizer:leftSwipe];
    
    [self addSubview:blurView];
    [self addSubview:tableView];
}

// TABLE VIEW

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return menuOptions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SwipeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell configureCellWithText:[menuOptions objectAtIndex:indexPath.row]];
    return cell;
    
}

#pragma mark - ACTIONS

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void) leftSwipe {
    
    [self.delegate dismissMenu];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
