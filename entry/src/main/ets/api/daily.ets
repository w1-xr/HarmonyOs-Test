import {
  addrcRequestClass,
  dailyCCDataClass,
  dailyCCListClass,
  dailyCCRequestClass, dailyDataClass,
  dailyKQDataClass,
  dailyKQRequestClass,
  dailyListClass,
  dailyQJDataClass,
  dailyQJListClass,
  dailyQJRequestClass, dailyRequestClass } from '../models';
import { Request } from '../utils/request';
//日常
export function Daily(dataset:dailyRequestClass){
  return Request.postRequest<dailyRequestClass,dailyDataClass>("daily/dailyList",dataset)
}
//出差
export function DailyCC(dataset:dailyCCRequestClass){
  return Request.postRequest<dailyCCRequestClass,dailyCCDataClass>("business/businessList",dataset)
}
//插入出差
export function addcc(dataset:dailyCCListClass){
  return Request.postRequest<dailyCCListClass,void>("business/insertBusiness",dataset)
}
//请假
export function DailyQJ(dataset:dailyQJRequestClass){
  return Request.postRequest<dailyQJRequestClass,dailyQJDataClass>("vacation/vacationList",dataset)
}
//考勤
export function DailyKQ(dataset:dailyKQRequestClass){
  return Request.postRequest<dailyKQRequestClass,dailyKQDataClass>("count/countList",dataset)
}
//插入日常
export function addrc(dataset:dailyListClass){
  return Request.postRequest<dailyListClass,void>("daily/insertDaily",dataset)
}

//插入请假
export function addQJ(dataset:dailyQJListClass){
  return Request.postRequest<dailyQJListClass,void>("vacation/insertVacation",dataset)
}