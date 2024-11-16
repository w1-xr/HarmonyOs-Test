//用户的接口
import {  deptDataClass, editUserRequestClass, userDataClass } from '../models/user'
import { userRequestClass } from '../models/user'
import { Request } from '../utils/request'

export function User(dataset:userRequestClass){
  return Request.postRequest<userRequestClass,userDataClass>("user/userList",dataset)
}

//添加用户接口
export function addUser(dataset:editUserRequestClass){
  return Request.postRequest<editUserRequestClass,void>("user/insertUser",dataset)
}
//部门接口
export function Dept(){
  return Request.postRequest<void,deptDataClass[]>("dept/deptList")
}
//修改用户接口
export function Edit(dataset:editUserRequestClass){
  return Request.postRequest<editUserRequestClass,void>("user/updateUser",dataset)
}
//删除用户
export function Delete(dataset:number){
  return Request.postRequest<number,void>("user/deleteUser",dataset)
}