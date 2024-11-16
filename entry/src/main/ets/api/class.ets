//class正文
import {
  addRequestClass,
  classDataClass, classRequestClass, detailDataClass, detailRequestClass,
  EditRequestClass } from '../models/classManagement'
import { Request } from '../utils/request'

export function Class(dataset:classRequestClass){
  return Request.postRequest<classRequestClass,classDataClass>("clazz/clazzList",dataset)
}
//class详情
export function classDetail(dataset:detailRequestClass){
  return Request.postRequest<detailRequestClass,detailDataClass>("clazz/clazzStudents",dataset)
}

//class修改
export function EditClass(dataset:EditRequestClass){
  return Request.postRequest<EditRequestClass,void>("clazz/updateClazz",dataset)
}
//class添加
export function AddClass(dataset:addRequestClass){
  return Request.postRequest<addRequestClass,void>("clazz/addClazz",dataset)
}