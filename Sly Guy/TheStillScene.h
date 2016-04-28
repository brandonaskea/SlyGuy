//
//  TheStillScene.h
//  Trumpd
//
//  Created by Brandon Askea on 4/17/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "StillScene.h"

@interface TheStillScene : StillScene

+ (instancetype)unarchiveFromFile:(NSString *)file;

@end
