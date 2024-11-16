//审核列表
export class  shenheDataClass{
  vacationId:number
  vacationDate:string
  endDate:string
  duration:null|string
  vacationCount:string
  userId:string
  identify:string
  status:string|null
  examine:string|null
  createTime:string|null
  delflag:string|null

  constructor(vacationId: number, vacationDate: string, endDate: string, duration: null | string, vacationCount: string,
    userId: string, identify: string, status: string | null, examine: string | null, createTime: string | null,
    delflag: string | null) {
    this.vacationId = vacationId
    this.vacationDate = vacationDate
    this.endDate = endDate
    this.duration = duration
    this.vacationCount = vacationCount
    this.userId = userId
    this.identify = identify
    this.status = status
    this.examine = examine
    this.createTime = createTime
    this.delflag = delflag
  }

}
//通过不通过
export  class passRequestClass{
  vacationId:number=-1
  status:number=-1
  examine:number=-1
}