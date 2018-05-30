//
//  PBTabBarController.m
//  PictureBook
//
//  Created by mai on 2018/5/26.
//  Copyright © 2018年 Mai. All rights reserved.
//

#import "PBTabBarController.h"
#import "PBImagePickerController.h"
#import "VoiceRecordController.h"
#import "PBDrawController.h"

@interface PBTabBarController ()

@end

@implementation PBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    PBImagePickerController *imageController = [[PBImagePickerController alloc] init];
    
    imageController.tabBarItem.title = @"照相";
//    PBContainController *containController = [[PBContainController alloc] init];
    VoiceRecordController *voiceRecordController = [[VoiceRecordController alloc] init];
    
    voiceRecordController.tabBarItem.title = @"录音";
    
    PBDrawController *drawController = [[PBDrawController alloc] init];
    
    drawController.tabBarItem.title = @"绘图";
    
    
    self.viewControllers = @[drawController,voiceRecordController,imageController];
//    self.viewControllers = @[containController];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
