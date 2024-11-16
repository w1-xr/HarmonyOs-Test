import { http } from '@kit.NetworkKit'
import { BASE_URL } from '../constants'
import { ResponseClass } from '../models'
import { promptAction } from '@kit.ArkUI'
import { moger } from './moger'

//创建HTTP请求
//1.创建
const httpRequest=http.createHttp()
//2.总的get和post
//2.1定义函数
async function requestFn<V,T>(url:string,method:http.RequestMethod,dataset?:V):Promise<T>{
  let requestUrl=BASE_URL+url
  //get
  if (method==http.RequestMethod.GET && dataset &&JSON.stringify(dataset)!="{}") {
    requestUrl += "?" + moger<V>(dataset)
  }

  //post
    let config:http.HttpRequestOptions={
      header:{
        "Content-Type":"application/json"
      },
      method:method
    }
   /* if (method==http.RequestMethod.POST && dataset && JSON.stringify(dataset)!="{}"){
      config.extraData=dataset
    }*/
  if (method==http.RequestMethod.POST && dataset){
    if (typeof dataset=="number"){
      requestUrl+="/"+dataset
    }else if(typeof dataset=="object" && JSON.stringify(dataset)!="{}"){
      config.extraData=dataset
    }
  }
    //2.2成功了做什莫，失败了做什莫
    try {
      let res=await httpRequest.request(requestUrl,config)
      let result=res.result as string
      let rRes=JSON.parse(result) as ResponseClass<T>
      if (rRes.code==200){
        // promptAction.showToast({
        //   message:rRes.msg
        // })
        return rRes.dataset as T
      }else {
        promptAction.showToast({
          message:rRes.msg
        })
        return Promise.reject(new Error(rRes.msg))
      }
    }catch (e){
      promptAction.showToast({
        message:"请求失败，请重试"
      })
      return Promise.reject(new Error(e))
    }
  }

  //3.分的get post
export class Request {
  static getRequest<V, T>(url: string, dataset?: V): Promise<T> {
    return requestFn<V,T>(url, http.RequestMethod.GET, dataset)
  }
  static postRequest<V,T>(url:string,dataset?:V):Promise<T>{
  return requestFn<V,T>(url,http.RequestMethod.POST,dataset)

}
}


