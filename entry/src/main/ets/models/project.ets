//项目列表  project/projectList
export class  FatherListRequestClass{
  projectName?:string=""
  startTime?:string=""
  endTime?:string=""
  pageIndex:number=-1
  pageSize:number=8
}
export class  FatherListDataClass{
  constructor(pageCount: number, projectList: projectListClass[]) {
    this.pageCount = pageCount
    this.projectList = projectList
  }
   pageCount:number
   projectList:projectListClass[]=[]
}
export class  projectListClass{
  projectId:number
  projectName:string

  constructor(projectId: number, projectName: string, projectLeader: string, workingHours: number, startDate: string,
    endDate: string, progress: number) {
    this.projectId = projectId
    this.projectName = projectName
    this.projectLeader = projectLeader
    this.workingHours = workingHours
    this.startDate = startDate
    this.endDate = endDate
    this.progress = progress
  }
  projectLeader:string
  workingHours:number
  startDate:string
  endDate:string
  progress:number
}

//添加项目  project/insertProject
export class addFatherRequestClass{
  projectName:string=""
  projectLeader:number=-1
  workingHours:number=-1
  startDate:string=""
  endDate:string=""
}
//子项目列表  child/childList
export class childRequestClass{
  childProjectName:string=""
  pageIndex:number=-1
  pageSize:number=-1
  projectId:number=-1
}
export class childDataClass{
  constructor(pageCount: number, childList: childListClass[]) {
    this.pageCount = pageCount
    this.childList = childList
  }
 pageCount:number
  childList:childListClass[]=[]
}
export class childListClass{
  childProjectId:number
  childProjectLeader:number
  workingHours:number

  constructor(childProjectId: number, childProjectLeader: number, workingHours: number, progress: number,
    delflag: number, prop: number, projectId: number, childProjectName: string, startDate: string, endDate: string,
    createTime: string) {
    this.childProjectId = childProjectId
    this.childProjectLeader = childProjectLeader
    this.workingHours = workingHours
    this.progress = progress
    this.delflag = delflag
    this.prop = prop
    this.projectId = projectId
    this.childProjectName = childProjectName
    this.startDate = startDate
    this.endDate = endDate
    this.createTime = createTime
  }
  progress:number
  delflag:number
  prop:number
  projectId:number
  childProjectName:string
  startDate:string
  endDate:string
  createTime:string
}
//添加子项目  child/insertChild
export class addChildRequestClass{
  childProjectName:string=""
  startDate:string=""
  endDate:string=""
  childProjectLeader:number=-1
  workingHours:number=-1
  prop:number=-1
  projectId:number=-1
}
//修改子项目  child/updateChild
export class editChildRequestClass{
  childProjectLeader:number=-1
  childProjectId:number=-1
  prop:number=-1
  projectId:number=-1
  childProjectName?:string=""
  startDate?:string=""
  endDate?:string=""
  workingHours?:number=-1
}
//子项目详情  child/childInfo/{projectChildId}
//任务详情  task/taskInfo
export class TaskDetailRequestClass{
  pageIndex:number=-1
  pageSize:number=-1
  taskId:number=-1
}
//任务列表  task/taskList
export class  TaskListRequestClass{
  projectChildId:number=-1
  taskName?:string=""
  startTime?:string=""
  endTime?:string=""
  pageIndex?:number=-1
  pageSize?:number=8
  userId?:number=-1
}
export class  TaskListDataClass{
  constructor(pageCount: number, taskList: editTaskRequestClass[]) {
    this.pageCount = pageCount
    this.taskList = taskList
  }
  pageCount:number
  taskList:editTaskRequestClass[]=[]
}
//修改任务  task/updateTask
export class  editTaskRequestClass{
  projectChildId:number=-1
  taskLeader:number=-1
  progress:number=-1
  prop:number=8
  projectId:number=-1
  taskId:number=-1
  taskName?:string=""
  workingHours?:number=-1
  startDate?:string=""
  endDate?:string=""
}
//删除任务  task/deleteTask/{taskId}
//添加项目组成员  projector/insertProjector
export class addmemberRequestClass{
  userId:number=-1
  projectId:number=-1
}
//添加项目组成员列表/项目负责人列表  projector/addProjectUserList
export class LeaderDataClass{
  userId:number=-1
  userName:string=""
}
//项目组成员列表  projector/projectorList
export class memberRequestClass{
  projectId:number=-1
}
export class memberDataClass{
  userId:string=""
  userPhone:string=""
  status:string=""
}
//子项目/子任务负责人下拉框 projector/childProject
export class childLeaderRequestClass{
  projectId:number=-1
}
export class childLeaderDataClass{
  id:number=-1
  userId:string=""
}
