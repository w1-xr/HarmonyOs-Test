export  class DateUtils{
  //相差天数
  static getDays(start:string,end:string){
    if (start!="" && end!=""){
      return Math.ceil((Date.parse(end)-Date.parse(start))/1000/60/60/24)
    }else {return 0}

    //日期格式
  }
  static padStart(date:string){
    return date.split("/").map(date=>date.padStart(2,"0")).join("-")
  }
}