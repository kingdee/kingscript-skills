# createPlanAndDispatchJob - 动态创建作业并生成计划

## 场景

用户在业务页面点一个按钮，希望系统立刻为当前业务生成一个后台作业，并顺手创建一个只执行一次的调度计划，而不是提前在调度中心手工维护固定计划。

## Java 来源

- `kd.bos.plugin.sample.schedule.CreateJobPlanPlugIn`

## 适用入口

- `registerListener(e: $.java.util.EventObject): void`
- `itemClick(e: ItemClickEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { ItemClickEvent } from "@cosmic/bos-core/kd/bos/form/control/events";
import {
  JobInfo,
  JobType,
  PlanInfo
} from "@cosmic/bos-core/kd/bos/schedule/api";
import { JobDispatcherProxy } from "@cosmic/bos-core/kd/bos/schedule/server";
import { Calendar, HashMap } from "@cosmic/bos-script/java/util";
import { SimpleDateFormat } from "@cosmic/bos-script/java/text";
import { LocaleString } from "@cosmic/bos-core/kd/bos/dataentity/entity";

class CreatePlanAndDispatchJobPlugin extends AbstractFormPlugin {

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);
    this.addItemClickListeners("tbmain");
  }

  itemClick(e: ItemClickEvent): void {
    super.itemClick(e);

    if (e.getItemKey() !== "kdtest_createplan") {
      return;
    }

    let dispatcher = new JobDispatcherProxy();
    let jobInfo = this.buildJobInfo();
    dispatcher.dispatch(jobInfo);

    let planInfo = this.buildPlanInfo(jobInfo);
    dispatcher.createPlan(planInfo);

    this.getView().showMessage("已创建作业和调度计划：" + planInfo.getlName());
  }

  private buildJobInfo(): JobInfo {
    let now = new Date();
    let formatter = new SimpleDateFormat("yyyyMMdd_HHmmss");
    let suffix = formatter.format(now);

    let jobInfo = new JobInfo();
    jobInfo.setAppId("bos");
    jobInfo.setJobType(JobType.BIZ);
    jobInfo.setlName(new LocaleString("页面触发作业_" + suffix));
    jobInfo.setNumber("kdf_job_dynamic_" + suffix);
    jobInfo.setTaskClassname("kd.bos.plugin.sample.schedule.KDFLogTask");

    let params = new HashMap();
    params.put("time", 10);
    jobInfo.setParams(params);
    return jobInfo;
  }

  private buildPlanInfo(jobInfo: JobInfo): PlanInfo {
    let now = new Date();
    let formatter = new SimpleDateFormat("yyyyMMdd_HHmmss");
    let suffix = formatter.format(now);

    let startTime = Calendar.getInstance();
    startTime.setTime(new Date(now.getTime() + 60 * 1000));

    let endTime = Calendar.getInstance();
    endTime.setTime(new Date(now.getTime() + 5 * 60 * 1000));

    let planInfo = new PlanInfo();
    planInfo.setJobId(jobInfo.getId());
    planInfo.setlName(new LocaleString("页面触发计划_" + suffix));
    planInfo.setNumber("kdf_plan_dynamic_" + suffix);
    planInfo.setStartTime(startTime);
    planInfo.setEndTime(endTime);
    planInfo.setCronExpression("0 0 0 * * ?");
    return planInfo;
  }
}

let plugin = new CreatePlanAndDispatchJobPlugin();
export { plugin };
```

## 映射说明

- Java 样例是一个典型“页面侧发起调度”的模式：监听工具栏点击，先 `dispatch(jobInfo)`，再 `createPlan(planInfo)`。这里完整保留了这个顺序。
- `getJobInfo` 和 `getPlanInfo` 在 Java 中是两个私有方法，这里改成 `buildJobInfo`、`buildPlanInfo`，便于看清“作业定义”和“计划时间窗”是两层对象。
- 样例里的计划是一次性计划，所以正文里保留了开始时间、结束时间和 cron。Java 样例还额外调用了 `setRepeatMode(NONE)`，如果你当前项目的声明里能直接拿到 `RepeatModeEnum`，建议一起补上。

## 注意事项

- 先派发作业再创建计划，否则 `PlanInfo` 没有可用的 `jobId`。
- 页面触发调度时，作业编号和计划编号最好加时间戳，避免重复。
- 这里示例的是一次性计划；如果当前项目声明里能直接导入 `RepeatModeEnum`，建议像 Java 样例一样显式设置 `NONE`，再配合 cron 使用。
- 如果你要做周期计划，再单独扩展重复模式和 cron，不要把周期逻辑和一次性场景混写在一起。
