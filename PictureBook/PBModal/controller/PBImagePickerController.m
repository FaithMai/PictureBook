//
//  PBImagePickerController.m
//  PictureBook
//
//  Created by mai on 2018/5/26.
//  Copyright © 2018年 Mai. All rights reserved.
//

#import "PBImagePickerController.h"
#import <AFNetworking/AFNetworking.h>

@interface PBImagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PBImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拍照";
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // 设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(270, 270));
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, 270, 270)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://hackhnu.jxpxxzj.cn:5000/get_img_predict" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(scaledImage, 1);
        [formData appendPartWithFileData:data name:@"image" fileName:@"name.jpeg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"image-%@",responseObject);
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSString *str = dic[@"result"];
        BOOL judge = NO;
        if ([str containsString:@"cup"]) {
            judge = YES;
        }
        
        if (judge) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"找到杯子!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [alertController addAction:action];
//            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=====%@",error);
    }];
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
