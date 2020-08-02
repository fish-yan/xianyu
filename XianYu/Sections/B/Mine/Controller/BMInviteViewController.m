//
//  BMInviteViewController.m
//  XianYu
//
//  Created by Yan on 2019/9/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMInviteViewController.h"
#import "BMInviteCell.h"

@interface BMInviteViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *photo1;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UIImageView *photo2;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UIImageView *photo3;
@property (weak, nonatomic) IBOutlet UILabel *name3;

@end

@implementation BMInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)configView {
    if (!self.finishFriends) {
        return;
    }
    if (self.finishFriends.count > 0) {
        self.name1.text = self.finishFriends[0].name;
        [self.photo1 sd_setImageWithURL:[NSURL URLWithString:self.finishFriends[0].photo]];
    }
    if (self.finishFriends.count > 1) {
        self.name2.text = self.finishFriends[1].name;
        [self.photo2 sd_setImageWithURL:[NSURL URLWithString:self.finishFriends[1].photo]];
    }
    if (self.finishFriends.count > 2) {
        self.name3.text = self.finishFriends[2].name;
        [self.photo3 sd_setImageWithURL:[NSURL URLWithString:self.finishFriends[2].photo]];
    }
}

- (IBAction)inviteAction:(UIButton *)sender {
    
}

- (void)request {
    [NetworkManager sendReq:nil pageUrl:@"getinvitefriends" complete:^(id result) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMInviteCell"];
    cell.model = self.friends[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


@end
