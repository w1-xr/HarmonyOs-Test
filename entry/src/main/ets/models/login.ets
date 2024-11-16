//登录
export class loginRequestClass{
  userAccount:string=""
  userPassword:string=""
}
class userInfoClass{
  userId:number=-1
  userName:string=""
  userPassword:string|number|null=-1
  userAccount:string=""
  userSex:string=""
  userPhone:string=""
  userRole:string=""
  delflag:string|number|null=-1
  createTime:string|number|null=-1
  managerId:string=""
  deptId:string=""
  }
export class loginDataClass{
    userInfo: Partial<userInfoClass>={}
    haveTask:number=-1
    haveProjectChild:number=-1
    havaProject:number=-1
    isTeacher:number=-1
}