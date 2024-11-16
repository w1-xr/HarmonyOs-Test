//学生档案l列表】 fileManager/fileManagerList
export class stuDARequestClass{
  pageIndex:number=-1
  pageSize:number=-1
  fileManagerType:string=""//预招生/在习生
  fileManagerName?:string=""//搜索的时候传档案名
}

export class stuDADataClass{
  constructor(pageCount: number, fileManagerList: fileManagerListClass[]) {
    this.pageCount = pageCount
    this.fileManagerList = fileManagerList
  }
/*  fileManagerName:string//姓名
  fileManagerSex:string
  clazzName:string//预报班级/班级
  fileManagerDate:string//预报到时间/毕业时间
  fileManagerPhone:string//电话
  fileManagerId:number//ID号
  clazzId:number//班级ID
  fileManagerType:string//"在习生/预招生"
  fileManagerStatus:string//毕业状态
  fileManagerAddress:string
  fileManagerSosperson:string
  fileManagerSosphone:string
  createTime:string
  fileManagerAccount:string//账号*/

  pageCount:number
  fileManagerList:fileManagerListClass[]=[]
}

export class fileManagerListClass{
  fileManagerName:string
  fileManagerSex:string
  fileManagerDate:string
  fileManagerPhone:string
  fileManagerId:number
  clazzId:number
  fileManagerType:string
  fileManagerStatus:string
  fileManagerAddress:string
  fileManagerSosperson:string
  fileManagerSosphone:string
  createTime:string
  fileManagerAccount:string
  clazzName:string

  constructor(fileManagerName: string, fileManagerSex: string, clazzName: string, fileManagerDate: string,
    fileManagerPhone: string, fileManagerId: number, clazzId: number, fileManagerType: string,
    fileManagerStatus: string, fileManagerAddress: string, fileManagerSosperson: string, fileManagerSosphone: string,
    createTime: string, fileManagerAccount: string) {
    this.fileManagerName = fileManagerName
    this.fileManagerSex = fileManagerSex
    this.clazzName = clazzName
    this.fileManagerDate = fileManagerDate
    this.fileManagerPhone = fileManagerPhone
    this.fileManagerId = fileManagerId
    this.clazzId = clazzId
    this.fileManagerType = fileManagerType
    this.fileManagerStatus = fileManagerStatus
    this.fileManagerAddress = fileManagerAddress
    this.fileManagerSosperson = fileManagerSosperson
    this.fileManagerSosphone = fileManagerSosphone
    this.createTime = createTime
    this.fileManagerAccount = fileManagerAccount}
}

//添加学生档案  fileManager/addFileManager
export class addDARequestCLass{
  fileManagerName:string=""
  fileManagerAccount?:string=""
  fileManagerSex:string=""
  clazzId:number=-1
  fileManagerAddress?:string=""
  fileManagerSosperson?:string=""
  fileManagerSosphone?:string=""
  fileManagerDate:string=""
  fileManagerPhone:string=""
  fileManagerType:string=""
}
//班级下拉框
export class classIdDataClass{
  clazzId:number=-1
  clazzName:string=""
}

//修改学生档案 fileManager/updateFileManager
export class editDARequestClass{
  fileManagerName:string=""
  fileManagerId:number=-1
  fileManagerAccount?:string=""
  fileManagerSex:string=""
  clazzId:number=-1
  fileManagerAddress?:string=""
  fileManagerSosperson?:string=""
  fileManagerSosphone?:string=""
  fileManagerDate:string=""
  fileManagerPhone:string=""
}

//删除学生档案 fileManager/deleteFileManager
export class delRequestClass{
  fileManagerId:number=-1
}
//学生档案内容
export class sDetailRequestClass{
  fileManagerId:number=-1
}
export class sDetailDataClass{
  fileManagerName:string

  constructor(fileManagerName: string, fileManagerSex: string, fileManagerDate: string, fileManagerPhone: string,
    fileManagerId: number, clazzId: number, fileManagerType: string, fileManagerStatus: string,
    fileManagerAddress: string, fileManagerSosperson: string, fileManagerSosphone: string, createTime: string,
    fileManagerAccount: string, clazzName: string, delflag: number) {
    this.fileManagerName = fileManagerName
    this.fileManagerSex = fileManagerSex
    this.fileManagerDate = fileManagerDate
    this.fileManagerPhone = fileManagerPhone
    this.fileManagerId = fileManagerId
    this.clazzId = clazzId
    this.fileManagerType = fileManagerType
    this.fileManagerStatus = fileManagerStatus
    this.fileManagerAddress = fileManagerAddress
    this.fileManagerSosperson = fileManagerSosperson
    this.fileManagerSosphone = fileManagerSosphone
    this.createTime = createTime
    this.fileManagerAccount = fileManagerAccount
    this.clazzName = clazzName
    this.delflag = delflag
  }
  fileManagerSex:string
  fileManagerDate:string
  fileManagerPhone:string
  fileManagerId:number
  clazzId:number
  fileManagerType:string
  fileManagerStatus:string
  fileManagerAddress:string
  fileManagerSosperson:string
  fileManagerSosphone:string
  createTime:string
  fileManagerAccount:string
  clazzName:string
  delflag:number
}





