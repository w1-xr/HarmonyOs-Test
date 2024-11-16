export  * from "./login"
export  * from "./classManagement"
export  * from "./daily"
export  * from "./user"
export  * from "./stuDA"
export  * from "./rz"
export  * from "./project"
//返回函数的类型
export  class ResponseClass<T>{
  code:number=-1
  msg:string=""
  dataset?:T
}