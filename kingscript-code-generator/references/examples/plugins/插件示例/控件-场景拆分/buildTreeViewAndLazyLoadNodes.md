# buildTreeViewAndLazyLoadNodes - 构建树并按需懒加载节点

## 场景

页面需要先展示一个可勾选、可拖拽的树根节点，用户展开节点时再异步补子节点；点击、双击、勾选、拖拽这些交互还要能立即给出反馈，避免一次性把整棵树全部塞到前端。

## Java 来源

- `kd.bos.plugin.sample.dynamicform.pcform.control.bizcase.TreeViewSample`

这个 Java 样例把树控件常见的 4 类动作串成了一条完整链路：

- 页面绑定前初始化树根节点和交互属性
- 展开节点时按父节点 id 动态返回子节点
- 点击和勾选节点时读取树状态并提示
- 拖拽节点后根据目标父节点重组树结构

## 适用入口

- `registerListener(e: $.java.util.EventObject): void`
- `beforeBindData(e: $.java.util.EventObject): void`
- `queryTreeNodeChildren(e: TreeNodeEvent): void`
- `treeNodeClick(e: TreeNodeEvent): void`
- `treeNodeDoubleClick(e: TreeNodeEvent): void`
- `treeNodeCheck(e: TreeNodeCheckEvent): void`
- `treeNodeDragged(e: TreeNodeDragEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import {
  TreeNodeCheckEvent,
  TreeNodeDragEvent,
  TreeNodeEvent
} from "@cosmic/bos-core/kd/bos/form/control/events";
import { ArrayList } from "@cosmic/bos-script/java/util";

class BuildTreeViewAndLazyLoadNodesPlugin extends AbstractFormPlugin {

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    let tree = this.getView().getControl("treeviewap1") as any;
    tree.addTreeNodeQueryListener(this);
    tree.addTreeNodeClickListener(this);
    tree.addTreeNodeCheckListener(this);
    tree.addTreeNodeDragListener(this);
  }

  beforeBindData(e: $.java.util.EventObject): void {
    super.beforeBindData(e);

    let tree = this.getView().getControl("treeviewap1") as any;
    tree.setMulti(true);
    tree.setRootVisible(true);
    tree.setDraggable(true);
    tree.setDroppable(true);

    let rootNodes = new ArrayList();
    rootNodes.add(this.createNode("node1", "业务对象", ""));
    tree.addNodes(rootNodes);
    tree.expand("node1");
  }

  queryTreeNodeChildren(e: TreeNodeEvent): void {
    let parentId = e.getNodeId();
    if (parentId == null || parentId === "") {
      return;
    }

    let children = new ArrayList();
    children.add(this.createNode(parentId + ".1", "节点 " + parentId + ".1", parentId));
    children.add(this.createNode(parentId + ".2", "节点 " + parentId + ".2", parentId));
    e.setChildNodes(children);
  }

  treeNodeClick(e: TreeNodeEvent): void {
    let nodeId = e.getNodeId();
    if (nodeId != null) {
      this.getView().showTipNotification("当前节点：" + e.getNodeText());
    }
  }

  treeNodeDoubleClick(e: TreeNodeEvent): void {
    let nodeId = e.getNodeId();
    if (nodeId != null) {
      this.getView().showMessage("双击进入节点：" + nodeId);
    }
  }

  treeNodeCheck(e: TreeNodeCheckEvent): void {
    let tree = this.getView().getControl("treeviewap1") as any;
    let checkedNodeIds = tree.getTreeState().getCheckedNodeIds();

    if (checkedNodeIds == null || checkedNodeIds.size() === 0) {
      this.getView().showTipNotification("当前没有勾选任何节点。");
      return;
    }

    let ids: string[] = [];
    for (let i = 0; i < checkedNodeIds.size(); i++) {
      ids.push(String(checkedNodeIds.get(i)));
    }
    this.getView().showTipNotification("已勾选：" + ids.join(", "));
  }

  treeNodeDragged(e: TreeNodeDragEvent): void {
    let dragNodeId = e.getDragNodeId();
    let dropNodeId = e.getDropNodeId();

    if (dragNodeId == null || dropNodeId == null) {
      return;
    }

    this.getView().showTipNotification(
      "已将节点 " + dragNodeId + " 拖到 " + dropNodeId + " 下。"
    );
  }

  private createNode(nodeId: string, text: string, parentId: string): any {
    let node: any = {};
    node.id = nodeId;
    node.text = text;
    node.parentId = parentId;
    node.isParent = true;
    return node;
  }
}

let plugin = new BuildTreeViewAndLazyLoadNodesPlugin();
export { plugin };
```

## 映射说明

- Java 在 `beforeBindData` 里一次性打开多选、根节点显示、拖拽和放置能力，这里保持同样的初始化顺序，让树控件先具备可交互的基础状态。
- Java 的 `loadChildNode(nodeId)` 会按当前节点动态生成子节点，这里把它落成 `createNode` + `queryTreeNodeChildren`，强调“展开时再补子节点”的懒加载思路。
- Java 拖拽回调里会调整树结构；这里先保留对 `dragNodeId` 和 `dropNodeId` 的读取与反馈，把最常见的“拿到被拖节点和目标节点”这一步单独讲清楚。

## 注意事项

- 懒加载节点时要保证 `nodeId` 唯一，否则重复展开后很容易出现节点覆盖或重复渲染。
- 如果树上允许勾选，勾选状态通常应该从 `TreeState` 读取，而不是只依赖当前事件对象。
- 拖拽只改前端展示还不够，真正有层级语义的树通常还要把新的父子关系回写到模型或后台。
