//
//  ElementManager.h
//  Sly Guy
//
//  Created by Brandon Askea on 5/15/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnvironmentManager.h"

@interface ElementManager : NSObject <EnvironmentManagerDelegate>

-(id)initWithLevel:(Level)level;

@end
