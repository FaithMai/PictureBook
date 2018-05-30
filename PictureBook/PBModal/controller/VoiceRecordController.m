//
//  VoiceRecordController.m
//  PictureBook
//
//  Created by mai on 2018/5/26.
//  Copyright © 2018年 Mai. All rights reserved.
//

#import "VoiceRecordController.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
#import "PBManager.h"


@interface VoiceRecordController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (nonatomic, strong)AVAudioSession *session;
@property (nonatomic, strong)AVAudioRecorder *recorder;
@property (nonatomic, strong)NSString *filePath;
@property (nonatomic, strong)AVAudioPlayer *player;
@property (nonatomic, strong)NSURL *recordFileUrl;


@end

@implementation VoiceRecordController
- (IBAction)stopPress:(id)sender {
    [self.recorder stop];
    self.infoLabel.text = @"停止录音";
    
}
- (IBAction)recordPress:(id)sender {
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (session == nil) {
        
        NSLog(@"Error creating session: %@",[sessionError description]);
        
    }else{
        [session setActive:YES error:nil];
        
    }
    
    self.session = session;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [path stringByAppendingString:@"/Record.wav"];
    //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:self.filePath];
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 44100],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
    if (_recorder) {
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
        
    }
    self.infoLabel.text = @"开始录音";
}
- (IBAction)uploadRecord:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://hackhnu.jxpxxzj.cn:5000/get_stt" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfURL:self.recordFileUrl];
        
        [formData appendPartWithFileData:data name:@"audio-blob" fileName:@"Record.wav" mimeType:@"application/octet-stream"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"voice--%@",responseObject);
        NSArray<NSString*> *array = (NSArray*)responseObject;
        BOOL judge = false;
        if ([array[0] containsString:@"3"] || [array[0] containsString:@"三"] || [array[0] containsString:@"蛋糕"]||[array[0] containsString:@"生日"]) {
            judge = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(judge){
                ViewController *mainController = (ViewController*)self.tabBarController.presentingViewController;
                if([PBManager defaultManager].voiceCount == 0){
                    [mainController setImageWithNum:3];
                    [PBManager defaultManager].voiceCount++;
                }else if([PBManager defaultManager].voiceCount == 1){
                    [mainController setImageWithNum:3];
                    [PBManager defaultManager].voiceCount++;
                }else if([PBManager defaultManager].voiceCount == 2){
                    [mainController setImageWithNum:9];
                    [PBManager defaultManager].voiceCount++;
                }
            }
            NSLog(@"voice-%ld",[PBManager defaultManager].voiceCount);
        });
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error===%@",error);
    }];
}
- (IBAction)playVoice:(id)sender {
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
    
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
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
