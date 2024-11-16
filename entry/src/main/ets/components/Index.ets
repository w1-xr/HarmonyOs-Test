import { Class } from '../api'
import { classDataClass, classListClass, classRequestClass, silderDataClass, twoClass } from '../models'
import { classNavBar } from './classManagement'
import { dailyNavBar } from './daily'
import { dailyCCNavBar } from './dailyCC'
import { dailyKQNavBar } from './dailyKQ'
import { dailyQJNavBar } from './dailyQJ'
import { PFather } from './PFather'
import { rightTopone } from './rigthTopone'
import { RZNavBar } from './RZ'
import { shenheNavBar } from './shenhe'
import { stuDANavBar } from './stuDA'
import { UserNavBar } from './User'

@Extend(Text) function textglo(){
  .margin({left:15})
}
@Component
struct IndexNavBar{
  @Prop silderData:silderDataClass[]
  @State curIndex:number=0
  @State curIndexTwo:number=-1
  @State fon:number=0
  @State vib:Visibility=Visibility.None
  build() {
     Row(){
       //侧边栏
       Column(){
          ForEach(this.silderData,(item:silderDataClass,index:number)=>{
            Column(){
              Row(){
                Image(this.curIndex==index?item.selectedicon:item.icon)
                  .width(20)
                Text(item.title)
                  .textglo()
                  .fontColor(this.curIndex==index?"#0f6ab3":Color.Black)
                  .fontSize(this.curIndex==index?23:20)
                Image(this.curIndex==1?item.icon3:item.icon2)
                  .width(13)
                  .margin({left:-15})
              }
             .border({
               width:{
                 right:this.curIndex==index?4:0
               },
               color:"#0f6ab1"
             })
              .justifyContent(FlexAlign.Center)
              .width("100%")
              .height(50)
              .backgroundColor(this.curIndex==index?"#e7f0f7":Color.White)
              .onClick(()=>{
                this.curIndex=index
                if (this.curIndex==1){
                  this.vib=this.vib==Visibility.None?Visibility.Visible:Visibility.None
                  if (this.vib==Visibility.None){
                    this.curIndexTwo=-1
                  }
                }else {
                  this.vib=Visibility.None
                  this.curIndexTwo=-1
                }
              })
              //二级
              ForEach(item.two,(item2:twoClass,index:number)=>{
                Column(){
                  Text(item2.title)
                    .height(35)
                    .fontSize(18)
                    .fontColor(this.curIndexTwo==index?"#0f6ab3":Color.Black)
                    .onClick(()=>{
                      this.curIndexTwo=index
                    })
                }
                .visibility(this.vib)
              })
            }

          })
       }
       .width("18%")
       .height("100%")
       //右边
       Column(){
         if(this.curIndex==0) {
           //班级管理
           classNavBar({
             curIndex: this.curIndex,
           })
         }
         if(this.curIndex==1) {
           //日常
           dailyNavBar({
             curIndex: this.curIndex,
             curIndextwo: this.curIndexTwo
           })
         }
         if(this.curIndex==1 &&this.curIndexTwo==0) {
           //日常-出差记录
           dailyCCNavBar({
             curIndex: this.curIndex,
             curIndextwo: this.curIndexTwo
           })
         }
         if(this.curIndex==1 &&this.curIndexTwo==1) {
           //日常-请假记录
           dailyQJNavBar({
             curIndex: this.curIndex,
             curIndextwo: this.curIndexTwo
           })
         }
         
         if(this.curIndex==1 &&this.curIndexTwo==2) {
           //日常-考勤记录
           dailyKQNavBar({
             curIndex: this.curIndex,
             curIndextwo: this.curIndexTwo
           })
         }
         if(this.curIndex==2) {
           //用户管理
           UserNavBar({
             curIndex: this.curIndex,
           })
         }
         if(this.curIndex==3) {
           //学生档案
           stuDANavBar({
             curIndex: this.curIndex
           })
         }
         if(this.curIndex==4){
           //日志系统
           RZNavBar({
             curIndex:this.curIndex
           })
         }
         if(this.curIndex==5) {
           //审核系统
           shenheNavBar({
             curIndex: this.curIndex
           })
         }
         //项目管理
         if (this.curIndex==6){
           PFather({
             curIndex:this.curIndex
           })
         }
       }
      .layoutWeight(1)
     }
     .position({top:80})
     .height("calc(100% - 80vp)")
     .width("100%")
  }
}
export {IndexNavBar}