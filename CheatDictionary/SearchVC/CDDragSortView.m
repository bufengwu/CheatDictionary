//
//  CDDragSortView.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/8/25.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDDragSortView.h"
#import "YLDargSortCell.h"
#import "MaximumSpacingFlowLayout.h"
#import "YLDargSortItemModel.h"

#define kSpaceBetweenSubscribe  4 * SCREEN_WIDTH_RATIO
#define kVerticalSpaceBetweenSubscribe  2 * SCREEN_WIDTH_RATIO
#define kSubscribeHeight  35 * SCREEN_WIDTH_RATIO
#define kContentLeftAndRightSpace  20 * SCREEN_WIDTH_RATIO
#define kTopViewHeight  44 * SCREEN_WIDTH_RATIO

@interface CDDragSortView() <UICollectionViewDataSource, UICollectionViewDelegate, SKDragSortDelegate>

@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIButton * sortDeleteBtn;

@property (nonatomic,strong) UICollectionView * dragSortView;

@property (nonatomic,strong) UIView * snapshotView; //截屏得到的view
@property (nonatomic,weak) YLDargSortCell * originalCell;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) NSIndexPath * nextIndexPath;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation CDDragSortView
@synthesize isEditing;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.topView];
        [self addSubview:self.dragSortView];
        self.topView.backgroundColor = CollectViewBG;
        self.dragSortView.backgroundColor = CollectViewBG;
        
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@44);
        }];
        
        [self.dragSortView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
        
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)installModel {
    NSArray *titleArray = @[@"搜索的我",@"军事的",@"娱乐十二五",@"问答是我",@"娱乐",@"汽车等",@"段子得而复失",@"趣图搜索",@"财经风格",@"热点等",@"房产v"];
    for (NSString *title in titleArray) {
        YLDargSortItemModel *model = [YLDargSortItemModel new];
        model.title = title;
        [self.dataArray addObject:model];
    }
}


- (void)finshClick {
    self.isEditing = !self.isEditing;
    NSString * title = self.isEditing ? @"完成":@"排序删除";
    
    self.dragSortView.scrollEnabled = !self.isEditing;
    [_sortDeleteBtn setTitle:title forState:UIControlStateNormal];
    
    [self.dragSortView reloadData];
}

#pragma mark - collectionView dataSouce

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YLDargSortCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YLDargSortCell" forIndexPath:indexPath];
    cell.delegate = self;
    YLDargSortItemModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell installWithModel:model];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDargSortItemModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return model.size;
}


#pragma mark - SKDragSortDelegate

- (void)YLDargSortCellCancelSubscribe:(NSString *)subscribe {
    
}

