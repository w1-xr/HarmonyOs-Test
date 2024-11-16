//侧边栏
export class silderDataClass {
  icon: string
  selectedicon: string
  title?: string
  two?: twoClass[] = []
  icon2?: string
  icon3?: string

  constructor(icon: string, selectedicon: string, title?: string,  icon2?: string, icon3?: string,two?: twoClass[],) {
    this.icon = icon
    this.selectedicon = selectedicon
    this.title = title
    this.two = two
    this.icon2 = icon2
    this.icon3 = icon3
  }
}
export class twoClass{
  title:string
  constructor( title1:string) {
    this.title=title1
  }
}

//正文接口参数
export class classRequestClass{
  pageIndex:number=-1
  pageSize:number=-1
  time1?:string=""
  time2?:string=""
  clazzName?:string=""
}

export class classDataClass{
  pageCount:number
  clazzList:classListClass[]=[]

  constructor( pageCount:number, clazzList:classListClass[]) {
    this.pageCount=pageCount
    this.clazzList=clazzList
  }


}
export class classListClass{
  clazzId:number
  clazzName:string
  clazzNum:number
  startTime:string
  endTime:string
  clazzStatus:string
  clazzLeader: string
  createTime: null|string
  delflag: null|string

  constructor( clazzId:number , clazzName:string , clazzNum:number, startTime:string , endTime:string , clazzStatus:string , clazzLeader: string, createTime: null|string, delflag: null|string,) {
    this.clazzId =clazzId
    this.clazzName =clazzName
    this.clazzNum =clazzNum
    this.startTime =startTime
    this.endTime =endTime
    this. clazzStatus=clazzStatus
    this. clazzLeader=clazzLeader
    this.createTime =createTime
    this. delflag=delflag
  }


}

//班级详情
export class detailRequestClass{
  clazzId:number=-1
  pageIndex:number=-1
  pageSize:number=-1
  clazzName?:string=""
}
// "pageCount": 1,
// "clazzList": [
// {
//   "fileManagerId": 157,
// "fileManagerName": "9999999",
// "fileManagerAccount": "326034",
// "fileManagerPassword": "21232f297a57a5a743894a0e4a801fc3",
// "fileManagerSex": "0",
// "clazzId": 1,
// "fileManagerAddress": "9999",
// "fileManagerSosperson": "99999",
// "fileManagerSosphone": "99",
// "fileManagerDate": "2024-09-12",
// "fileManagerPhone": "111111",
// "fileManagerStatus": "未毕业",
// "fileManagerType": "在习生",
// "createTime": "2024-09-10",
// "delflag": 0,
// "clazzName": null
// }
// ]
export class detailDataClass{
  pageCount:number
  clazzList:detailListClass[]=[]

  constructor(pageCount:number,clazzList:detailListClass[]) {
    this.pageCount=pageCount
    this.clazzList=clazzList
  }
}
export class detailListClass{
  fileManagerId:number
  fileManagerAccount:string
  fileManagerPassword:string
  fileManagerDate:string

  constructor(fileManagerId: number, fileManagerAccount: string, fileManagerPassword: string, fileManagerDate: string,
    fileManagerStatus: string, createTime: string, clazzId: number, fileManagerName: string, fileManagerSex: string,
    fileManagerPhone: string, fileManagerAddress: string, fileManagerSosperson: string, fileManagerSosphone: string,
    clazzName: string) {
    this.fileManagerId = fileManagerId
    this.fileManagerAccount = fileManagerAccount
    this.fileManagerPassword = fileManagerPassword
    this.fileManagerDate = fileManagerDate
    this.fileManagerStatus = fileManagerStatus
    this.createTime = createTime
    this.clazzId = clazzId
    this.fileManagerName = fileManagerName
    this.fileManagerSex = fileManagerSex
    this.fileManagerPhone = fileManagerPhone
    this.fileManagerAddress = fileManagerAddress
    this.fileManagerSosperson = fileManagerSosperson
    this.fileManagerSosphone = fileManagerSosphone
    this.clazzName = clazzName
  }
  fileManagerStatus:string
  createTime:string
  clazzId:number
  fileManagerName:string
  fileManagerSex:string
  fileManagerPhone:string
  fileManagerAddress:string
  fileManagerSosperson:string
  fileManagerSosphone:string
  clazzName:string


}

//修改班级信息
export class EditRequestClass{
  clazzId:number=-1
  clazzName:String=""
  startTime:String=""
  endTime:String=""
  clazzLeader:number=1

  constructor(clazzId: number, clazzName: String, startTime: String, endTime: String, clazzLeader: number) {
    this.clazzId = clazzId
    this.clazzName = clazzName
    this.startTime = startTime
    this.endTime = endTime
    this.clazzLeader = clazzLeader
  }
}

//添加班级信息
export class addRequestClass{
  clazzName:string=""
  startTime:string=""
  endTime:string=""
  clazzLeader:number=-1
}

