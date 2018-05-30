//
//  PBManager.h
//  PictureBook
//
//  Created by mai on 2018/5/27.
//  Copyright © 2018年 Mai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBManager : NSObject

+ (instancetype)defaultManager;

@property(nonatomic, assign)NSInteger voiceCount;
@property(nonatomic, assign)NSInteger drawCount;

@end
