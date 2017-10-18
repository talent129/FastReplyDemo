//
//  QuickReplyController.m
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/28.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "QuickReplyController.h"
#import "Define.h"
#import "Model.h"
#import "ReplyDetailController.h"

@interface QuickReplyController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation QuickReplyController

#pragma mark -lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = view;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewQuickReplyBtnAction)];
        [view addGestureRecognizer:tap];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 50)];
        label.text = @"新建";
        label.textColor = [UIColor blueColor];
        [view addSubview:label];
        
//        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        addBtn.frame = CGRectMake(10, 0, 60, 50);
//        [addBtn setTitle:@"新建" forState:UIControlStateNormal];
//        [addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [addBtn addTarget:self action:@selector(addNewQuickReplyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:addBtn];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    UIImageView *img = [[UIImageView alloc] init];
    img.image = Image(@"email-zan");
    [titleView addSubview:img];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"快速回复模板";
    titleLabel.font = Bold_Font(18);
    titleLabel.textAlignment = NSTextAlignmentRight;
    [titleView addSubview:titleLabel];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.centerY.equalTo(titleView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(img.mas_trailing).mas_offset(5);
        make.centerY.equalTo(titleView);
    }];
    
    self.navigationItem.titleView = titleView;
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createUI];
    
    [self addBarButton];
    
}

- (void)createUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    Model *model = self.dataArray[indexPath.row];
    cell.imageView.image = Image(model.icon);
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReplyDetailController *vc = [ReplyDetailController new];
    vc.model = self.dataArray[indexPath.row];
    
    WEAKSELF
    vc.refreshBlock = ^(Model *newModel) {
        
        [weakSelf.tableView reloadData];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 100, 20)];
    label.text = @"收藏";
    label.textColor = [UIColor lightGrayColor];
    label.font = Sys_Font(14);
    
    [view addSubview:label];
    return view;
}

//是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//编辑风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataArray removeObjectAtIndex:indexPath.row];//删除数据源中相应数据
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        [self.dataArray insertObject:@"cc" atIndex:indexPath.row];//插入数据
//        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (editingStyle == (UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete)) {
        
    }
}

#pragma mark 排序
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 取出要拖动的模型数据
    Model *model = self.dataArray[sourceIndexPath.row];
    //删除之前行的数据
    [self.dataArray removeObject:model];
    // 插入数据到新的位置
    [self.dataArray insertObject:model atIndex:destinationIndexPath.row];
}

// 设置组头黏性 (取消悬停)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)addBarButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnAction)];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(0, 0, 60, 44);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = Sys_Font(18);
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn = editBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
}

- (void)addNewQuickReplyBtnAction
{
    NSLog(@"==click new");
    ReplyDetailController *vc = [[ReplyDetailController alloc] init];
    vc.isNewFlag = YES;
    
    WEAKSELF
    vc.refreshBlock = ^(Model *newModel) {
        [weakSelf.dataArray addObject:newModel];
        [weakSelf.tableView reloadData];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftBarBtnAction
{
    NSLog(@"==left");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)editBtnClick:(UIButton *)btn
{
    NSLog(@"-==edit");
    //设置tableview编辑状态
    BOOL flag = !self.tableView.editing;
    [self.tableView setEditing:flag animated:YES];
    self.editBtn.selected = flag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
