//
//  WAISegmentBar.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAISegmentBar.h"
#import "WAISegmentRLButton.h"
#import "WAIMenuBarShowDetailVC.h"

#define WAIMinMargin 30

#define WAIShowMoreBtnW (self.bounds.size.height + 30)

@interface WAISegmentBar()<UICollectionViewDelegate>
@property (nonatomic,weak) UIScrollView * contentView;
@property (nonatomic,strong) NSMutableArray <UIButton *>* itemBtns;

@property (nonatomic,weak) UIView * indicatorView;

@property (nonatomic,strong) WAISegmentBarConfig * config;

@property (nonatomic,weak) UIButton * lastBtn;

@property (nonatomic,strong) WAISegmentRLButton * showMoreBtn;

@property (nonatomic,strong,nonnull) UIView * coverView;

@property (nonatomic,strong) WAIMenuBarShowDetailVC * showDetailVC;

@end

@implementation WAISegmentBar
#pragma mark -懒加载
-(NSMutableArray<UIButton *> *)itemBtns{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}
-(UIScrollView *)contentView{
    if (!_contentView) {
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}
-(UIView *)indicatorView{
    if (!_indicatorView) {
        UIView * indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - self.config.indicatorHeight, 0, self.config.indicatorHeight)];
        indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
        
    }
    return _indicatorView;
}

-(WAIMenuBarShowDetailVC *)showDetailVC{
    if (!_showDetailVC) {
        _showDetailVC = [[WAIMenuBarShowDetailVC alloc]init];
        _showDetailVC.collectionView.delegate = self;
    }
    if (_showDetailVC.collectionView.superview != self.superview) {
        _showDetailVC.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), self.width, 0);
        [self.superview addSubview:_showDetailVC.collectionView];
    }
    return _showDetailVC;
}
-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, self.y + self.height, self.width, 0)];
        _coverView.backgroundColor = [UIColor colorWithRed:55 / 255. green:55 / 255. blue:55 / 255. alpha:0.4];
        UITapGestureRecognizer * gestR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetailPane)];
        [_coverView addGestureRecognizer:gestR];
    }
    if (!_coverView.superview) {
        [self.superview insertSubview:_coverView belowSubview:self.showDetailVC.collectionView];
    }
    return _coverView;
}
-(WAISegmentRLButton *)showMoreBtn{
    if (!_showMoreBtn) {
        UIImage * showImage = [UIImage imageNamed:@"icon_radio_show"];
        UIImage * hideImage = [UIImage imageNamed:@"icon_radio_hide"];
        _showMoreBtn = [[WAISegmentRLButton alloc]init];
        [_showMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_showMoreBtn setImage:showImage forState:UIControlStateNormal];
        [_showMoreBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_showMoreBtn setImage:hideImage forState:UIControlStateSelected];
        _showMoreBtn.imageView.contentMode = UIViewContentModeCenter;
        [_showMoreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _showMoreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIView * lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 0)];
        lineV.backgroundColor = [UIColor lightGrayColor];
        _showMoreBtn.layer.masksToBounds = YES;
        [_showMoreBtn addSubview:lineV];
        [_showMoreBtn addTarget:self action:@selector(showOrHide:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_showMoreBtn];
    }
        return _showMoreBtn;
}

