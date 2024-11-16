import {
 addChildRequestClass,
 addFatherRequestClass,
 addmemberRequestClass,
 editTaskRequestClass,
 childDataClass,
 childLeaderDataClass,
 childLeaderRequestClass,
 childRequestClass,
 editChildRequestClass,
 FatherListDataClass, FatherListRequestClass, LeaderDataClass,
 memberDataClass,
 memberRequestClass,
 TaskDetailRequestClass,
 TaskListDataClass,
 TaskListRequestClass} from '../models'
import { Request } from '../utils/request'
//项目列表  project/projectList
export function Father(dataset:FatherListRequestClass){
 return Request.postRequest<FatherListRequestClass,FatherListDataClass>("project/projectList",dataset)
}
//添加项目  project/insertProject
export function addFather(dataset:addFatherRequestClass){
 return Request.postRequest<addFatherRequestClass,void>("project/insertProject",dataset)
}
//子项目列表  child/childList
export function Child(dataset:childRequestClass){
 return Request.postRequest<childRequestClass,childDataClass>("child/childList",dataset)
}
//添加子项目  child/insertChild
export function addChild(dataset:addChildRequestClass){
 return Request.postRequest<addChildRequestClass,void>("child/insertChild",dataset)
}
//修改子项目  child/updateChild
export function editChild(dataset:editChildRequestClass){
 return Request.postRequest<editChildRequestClass,void>("child/updateChild",dataset)
}
//子项目详情  child/childInfo/{projectChildId}
export function ChildDetail(dataset:number){
 return Request.postRequest<number,void>("child/childInfo",dataset)
}
//任务详情  task/taskInfo
// export function TaskDetail(dataset:TaskDetailRequestClass){
//  return Request.postRequest<TaskDetailRequestClass,>("task/taskInfo",dataset)
// }
//任务列表  task/taskList
export function Task(dataset:TaskListRequestClass){
 return Request.postRequest<TaskListRequestClass,TaskListDataClass>("task/taskList",dataset)
}
//添加任务  task/insertTask
export function addTask(dataset:editTaskRequestClass){
 return Request.postRequest<editTaskRequestClass,void>("task/insertTask",dataset)
}
//修改任务  task/updateTask
export function editTask(dataset:editTaskRequestClass){
 return Request.postRequest<editTaskRequestClass,void>("task/updateTask",dataset)
}
//删除任务  task/deleteTask/{taskId}
export function delTask(dataset:number){
 return Request.postRequest<number,void>("task/deleteTask",dataset)
}
//添加项目组成员  projector/insertProjector
export function addmember(dataset:addmemberRequestClass[]){
 return Request.postRequest<addmemberRequestClass[],void >("projector/insertProjector",dataset)
}
//添加项目组成员列表/项目负责人列表  projector/addProjectUserList
export function Leader(){
 return Request.postRequest<void,LeaderDataClass[]>("projector/addProjectUserList")
}
//项目组成员列表  projector/projectorList
export function Member(dataset:memberRequestClass){
 return Request.postRequest<memberRequestClass,memberDataClass[]>("projector/projectorList",dataset)
}
//子项目/子任务负责人下拉框 projector/childProject
export function childLeader(dataset:childLeaderRequestClass){
 return Request.postRequest<childLeaderRequestClass,childLeaderDataClass[]>("projector/childProject",dataset)
}