import { passRequestClass, shenheDataClass } from '../models/shenhe'
import { Request } from '../utils/request'

export  function shenHe(){
  return Request.postRequest<void,shenheDataClass>("audit/auditList")
}
//通过不通过
export function pass(dataset:passRequestClass){
  return Request.postRequest<passRequestClass,void>("audit/auditActions",dataset)
}