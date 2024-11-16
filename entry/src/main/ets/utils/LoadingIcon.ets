//
@Preview
@Component
struct LoadingIcon{
  @State progressVal:number=0
  aboutToAppear(){
    setInterval(()=>{
      if(this.progressVal==100){
        this.progressVal=0
      }else{
        this.progressVal++
      }
    },10)
  }
  build(){
    Progress({value:0,total:100,type:ProgressType.ScaleRing})
      .color(Color.Gray)
      .value(this.progressVal)
      .backgroundColor("#f0f0f0")
      .style({ strokeWidth: 5, scaleCount: 15, scaleWidth: 2 })
      .width(20)
  }


}

export {LoadingIcon}

