import { loginDataClass, loginRequestClass } from '../models/login';
import { Request } from '../utils/request';

//登录的接口
export function Login(dataset:loginRequestClass){
  return Request.postRequest<loginRequestClass,loginDataClass>("user/login",dataset)
}