+(instancetype)segmentBarWithConfig:(WAISegmentBarConfig *)config{
    CGRect defaultFrame = CGRectMake(0, 0,WAIScreenWidth, 40);
    WAISegmentBar * segmentBar = [[WAISegmentBar alloc]initWithFrame:defaultFrame];
    segmentBar.config = config;
    return segmentBar;
}
+(instancetype)segmentBarWithFrame:(CGRect)frame{
    WAISegmentBar * segmentBar = [[WAISegmentBar alloc]initWithFrame:frame];
    return segmentBar;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = [WAISegmentBarConfig defaultConfig];
    }
    return self;
}
-(void)updateWithConfig:(void (^)(WAISegmentBarConfig * _Nonnull))configBlock{
    if (configBlock) {
        configBlock(self.config);
    }
    self.config = self.config;
}
-(void)setConfig:(WAISegmentBarConfig *)config{
    _config = config;
    
    self.indicatorView.backgroundColor = config.indicatorColor;
    self.indicatorView.height = config.indicatorHeight;
    self.backgroundColor = config.segmentBarBackColor;
        for (UIButton * btn in self.itemBtns) {
            [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
            if (btn != self.lastBtn) {
                btn.titleLabel.font = config.itemNormalFont;
            }else{
                btn.titleLabel.font = config.itemSelectFont;
            }
            [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        }
    
        [self setNeedsLayout];
        [self layoutIfNeeded];
    
}

- (void)setSegmentMs:(NSArray<id<WAISegmentModelProtocol>> *)segmentMs{
    _segmentMs = segmentMs;
    if (self.config.isShowMore) {
        self.showDetailVC.items = segmentMs;
        self.showDetailVC.collectionView.height = 0;
    }
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    self.lastBtn = nil;
    [self.indicatorView removeFromSuperview];
    self.indicatorView = nil;
    
    for (NSObject <WAISegmentModelProtocol> * segM in segmentMs) {
        UIButton * btn = [[UIButton alloc]init];
        if (segM.segID == -1) {
            btn.tag = self.itemBtns.count;
        }else{
            btn.tag = segM.segID;
        }
        
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:segM.segContent forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemNormalFont;
        [self.contentView addSubview:btn];
        [btn sizeToFit];
        [self.itemBtns addObject:btn];
        
    }
    
    [self layoutIfNeeded];
    [self layoutSubviews];
//    默认选中第一个
    [self btnDidClick:self.itemBtns.firstObject];
}
-(void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString * item in items) {
        UIButton * btn = [[UIButton alloc]init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:item forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemNormalFont;
        btn.backgroundColor = WAIRandomColor;
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)btnDidClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectedWithIndex:fromIndex:)]) {
        _selectIndex = btn.tag;
        [self.delegate segmentBar:self didSelectedWithIndex:btn.tag fromIndex:self.lastBtn.tag];
    }
    
    self.lastBtn.selected = NO;
    self.lastBtn.titleLabel.font = self.config.itemSelectFont;
    [self.lastBtn sizeToFit];
    self.lastBtn.height = self.contentView.height - self.config.indicatorHeight;
    
    btn.selected = YES;
    btn.titleLabel.font = self.config.itemNormalFont;
    [btn sizeToFit];
    btn.height = self.contentView.height - self.config.indicatorHeight;
    self.lastBtn = btn;
    
    if (self.config.isShowMore) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.lastBtn.tag inSection:0];
        [self.showDetailVC.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [self hideDetailPane];
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        NSString * text = btn.titleLabel.text;
        
        NSDictionary * fontDict = @{
                                    NSFontAttributeName:btn.titleLabel.font
                                    };
        CGSize size = [text sizeWithAttributes:fontDict];
        
        self.indicatorView.y = self.contentView.height - self.config.indicatorHeight;
        self.indicatorView.width = size.width + self.config.indicatorExtraW;
        self.indicatorView.centerX = btn.centerX;
    }];
    
    CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;
    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    for (UIButton * btn in self.itemBtns) {
        if (btn.tag == selectIndex) {
            [self btnDidClick:btn];
            break;
        }
    }
}
- (void)hideDetailPane{
    self.showMoreBtn.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showDetailVC.collectionView.height = 0;
        self.coverView.height = 0;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
        self.showDetailVC.collectionView.hidden = YES;
    }];
}
- (void)showDetailPane {
    self.showMoreBtn.selected = YES;
    self.showDetailVC.collectionView.hidden = NO;
    self.coverView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showDetailVC.collectionView.height = self.showDetailVC.expectedHeight;
        self.coverView.height = WAIScreenHeight;
    }];
}
- (void)showOrHide:(WAISegmentRLButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showDetailPane];
    }else{
        [self hideDetailPane];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    if (!self.config.isShowMore) {
        self.contentView.frame = self.bounds;
        self.showMoreBtn.width = -1;
    }else{
        self.contentView.frame = CGRectMake(0, 0, self.width - WAIShowMoreBtnW, self.height);
        self.showMoreBtn.frame = CGRectMake(self.width - WAIShowMoreBtnW, 0, WAIShowMoreBtnW, self.height);
    }
//    更多分割线设置位置
    NSString * text = self.showMoreBtn.titleLabel.text;
    NSDictionary * attrDict = @{
                                NSFontAttributeName:self.showMoreBtn.titleLabel.font
                                };
    CGSize size = [text sizeWithAttributes:attrDict];
    self.showMoreBtn.subviews.lastObject.height = size.height + 6;
    self.showMoreBtn.subviews.lastObject.centerY = self.showMoreBtn.height * 0.5;
    
    CGFloat totalBtnWidth = 0;
    for (UIButton * btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    CGFloat caculateMargin = (self.contentView.width - totalBtnWidth) / (self.segmentMs.count + 1);
    
    caculateMargin = caculateMargin < self.config.limitMargin ? self.config.limitMargin : caculateMargin;
    
    CGFloat btnY = 0;
    CGFloat btnHeight = self.contentView.height - self.config.indicatorHeight;
    UIButton * lastButton;
    
    for (UIButton * btn in self.itemBtns) {
        CGFloat btnX = CGRectGetMaxX(lastButton.frame) + caculateMargin;
        btn.y = btnY;
        btn.x = btnX;
        btn.height = btnHeight;
        lastButton = btn;
    }
    
    self.contentView.contentSize = CGSizeMake(CGRectGetMaxX(lastButton.frame) + caculateMargin, 0);
    if (self.itemBtns.count == 0) {
        return;
    }
    
    UIButton * btn = self.itemBtns[self.selectIndex];
    self.indicatorView.width = btn.width + self.config.indicatorExtraW * 2;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.height = self.config.indicatorHeight;
    self.indicatorView.y = self.contentView.height - self.indicatorView.height;
    
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndex = indexPath.row;
    [self hideDetailPane];
    
}
@end
