import {  silderDataClass, twoClass } from '../models/classManagement'

export const silderData:silderDataClass[]=[
  new silderDataClass("/images/bjglBlack.png","/images/bjglBlue.png","班级管理"),
  new silderDataClass("/images/rcBlack.png","/images/rcBlue.png","日常        ","/images/rback.png","/images/bottomback.png",[new twoClass("出差记录"), new twoClass("请假记录"),new twoClass("考勤统计"),],),
  new silderDataClass("/images/yhglBlack.png","/images/yhglBlue.png","用户管理"),
  new silderDataClass("/images/daBlack.png","/images/daBlue.png","学生档案"),
  new silderDataClass("/images/rzxtBlack.png","/images/rzxtBlue.png","日志系统"),
  new silderDataClass("/images/shxtBlack.png","/images/shxtBlue.png","审核系统"),
  new silderDataClass("/images/xmglBlack.png","/images/xmglBlue.png","项目管理"),
]
export const silderDatatwo:silderDataClass[]=[
  new silderDataClass("/images/bjglBlack.png","/images/bjglBlue.png","班级管理"),
  new silderDataClass("/images/rcBlack.png","/images/rcBlue.png","日常        ","/images/rback.png","/images/bottomback.png",[new twoClass("出差记录"), new twoClass("请假记录"),new twoClass("考勤统计"),],),
  new silderDataClass("/images/xmglBlack.png","/images/xmglBlue.png","项目管理"),
  new silderDataClass("/images/yhglBlack.png","/images/yhglBlue.png","系统设置"),
]
export const silderDataStu:silderDataClass[]=[
  new silderDataClass("/images/bjglBlack.png","/images/bjglBlue.png","首页        "),
  new silderDataClass("/images/rcBlack.png","/images/rcBlue.png","请假记录"),
  new silderDataClass("/images/xmglBlack.png","/images/xmglBlue.png","考勤记录"),
  new silderDataClass("/images/yhglBlack.png","/images/yhglBlue.png","日志系统"),
  new silderDataClass("/images/yhglBlack.png","/images/yhglBlue.png","项目管理"),
  new silderDataClass("/images/yhglBlack.png","/images/yhglBlue.png","系统设置"),
]

export const classTitle:string[]=["班级序号","班级名称","班级人数","开始时间","结束时间","班级老师","班级状态","   操作","    "]
export const classDetailTitle:string[]=["姓名","性别","电话","家庭住址","紧急联系人","紧急联系人电话"]
export const smallTitle:string[]=["姓名","报告内容","日期"]
export const smallCCTitle:string[]=["姓名","出发地点","出发时间","返回时间","出差总时长","交通工具"]
export const smallQJTitle:string[]=["姓名","标识","请假是由","开始时间","结束时间","请假时长"]
export const smallKQTitle:string[]=["姓名","请假","标识","出差","工作","应出勤","实际出勤"]
export const userTitle:string[]=["全选","姓名","部门","性别","电话","职能","操作"]
export const yuzhaoTitle:string[]=["姓名","性别","预报班级","预报道时间","电话","操作"]
export const zaixiaoTitle:string[]=["姓名","性别","班级","毕业日期","电话","状态","操作","    "]
export const rzTitle:string[]=["姓名","性别","班级","时间","内容"]
export const shenheTitle:string[]=["姓名","请假事由","职能","请假时间","操作"]
export const FatherTitle:string[]=["编号","项目名称","负责人","工时（天）","开始时间","结束时间","项目进度","    "]
export const ChildTitle:string[]=["编号","项目名称","负责人","工时（天）","开始时间","结束时间","项目进度","     "]
export const TaskTitle:string[]=["编号","任务名称","负责人","工时（天）","开始时间","结束时间","项目进度","占比率","操作  "]
