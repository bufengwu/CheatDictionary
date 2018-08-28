//
//  PageControlView.m
//  CCPageControl
//
//  Created by 崔璨 on 2017/8/17.
//  Copyright © 2017年 cccc. All rights reserved.
//

#import "CCPageControlView.h"

static NSString *reuseIdentifier = @"PageControlCollectionViewCell";

@interface PageControlCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageV;

@end

@implementation PageControlCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [UIImageView new];
        [self.contentView addSubview:self.imageV] ;
    }
    return self;
}

@end

#pragma mark -

@interface CCPageControlView() <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionV;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIPageControl *pageV;

@end

@implementation CCPageControlView

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.collectionV = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = self.frame.size;
            layout.sectionInset = UIEdgeInsetsZero;
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
            collectionView.frame = self.frame;
            collectionView.dataSource = self;
            collectionView.delegate = self;
            collectionView.pagingEnabled = YES;
            collectionView.showsHorizontalScrollIndicator = NO;
            collectionView.bounces = NO;
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.showsHorizontalScrollIndicator = NO;
            [collectionView registerClass:[PageControlCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
            collectionView;
        });
        [self addSubview:self.collectionV];
        
        self.pageV = ({
            UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.1)];
            pageControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - pageControl.frame.size.height/2);
            pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
            pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
            pageControl;
        });
        [self addSubview:self.pageV];
        
        
        self.btn = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.5, self.frame.size.height * 0.05)];
            button.center = CGPointMake(self.frame.size.width/2, self.pageV.frame.origin.y - button.frame.size.height/2);
            button.hidden = YES;
            button.backgroundColor = [UIColor clearColor];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = button.frame.size.height/2;
            button.layer.borderWidth = 1.0;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(removeViewBtn:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"开始体验" forState:UIControlStateNormal];
            button;
        });
        [self addSubview:self.btn];
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    
    self.pageV.numberOfPages = self.imageArr.count;
}

-(void)removeViewBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        sender.backgroundColor = [UIColor clearColor];
        [self removeFromSuperview];
    }];
}

- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor grayColor];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageControlCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    cell.imageV.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    return cell;
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    if ((scrollView.contentOffset.x/self.frame.size.width) == self.imageArr.count-1){
        [UIView animateWithDuration:0.3 animations:^{
           self.btn.hidden = NO;
        }];
    }
    else
    {
        self.btn.hidden = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageV.currentPage = page;
}

@end
