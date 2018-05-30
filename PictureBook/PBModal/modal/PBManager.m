//
//  PBManager.m
//  PictureBook
//
//  Created by mai on 2018/5/27.
//  Copyright © 2018年 Mai. All rights reserved.
//

#import "PBManager.h"

@implementation PBManager

+ (instancetype)defaultManager{
    static PBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PBManager alloc] initPrivate];
    });
    return manager;
}
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        self.voiceCount = 0;
        self.drawCount = 0;
    }
    return self;
}






@end
