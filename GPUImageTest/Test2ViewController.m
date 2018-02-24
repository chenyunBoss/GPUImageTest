//
//  Test2ViewController.m
//  GPUImageTest
//
//  Created by chenyun on 2018/1/29.
//  Copyright © 2018年 yctc. All rights reserved.
//

#import "Test2ViewController.h"
#import "GPUImage.h"

@interface Test2ViewController ()

@property (nonatomic, strong) GPUImageMovie  *movieEncoder;
@property (nonatomic, strong) GPUImageAlphaBlendFilter  *filter;
@property (nonatomic, strong) GPUImageBrightnessFilter *brightnessFilter;
@property (nonatomic, strong) GPUImageUIElement *uielement;
@property (nonatomic, strong) GPUImageView *preview;
@property (nonatomic, strong) UIView *waterV;

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_movieEncoder startProcessing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_movieEncoder endProcessing];
}

- (void)setupSubviews{
    
//    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    img.image = [UIImage imageNamed:@"854037.jpg"];
//    [self.view addSubview:img];
    
//    GPUImageView *imgV = [[GPUImageView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:imgV];
    
    _preview = [GPUImageView new];
    _preview.frame = self.view.bounds;
    [self.view addSubview:_preview];
    _preview.fillMode = kGPUImageFillModePreserveAspectRatio;
    
//    [_preview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(0);
//        make.width.mas_equalTo(self.view.mas_width);
//        make.height.mas_equalTo(self.view.mas_width);
//    }];
    
    _waterV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    _waterV.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 20, 80, 60)];
    [_waterV addSubview:imageView];
    
    [imageView setImage:[UIImage imageNamed:@"111.jpg"]];
    
    _filter = [[GPUImageAlphaBlendFilter alloc]init];
    _filter.mix = 1.0f;
    [_filter addTarget:_preview];
    

    _brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    _brightnessFilter.brightness = 0.0f;
    [_brightnessFilter addTarget:_filter];
    
    _uielement = [[GPUImageUIElement alloc]initWithView:_waterV];
    [_uielement addTarget:_filter];
    __weak typeof(self) ws = self;
    [_brightnessFilter setFrameProcessingCompletionBlock:^(GPUImageOutput *output, CMTime time) {
        [ws.uielement update];
    }];
}

- (void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.mp4" ofType:nil];
    _movieEncoder = [[GPUImageMovie alloc]initWithURL:[NSURL fileURLWithPath:path]];
    _movieEncoder.shouldRepeat = NO;
    _movieEncoder.playAtActualSpeed = YES;
    [_movieEncoder addTarget:_brightnessFilter];
    
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