- (void)YLDargSortCellGestureAction:(UIGestureRecognizer *)gestureRecognizer{
    
    //记录上一次手势的位置
    static CGPoint startPoint;
    //触发长按手势的cell
    YLDargSortCell * cell = (YLDargSortCell *)gestureRecognizer.view;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        //开始长按
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            
            self.isEditing = YES;
            [_sortDeleteBtn setTitle:@"完成" forState:UIControlStateNormal];
            self.dragSortView.scrollEnabled = NO;
        }
        
        if (!self.isEditing) {
            return;
        }
        
        NSArray *cells = [self.dragSortView visibleCells];
        for (YLDargSortCell *cell in cells) {
            [cell showDeleteBtn];
        }
        
        //获取cell的截图
        _snapshotView  = [cell snapshotViewAfterScreenUpdates:YES];
        _snapshotView.center = cell.center;
        [_dragSortView addSubview:_snapshotView];
        _indexPath = [_dragSortView indexPathForCell:cell];
        _originalCell = cell;
        _originalCell.hidden = YES;
        startPoint = [gestureRecognizer locationInView:_dragSortView];
        
        //移动
    }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        CGFloat tranX = [gestureRecognizer locationOfTouch:0 inView:_dragSortView].x - startPoint.x;
        CGFloat tranY = [gestureRecognizer locationOfTouch:0 inView:_dragSortView].y - startPoint.y;
        
        //设置截图视图位置
        _snapshotView.center = CGPointApplyAffineTransform(_snapshotView.center, CGAffineTransformMakeTranslation(tranX, tranY));
        startPoint = [gestureRecognizer locationOfTouch:0 inView:_dragSortView];
        //计算截图视图和哪个cell相交
        for (UICollectionViewCell *cell in [_dragSortView visibleCells]) {
            //跳过隐藏的cell
            if ([_dragSortView indexPathForCell:cell] == _indexPath) {
                continue;
            }
            //计算中心距
            CGFloat space = sqrtf(pow(_snapshotView.center.x - cell.center.x, 2) + powf(_snapshotView.center.y - cell.center.y, 2));
            
            //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
            if (space <= _snapshotView.bounds.size.width * 0.5 && (fabs(_snapshotView.center.y - cell.center.y) <= _snapshotView.bounds.size.height * 0.5)) {
                _nextIndexPath = [_dragSortView indexPathForCell:cell];
                if (_nextIndexPath.item > _indexPath.item) {
                    for (NSUInteger i = _indexPath.item; i < _nextIndexPath.item ; i ++) {
                        [self.dataArray exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                    }
                }else{
                    for (NSUInteger i = _indexPath.item; i > _nextIndexPath.item ; i --) {
                        [self.dataArray exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                    }
                }
                //移动
                [_dragSortView moveItemAtIndexPath:_indexPath toIndexPath:_nextIndexPath];
                //设置移动后的起始indexPath
                _indexPath = _nextIndexPath;
                break;
            }
        }
        //停止
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [_snapshotView removeFromSuperview];
        _originalCell.hidden = NO;
    }
}

#pragma mark -

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = kFont(13);
        titleLabel.text = @"发现";
        [titleLabel sizeToFit];
        titleLabel.textColor = RGBA(110, 110, 110, 1);
        [_topView addSubview:titleLabel];
        titleLabel.tz_centerY = (kTopViewHeight) * 0.5;
        titleLabel.tz_left = kContentLeftAndRightSpace;
        
        UIButton *  finshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topView addSubview:finshBtn];
        [finshBtn setTitle:@"排序删除" forState:UIControlStateNormal];
        [finshBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        finshBtn.titleLabel.font = kFont(12);
        finshBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        finshBtn.layer.borderWidth = kLineHeight;
        finshBtn.layer.cornerRadius = 4 * SCREEN_WIDTH_RATIO;
        finshBtn.layer.masksToBounds = YES;
        [finshBtn sizeToFit];
        finshBtn.tz_height = 21 * SCREEN_WIDTH_RATIO;
        finshBtn.tz_width = finshBtn.tz_width + 8 * SCREEN_WIDTH_RATIO;
        finshBtn.tz_right = SCREEN_WIDTH - kContentLeftAndRightSpace;
        finshBtn.tz_centerY = titleLabel.tz_centerY;
        [finshBtn addTarget:self action:@selector(finshClick) forControlEvents:UIControlEventTouchUpInside];
        _sortDeleteBtn = finshBtn;
        
        UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(20 * SCREEN_WIDTH_RATIO, kTopViewHeight - kLineHeight, SCREEN_WIDTH - 40 * SCREEN_WIDTH_RATIO, kLineHeight)];
        bottomLine.backgroundColor = RGBA(110, 110, 110, 1);
        [_topView addSubview:bottomLine];
    }
    return _topView;
}


- (UICollectionView *)dragSortView {
    if (!_dragSortView) {
        UICollectionViewFlowLayout * layout = [[MaximumSpacingFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(5, 15, 5, 15);
        _dragSortView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,kTopViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopViewHeight) collectionViewLayout:layout];
        _dragSortView.dataSource = self;
        _dragSortView.delegate = self;
        [_dragSortView registerClass:[YLDargSortCell class] forCellWithReuseIdentifier:@"YLDargSortCell"];
    }
    return _dragSortView;
}

@end
