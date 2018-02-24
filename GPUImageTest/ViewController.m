//
//  ViewController.m
//  GPUImageTest
//
//  Created by chenyun on 2018/1/22.
//  Copyright © 2018年 yctc. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
#import "CollectionViewCell.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    /*
    UIImage *inputImage = [UIImage imageNamed:@"854037.jpg"];
    
    //使用黑白素描滤镜
    GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc] init];
    
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    
    //开始渲染
    [stillImageSource processImage];
    
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,50,inputImage.size.width ,inputImage.size.height);
    [self.view addSubview:imageView];
     */
    [self initUI];
}

- (void)initUI {
    self.dataSource = @[@"中间突出 四周暗", @"红", @"蓝", @"绿", @"怀旧", @"朦胧加暗", @"饱和", @"亮度", @"曝光度", @"素描", @"卡通", @"原图"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width / 6, 50);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"854037.jpg"]];
    self.imgView.frame = CGRectMake(20, 300, 350, 350);
    [self.view addSubview:self.imgView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentLab.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    Test1ViewController *ctl = [[Test1ViewController alloc] init];
//    [self.navigationController pushViewController:ctl animated:YES];
    
    Test2ViewController *ctl = [[Test2ViewController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
    return;
    
    self.imgView.image = [self hightLightImage:indexPath.row];
}

- (UIImage *)hightLightImage:(NSInteger)type {
    UIImage *image = [UIImage imageNamed:@"854037.jpg"];
    switch (type) {
        case 0:
            // 中间突出 四周暗  GPUImageVignetteFilter
            {
                // GPUImageCropFilter
                GPUImageCropFilter *passthroughFilter = [[GPUImageCropFilter alloc] init];
                passthroughFilter.cropRegion = CGRectMake(0, 0, 0.5, 1);
                //设置要渲染的区域
                [passthroughFilter forceProcessingAtSize:image.size];
                [passthroughFilter useNextFrameForImageCapture];
                //获取数据源
                GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
                [stillImageSource addTarget:passthroughFilter];
                //开始渲染
                [stillImageSource processImage];
                UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
                return finallImage;
                break;
            }
            
        case 1:
            {
                // 红
                GPUImageRGBFilter *passthroughFilter = [[GPUImageRGBFilter alloc] init];
                passthroughFilter.red = 0.9;
                passthroughFilter.green = 0.8;
                passthroughFilter.blue = 0.9;
                //设置要渲染的区域
                [passthroughFilter forceProcessingAtSize:image.size];
                [passthroughFilter useNextFrameForImageCapture];
                //获取数据源
                GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
                [stillImageSource addTarget:passthroughFilter];
                //开始渲染
                [stillImageSource processImage];
                UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
                return finallImage;
                break;
            }
            
        case 2:
        {
            // 蓝
            GPUImageRGBFilter *passthroughFilter = [[GPUImageRGBFilter alloc] init];
            passthroughFilter.red = 0.8;
            passthroughFilter.green = 0.8;
            passthroughFilter.blue = 0.9;
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
        case 3:
            
        {
            // 绿
            GPUImageRGBFilter *passthroughFilter = [[GPUImageRGBFilter alloc] init];
            passthroughFilter.red = 0.8;
            passthroughFilter.green = 0.9;
            passthroughFilter.blue = 0.8;
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
        case 4:
            {
                //怀旧
                GPUImageSepiaFilter *passthroughFilter = [[GPUImageSepiaFilter alloc] init];
                //设置要渲染的区域
                [passthroughFilter forceProcessingAtSize:image.size];
                [passthroughFilter useNextFrameForImageCapture];
                //获取数据源
                GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
                [stillImageSource addTarget:passthroughFilter];
                //开始渲染
                [stillImageSource processImage];
                UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
                return finallImage;
                break;
            }
        case 5:
            
        {
            //朦胧加暗
            GPUImageHazeFilter *passthroughFilter = [[GPUImageHazeFilter alloc] init];
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
        case 6:
            
        {
            //饱和
            GPUImageSaturationFilter *passthroughFilter = [[GPUImageSaturationFilter alloc] init];
            passthroughFilter.saturation = 1.5;
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
        case 7:
            
        {
            //亮度
            GPUImageBrightnessFilter *passthroughFilter = [[GPUImageBrightnessFilter alloc] init];
            passthroughFilter.brightness = 0.2;
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
        case 8:
            
        {
            //曝光度
            GPUImageExposureFilter *passthroughFilter = [[GPUImageExposureFilter alloc] init];
            passthroughFilter.exposure = 0.2;
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
        case 9:
            
        {
            //素描
            GPUImageSketchFilter *passthroughFilter = [[GPUImageSketchFilter alloc] init];
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
        case 10:
            
        {
            //卡通
            GPUImageSmoothToonFilter *passthroughFilter = [[GPUImageSmoothToonFilter alloc] init];
            passthroughFilter.blurRadiusInPixels = 0.2;
            //设置要渲染的区域
            [passthroughFilter forceProcessingAtSize:image.size];
            [passthroughFilter useNextFrameForImageCapture];
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
            [stillImageSource addTarget:passthroughFilter];
            //开始渲染
            [stillImageSource processImage];
            UIImage *finallImage = [passthroughFilter imageFromCurrentFramebuffer];
            return finallImage;
            break;
        }
            
        default:
            return image;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
