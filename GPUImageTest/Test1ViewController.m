//
//  Test1ViewController.m
//  GPUImageTest
//
//  Created by chenyun on 2018/1/29.
//  Copyright © 2018年 yctc. All rights reserved.
//

#import "Test1ViewController.h"
#import "GPUImage.h"

@interface Test1ViewController () {
    GPUImagePicture *pictureFile;
    GPUImagePicture *pictureFile2;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageVideoCamera *videoCamera;
    GPUImageView *filterView;
}

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"摄像头水印";
    [self initGPUImageView];
    [self initWaterMarkPic];
    [self initFilter];
    [self initCamera];
    
//    [videoCamera addTarget:filter];
    [pictureFile addTarget:filter];
    [pictureFile2 addTarget:filter];
    
    [filter addTarget:filterView];
    [pictureFile processImage];
    [pictureFile2 processImage];
//    [videoCamera startCameraCapture];
}

- (void)initGPUImageView {
    filterView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:filterView];
}

- (void)initWaterMarkPic {
    pictureFile = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"854037.jpg"]];
    pictureFile2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"111.jpg"]];
}

- (void)initFilter {
    filter = [[GPUImageMultiplyBlendFilter alloc] init];
}

- (void)initCamera {
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;videoCamera.horizontallyMirrorFrontFacingCamera = YES;
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
