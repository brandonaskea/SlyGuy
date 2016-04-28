//
//  SwipeMenuCell.m
//  Trumpd
//
//  Created by Brandon Askea on 1/29/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "SwipeMenuCell.h"
#import "Constants.h"

@interface SwipeMenuCell () {
    
    UILabel *menuLabel;
}

@end

@implementation SwipeMenuCell

-(void)configureCellWithText:(NSString*)text {
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSwipeMenuCellLabelSidePadding, kSwipeMenuCellLabelTopBottomPadding, kSwipeMenuWidth - (kSwipeMenuCellLabelSidePadding * 2), kSwipeMenuCellLabelHeight)];
    menuLabel.text = text;
    menuLabel.textAlignment = NSTextAlignmentCenter;
    menuLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    [self.contentView addSubview:menuLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
