//
//  PBDrawController.m
//  PictureBook
//
//  Created by mai on 2018/5/27.
//  Copyright © 2018年 Mai. All rights reserved.
//

#import "PBDrawController.h"
#import "PBDrawView.h"
#import <AFNetworking/AFNetworking.h>
#import "PBManager.h"

@interface PBDrawController ()

@property(nonatomic, strong)PBDrawView *drawView;



@end

@implementation PBDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawView = [[PBDrawView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.view addSubview:self.drawView];
    
    UIFont *font = [UIFont systemFontOfSize: 20.0];
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    button.frame = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    [self.drawView addSubview:button];
    
}

- (void)upload{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *array = self.drawView.lineArray;
    dic[@"drawing"] = array;
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer requestWithMethod:@"POST" URLString:@"http://hackhnu.jxpxxzj.cn:5000/get_draw_predict" parameters:dic error:nil];
    [manager POST:@"http://hackhnu.jxpxxzj.cn:5000/get_draw_predict" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess===%@",responseObject);
        NSArray<NSString*> *arr = (NSArray*)responseObject;
        BOOL judge = false;
        for (int i = 0; i < 3; i++) {
            if([arr[i] containsString:@"cake"] || [arr[i] containsString:@"candle"]||[arr[i] containsString:@"matches"]){
                judge = YES;
                break;
            }
        }
        
        [self.drawView.lineArray removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.drawView setNeedsDisplay];
            if (judge) {
                ViewController *mainController = (ViewController*)self.tabBarController.presentingViewController;
                if([PBManager defaultManager].drawCount == 0){
                    [mainController setImageWithNum:5];
                    [PBManager defaultManager].drawCount++;
                }else if([PBManager defaultManager].drawCount == 1){
                    [mainController setImageWithNum:6];
                    [PBManager defaultManager].drawCount++;
                }else if([PBManager defaultManager].drawCount == 2){
                    [mainController setImageWithNum:9];
                    [PBManager defaultManager].drawCount++;
                }
            }
        });
        NSLog(@"draw-%ld",[PBManager defaultManager].drawCount);
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"sucess===%@",error);
    }];
    
    

    
    
    
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
