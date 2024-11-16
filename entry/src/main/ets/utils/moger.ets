export function moger<T>(dataset:T){//{a:1.b:2--->a=1&b=2}
  let arr:string[]=[]
  if(dataset instanceof Object){
    let keys=Reflect.ownKeys(dataset as object)as string[]
    for (let key of keys){
      arr.push(key + "=" + (dataset as object)[key])
    }
    return arr.join("&")
  }
  return ""
}