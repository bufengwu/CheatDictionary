//
//  CDPhotoDetailVC.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/21.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPhotoDetailVC.h"
#import "SXLineLayout.h"
#import "SXImageCell.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>

@interface CDPhotoDetailVC () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CDPhotoDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局
    SXLineLayout *layout = [[SXLineLayout alloc] init];
    
    // 创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.tz_width, 250) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[SXImageCell class] forCellWithReuseIdentifier:@"SXImageCell"];
//    collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    self.images = @[
                    @"1",
                    @"2",
                    @"3",
                    @"4",
                    @"5",
                    @"6",
                    @"7",
                    @"8",
                    ];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXImageCell" forIndexPath:indexPath];
    NSString *image = self.images[indexPath.row%(self.images.count)];
    cell.imageView.image = [UIImage imageNamed:image];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    CGPoint point = [self.view convertPoint:cell.center fromView:collectionView];
    
    if (point.x != self.view.tz_centerX) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } else {
        //创建MWPhotoBrowser ，要使用initWithDelegate方法，要遵循MWPhotoBrowserDelegate协议
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        //设置当前要显示的图片
        [browser setCurrentPhotoIndex:indexPath.row];
        //push到MWPhotoBrowser
        [self.navigationController pushViewController:browser animated:YES];
    }
}

//返回图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.images.count;
}

//返回图片模型
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{

    //创建图片模型
    MWPhoto *photo = [MWPhoto photoWithImage:[UIImage imageNamed:self.images[index%(self.images.count)]]];

    return photo;

}

@end
