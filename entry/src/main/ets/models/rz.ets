//日志列表
export class rzRequestClass{
  pageSize:number=-1
  pageIndex:number=1
}

export class rzDataClass{
  pageCount:number
  logList:logListClass[]=[]

  constructor(pageCount: number, logList: logListClass[]) {
    this.pageCount = pageCount
    this.logList = logList
  }
}
export class logListClass{
  constructor(logId: number, logUserName: string, logClazz: string, logCount: string, logStatus: number,
    createTime: string, delflag: null | string, userSex: string) {
    this.logId = logId
    this.logUserName = logUserName
    this.logClazz = logClazz
    this.logCount = logCount
    this.logStatus = logStatus
    this.createTime = createTime
    this.delflag = delflag
    this.userSex = userSex
  }
  logId:number
  logUserName:string
  logClazz:string
  logCount:string
  logStatus:number
  createTime:string
  delflag:null|string
  userSex:string
}
//添加日志 log/insertLog
export class addrzRequestClass{
  logUserName:number=-1
  logClazz:number=-1
  logCount:string=""
  logStatus:number=-1
}
//修改日志 log/updateLog
export class editrzRequestClass{
  logId:number=-1
  logUserName?:string=""
  logCount?:string=""
  logStatus?:number=-1
}
//删除日志 log/deleteLog/{logId}


