//
//  SwipeMenuHeaderView.m
//  Trumpd
//
//  Created by Brandon Askea on 1/29/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "SwipeMenuHeaderView.h"
#import "UIColor+GameColors.h"
#import "Constants.h"
#import "GameUtility.h"

@interface SwipeMenuHeaderView () {
    
    UILabel * usernameLabel;
    UIImageView * userPicture;
    UILabel * detailLabel;
}

@end
@implementation SwipeMenuHeaderView

-(void)configureHeaderWithFrame:(CGRect)frame {
    
    self.backgroundColor = [UIColor clearColor];
    
    // BLUR
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.alpha = 0.5;
    blurView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - kSwipeMenuHeaderBottomPadding);
    [self addSubview:blurView];
    
    // USER IMAGE
    userPicture = [[UIImageView alloc] initWithFrame:CGRectMake(kSwipeMenuHeaderImagePadding, kSwipeMenuHeaderImagePadding, kSwipeMenuHeaderImageHW, kSwipeMenuHeaderImageHW)];
    userPicture.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:userPicture];
    
    // USERNAME LABEL
    usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSwipeMenuHeaderImagePadding + kSwipeMenuHeaderImageHW + kSwipeMenuHeaderUsernameLabelPadding, kSwipeMenuHeaderUsernameLabelPadding, self.bounds.size.width - (kSwipeMenuHeaderImagePadding + kSwipeMenuHeaderImageHW + (kSwipeMenuHeaderUsernameLabelPadding * 2)), kSwipeMenuHeaderUsernameLabelHeight)];
    usernameLabel.text = @"Donald J Trump is #1 or Sure Yall";
    usernameLabel.font = [UIFont fontWithName:kMenuFont size:19];
    usernameLabel.adjustsFontSizeToFitWidth = YES;
    usernameLabel.minimumScaleFactor = 0.5;
    usernameLabel.numberOfLines = 1;
    usernameLabel.textColor = [UIColor trumpGold];
    [self addSubview:usernameLabel];
    
    detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSwipeMenuHeaderTrumpQuotePadding,kSwipeMenuHeaderImageHW, self.bounds.size.width - (kSwipeMenuHeaderTrumpQuotePadding * 2), self.bounds.size.height /2)];
    detailLabel.text = [GameUtility getRandomQuoteFromDonaldTrump];
    detailLabel.font = [UIFont fontWithName:kMenuDetailFont size:6];
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.numberOfLines = 0;
    detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailLabel.minimumScaleFactor = 0;
    detailLabel.contentMode = UIViewContentModeTopLeft;
    
    [self addSubview:detailLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
