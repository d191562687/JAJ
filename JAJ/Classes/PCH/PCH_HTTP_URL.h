//
//  PCH_HTTP_URL.h
//  JAJ
//
//  Created by 金安健 on 2016/11/30.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#ifndef PCH_HTTP_URL_h
#define PCH_HTTP_URL_h

//请求格式使用 HTTP/POST
//内网IP  http://192.168.1.70:8098
//外网IP  http://124.207.212.87:8098

//IP/端口设置
#define ip_port @"http://192.168.1.70:8098"
/** 贴士游览接口 */
#define appShiyts_URL @"/SYAQ/appShiyts/queryShiytsList.do?"
/** 贴士详情 */
#define appTSxq_URL @"/SYAQ/appShiyts/contentShiyts.do?"
/** 集采列表接口 */
#define appJzcggl_URL @"/SYAQ/appJzcggl/list.do?"
/** 集采价格和订购数量 */
#define Jzcggl_URL @"/SYAQ/appJzcggl/getDGJE.do?"
/** 集采修改数量 */
#define changeJCSL_URL @"/SYAQ/appJzcggl/edit.do?"
/** 集采发布查询 */
#define appJcfbCX_URL @"/SYAQ/appJzcgfb/queryJzcgfbFindList.do?"
/** 集采新增 */
#define appJCadd_URL @"/SYAQ/appJzcgfb/save.do?"
/** 登录 */
#define Login_URL @"/SYAQ/appLogin/login_app.do?"
/** 注册 */
#define appRegister_URL @"/SYAQ/appRegister/registerUser_app.do?";
/** 修改密码 */
#define changeLogin_URL @"/SYAQ/appLogin/editUser_app.do?"
/** 修改资料 */
#define changeZL_URL @"/SYAQ/appXgzl/xgzl_app.do?"
/** 用户详细资料 */
#define appUserXgzl_URL @"/SYAQ/appXgzl/xgzlList_app.do?"
/** 签到 */
#define appQiand_URL @"/SYAQ/appQiand/qiand.do?"
/** 签到信息查询 */
#define appQiandCX_URL @"/SYAQ/appQiand/findqiand.do?"
/** 四品一械列表 */
#define appSpyx_URL @"/SYAQ/appSpyx/querySpyxList.do?"
/** 四品一械详情 */
#define appSpyxDetial_URL @"/SYAQ/appSpyx/querySpyxInfo.do?"
/** 厂家查询列表 */
#define appCjcx_URL @"/SYAQ/appCjcx/cjcxList.do?"
/** 厂家详情 */
#define appCjXQ_URL @"/SYAQ/appCjcx/cjcxXQ.do?"
/** 食药信息 */
#define appSYxx_URL @"/SYAQ/appSpyx/querySpdaList.do?"
/** 账号注册 */
#define appRRegister_URL @"/SYAQ/appRegister/registerUser_app.do?"
/** 采购记录 */
#define appSpyxSS_URL @"/SYAQ/appSpyx/saveAppGjjl.do?"
/** 四品一械追溯 */
#define appSPYXZS_URL @"/SYAQ/appSpyxZs/querySpyxZsList.do?"





#endif /* PCH_HTTP_URL_h */
