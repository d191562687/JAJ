//
//  TipsModel.h
//  JAJ
//
//  Created by 金安健 on 2016/12/7.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//
//{
//    "code": "0000",
//    "data": [
//             {
//                 "content": "\r\n<p></p><div id=\"tmp\" class=\"edui-faked-video\"><a id=\"player\" class=\"edui-faked-video\" style=\"height:500px;width:700px;display:block\" href=\"http://www.sfda.gov.cn/WS01/video/example/20160727syaqscxrky.flv\" align=\"none\" height=\"400\" width=\"700\"></a><script type=\"text/javascript\" src=\"../wbppjs/flowplayer-3.2.11.min.js\"></script><script src=\"../wbppjs/player.js\"></script></div></p><p>视频下载地址：<a href=\"http://www.sfda.gov.cn/WS01/video/example/20160727syaqscxrky.flv\">http://www.sfda.gov.cn/WS01/video/example/20160727syaqscxrky.flv</a></p><p> </p>\r\n",
//                 "path": "http://www.sfda.gov.cn/WS01/video/example/20160727syaqscxrky.flv
//                 
//                 ",
//                 "title": "食药安全手册：夏日“烤”验\r\n"
//             }
//             ],
//    "desc": "操作成功"
//}
//type:1
//{
//    "code": "0000",
//    "data": [
//             {
//                 "content": "商品名称:盘锦新瑞雪大米<br>规格:普通<br>产地:null<br>最高价格:2.42<br>最低价格:2.38<br>平均价格:2.40<br>单位:斤<br>发布日期:2016-08-10<br>类别:5<br>来源:1<br>更新日期:2016-08-22 12:49:50",
//                 "title": "盘锦新瑞雪大米"
//             }
//             ],
//    "desc": "操作成功"
//}
//type:2

#import <Foundation/Foundation.h>

@interface TipsModel : NSObject
/** text内容 */
@property (strong,nonatomic) NSString * content;
/** 视频 */
@property (strong,nonatomic) NSString * path;
/** TITLE标题 */
@property (strong,nonatomic) NSString * title;

@end
