//
//  RequestHeader.h
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#ifndef RequestHeader_h
#define RequestHeader_h

#if DEBUG
#define XY_URL @"http://47.105.192.40:8079/app/call"

#else
#define XY_URL @"http://www.tctantan.top/app/call"

#endif

//

#define XY_Login @"userregister"

#define XY_GetVerifyCode @"getmobilevc"

#define XY_LoadUserInfoData @"getUserApplicantsInfo" //获取个人信息(求职)：

#define XY_FullJobListData @"fulljoblist" //全职工作列表
/// 分享
#define XY_share @"goshare"

#define XY_C_ResumeInfoData @"getuserresume" //个人简历（求职端）
/// 获取c端还是B端
#define XY_loginclient @"loginclient"
/// 行业
#define XY_B_getindustrys @"getindustrys"
/// 保存修改店家信息
#define XY_B_saveuserrecruiter @"saveuserrecruiter"
/// 获取店家信息
#define XY_B_getuserrecruiter @"getuserrecruiter"
/// 店铺列表
#define XY_B_shoplist @"shoplist"
/// 地址列表
#define XY_B_getaddress @"getaddress"
/// 修改、添加地址
#define XY_B_saveaddress @"saveaddress"
/// 保存门店
#define XY_B_saveshop @"saveshop"
/// 获取我的职位
#define XY_B_getmyreleasejob @"getmyreleasejob"
/// 获取福利
#define XY_B_getwelfares @"getwelfares"
/// 获取店铺信息
#define XY_B_getshop @"getshop"
/// 发布/修改职位(全职)
#define XY_B_updatemyreleasejob @"updatemyreleasejob"
/// 发布/修改职位(兼职)
#define XY_B_updatemyreleasepartjob @"updatemyreleasepartjob"
/// 获取简历
#define XY_B_getmyshopresume @"getmyshopresume"
/// 获取简历详情
#define XY_B_getresumedetailed @"getresumedetailed"
/// 获取全职详情
#define XY_B_getmyreleasejobbyid @"getmyreleasejobbyid"
/// 获取兼职详情
#define XY_B_getmyreleasepartjobbyid @"getmyreleasepartjobbyid"
/// 获取商品列表
#define XY_B_getmemerservices @"getmemerservices"
/// 修改职位状态
#define XY_B_updatejobstatus @"updatejobstatus"
/// 店铺认证
#define XY_B_auditstatusshop @"auditstatusshop"
/// 个人认证获取token
#define XY_B_aliyunface @"aliyunface"
/// 个人认证回调
#define XY_B_aliyunfacestatus @"aliyunfacestatus"
/// 个人认证剩余次数，状态
#define XY_B_userfacestatus @"userfacestatus"
/// 内购支付
#define XY_B_rechargememeservicebyapple @"rechargememeservicebyapple"
/// IOS支付成功App回调服务器
#define XY_B_changeordersuccessbyapple @"changeordersuccessbyapple"
/// 获取套餐到期时间
#define XY_B_myservice @"myservice"
/// 获取发布职位数量
#define XY_B_getmyreleasejobcount @"getmyreleasejobcount"
/// 切换角色
#define XY_B_switchclient @"switchclient"
/// 获取是否认证
#define XY_B_userfacestatus @"userfacestatus"
/// 修改简历状态
#define XY_B_updatejldelivery @"updatejldelivery"

#define XY_C_SaveResumeInfoData @"perfectResumenew"
/// 添加工作经历
#define XY_C_addjobexp @"addjobexp"
/// 删除工作经历
#define XY_C_deljobexp @"deljobexp"


//
#define XY_C_Register_SaveUserData @"userapplicantsinfo"  

#endif /* RequestHeader_h */
