//
//  ViewController.m
//  PictureBook
//
//  Created by mai on 2018/5/26.
//  Copyright © 2018年 Mai. All rights reserved.
//

#import "ViewController.h"
#import "PBTabBarController.h"
#import <WebKit/WebKit.h>
#import "VoiceRecordController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic, strong)PBTabBarController *tabController;
//@property (weak, nonatomic) IBOutlet WKWebView *PBwebView;
@property(nonatomic, assign)NSInteger jumpCount;


@end

@implementation ViewController
- (void)controlButtonPress:(id)sender {
    self.tabController = [[PBTabBarController alloc] init];
    self.tabController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:self.tabController animated:YES completion:nil];
//    VoiceRecordController *controller = [[VoiceRecordController alloc] init];
//    controller.modalPresentationStyle = UIModalPresentationPageSheet;
//    [self presentViewController:controller animated:YES completion:nil];
    
//    NSLog(@"bouns=%f,%f",UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    
    [self.view addGestureRecognizer:tap];
    self.jumpCount = 0;
    
//    WKWebView *PBwebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    PBwebView.scrollView.bounces = false;
////    UIWebView *PBwebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
////    PBwebView.scrollView.bounrcesZoom = NO;
//    NSURL *url = [NSURL URLWithString:@"https://swcontest.jxpxxzj.cn/static/index.html#/reader/scene4"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [PBwebView loadRequest:request];
//    [self.view addSubview:PBwebView];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"radiopress"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(controlButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    CGSize size = button.bounds.size;
    button.frame = CGRectMake(1200, 850, size.width, size.height);
    [self.view addSubview:button];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button2 setBackgroundColor:[UIColor blueColor]];
//    [button2 setTitle:@"jump" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(10, 850, 200, 200);
    [self.view addSubview:button2];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)jump{
    if (self.jumpCount == 0) {
        [self setImageWithNum:4];
    }else if(self.jumpCount == 1){
        [self setImageWithNum:8];
        
    }else if(self.jumpCount == 2){
        [self setImageWithNum:10];
    }
    self.jumpCount++;
    
}

- (void)setImageWithNum:(NSInteger)num{
    NSString *name = [NSString stringWithFormat:@"localhost_%ld",num];
    [self.imageView setImage:[UIImage imageNamed:name]];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
