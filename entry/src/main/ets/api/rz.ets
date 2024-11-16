import { addrzRequestClass, editrzRequestClass, rzDataClass, rzRequestClass } from '../models/rz'
import { Request } from '../utils/request'

export function rzz(dataset:rzRequestClass){
  return Request.postRequest<rzRequestClass,rzDataClass>("log/logList",dataset)
}
export function addRZ(dataset:addrzRequestClass){
  return Request.postRequest<addrzRequestClass,void>("log/insertLog",dataset)
}
export function editRZ(dataset:editrzRequestClass){
  return Request.postRequest<editrzRequestClass,void>("log/updateLog",dataset)
}
// //删除日志
export function delRZ(dataset:number){
  return Request.postRequest<number,void>("log/deleteLog",dataset)
}