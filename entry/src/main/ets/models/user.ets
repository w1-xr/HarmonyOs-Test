//用户列表
export class userRequestClass{
  userName?:string=""
  pageIndex:number=-1
  pageSize:number=-1
}
export class userDataClass{
  pageCount:number
  userList:userListClass[]=[]

  constructor(pageCount: number, userList: userListClass[]) {
    this.pageCount = pageCount
    this.userList = userList
  }
}
export class userListClass{
  userId:number
  userName:string
  userPassword:string| null
  userAccount:string
  userSex:string
  userPhone:string
  userRole: string
  delflag: string|null
  createTime:string| null
  managerId:string| null
  deptId: string|null

  constructor(userId: number, userName: string, userPassword: string | null, userAccount: string, userSex: string,
    userPhone: string, userRole: string, delflag: string | null, createTime: string | null, managerId: string | null,
    deptId: string | null) {
    this.userId = userId
    this.userName = userName
    this.userPassword = userPassword
    this.userAccount = userAccount
    this.userSex = userSex
    this.userPhone = userPhone
    this.userRole = userRole
    this.delflag = delflag
    this.createTime = createTime
    this.managerId = managerId
    this.deptId = deptId
  }
}
//添加用户
export class addUserRequestClass{
  userName:string=""
  userAccount:string=""
  userPassword :string=""
  userSex :string=""
  deptId :string=""
  userPhone :string=""
  userRole :string=""
}
//部门
export class deptDataClass{
  constructor(deptId: number, deptName: string, managerId: string) {
    this.deptId = deptId
    this.deptName = deptName
    this.managerId = managerId
  }
  deptId:number
  deptName:string
  managerId:string
}

//修改用户
export class editUserRequestClass{
  userId:number=-1
  userName?:string=""
  userAccount?:string=""
  userPassword? :string=""
  userSex ?:string|number=""
  deptId ?:string=""
  userPhone ?:string=""
  userRole ?:string=""
}

//查询用户id
export class searchRequestClass{

}

