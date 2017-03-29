//
//  TipsModel.h
//  JAJ
//
//  Created by 金安健 on 2016/12/7.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//
//响应结果：
//
//[
// {
//     "desc": "操作成功",
//     "data": [
//              {
//                  "id": "1",
//                  "isNewRecord": false,
//                  "spmch": "",
//                  "guig": "",
//                  "chd": "",
//                  "zgjg": "",
//                  "zdjg": "",
//                  "pjjg": "",
//                  "dw": "",
//                  "fbrq": "",
//                  "leib": "",
//                  "ly": "",
//                  "updateTime": "",
//                  "path": "",
//                  "type": "4",
//                  "title": "11",
//                  "content": "",
//                  "hdzt": "0"
//              },
//              {
//                  "id": "111",
//                  "isNewRecord": false,
//                  "spmch": "",
//                  "guig": "",
//                  "chd": "",
//                  "zgjg": "",
//                  "zdjg": "",
//                  "pjjg": "",
//                  "dw": "",
//                  "fbrq": "",
//                  "leib": "",
//                  "ly": "",
//                  "updateTime": "",
//                  "path": "",
//                  "type": "1",
//                  "title": "1111",
//                  "content": "",
//                  "hdzt": "0"
//              }
//              ],
//     "currentPage": 1,
//     "code": "0000",
//     "totalPage": 1
// }
// ]
#import <Foundation/Foundation.h>

@interface TipsModel : NSObject
/** text内容 */
@property (strong,nonatomic) NSString * content;
/** 视频 */
@property (strong,nonatomic) NSString * path;
/** TITLE标题 */
@property (strong,nonatomic) NSString * title;

@end
