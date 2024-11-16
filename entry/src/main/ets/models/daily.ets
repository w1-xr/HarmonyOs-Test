//日常正文内容
export class dailyRequestClass{
  dailyParperUserName?:String=""
  pageSize?:number=10
  pageIndex?:number=1
}
export class dailyDataClass{
  constructor(pageCount: number, dailyList: dailyListClass[]) {
    this.pageCount = pageCount
    this.dailyList = dailyList
  }
  pageCount:number
  dailyList:dailyListClass[]=[]

}
 export class dailyListClass{
  dailyParperld?:number=-1
  dailyParperDate:string=""
  dailyParperContent:string=""
  dailyParperUserName:string |number=""
  createTime?:string|null=""
  delflag?:string|null=""
}




//出差记录  business/businessList
export class dailyCCRequestClass{
  userId:number=-1
  pageSize?:number=10
  pageIndex?:number=1
  userName?:string=""

}

export class dailyCCDataClass{
  constructor(pageCount: number, dailyCCList: dailyCCListClass[]) {
    this.pageCount = pageCount
    this.dailyList = dailyCCList
  }
  pageCount:number
  dailyList:dailyCCListClass[]=[]

}
export class dailyCCListClass{
  businessId?:number=-1
  businessDate:string=""
  endDate?:string=""
  duration:number=-1
  address:string=""
  userId:string |number=""
  createTime?:string|null=""
  delflag?:string|null=""
}



//请假记录 vacation/vacationList
export class dailyQJRequestClass{
  userId:number=-1
  userName?:string=""
  pageSize?:number=10
  pageIndex?:number=1
}

export class dailyQJDataClass{
  constructor(pageCount: number, dailyQJList: dailyQJListClass[]) {
    this.pageCount = pageCount
    this.vacationList = dailyQJList
  }

  pageCount:number
  vacationList:dailyQJListClass[]=[]

}
export class dailyQJListClass{
  vacationId?:number=-1
  vacationDate?:string=""
  userName?:string=""
  endDate?:string=""
  duration?:number |string=-1
  vacationCount?:string=""
  userId?:string| number=""
  identify?:string|number=""
  status?:string=""
  examine?:string=""
  createTime?:string|null=""
  delflag?:string|null=""
}
//日常-考勤统计  count/countList
export class dailyKQRequestClass{
  time?:string="0"
  pageSize?:number=10
  pageIndex?:number=1
}

export class dailyKQDataClass{
  pageCount:number
  countVos:dailyKQListClass[]=[]

  constructor(pageCount: number, dailyKQList: dailyKQListClass[]) {
    this.pageCount = pageCount
    this.countVos = dailyKQList
  }
}
export class dailyKQListClass{


  constructor(userId: number, userName: string, userRole: string, businessDay: number, vacationDay: number,
    workDay: number, shouldDay: number, realDay: number) {
    this.userId = userId
    this.userName = userName
    this.userRole = userRole
    this.businessDay = businessDay
    this.vacationDay = vacationDay
    this.workDay = workDay
    this.shouldDay = shouldDay
    this.realDay = realDay
  }
  userId:number
  userName:string
  userRole:string
  businessDay:number
  vacationDay:number
  workDay:number
  shouldDay:number
  realDay:number
}

//插入日常
export class addrcRequestClass{
  dailyParperDate:string=""
  dailyParperContent:string=""
  dailyParperUserName:number=-1
}
