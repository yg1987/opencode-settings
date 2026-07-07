# 全局指令

## 分析流程规范

**只要用户的请求涉及分析、了解、探索项目（包括但不限于"帮我看看这个项目""分析下项目""梳理项目结构"等笼统表述），一律先用 codegraph（而非手工遍历）**。不要自行判断"这个简单不用 codegraph"。

以下场景同样必须先用 codegraph：
- 架构分析、模块结构分析
- 调用链追踪（callers / callees / explore）
- 影响范围分析（impact）
- 查找符号定义或引用（query / node）
- 分析路由端点
- 统计代码量、类/接口/方法数量
- 查找测试覆盖盲区
- 理解项目之前的迭代历史、遗留的派生项目（如 sandbox / 旧工程 / .analysis 等）

标准步骤：
1. `codegraph status` — 确认索引状态
2. 如果返回 `Not initialized`，**立即执行 `codegraph init && codegraph index`**，不要跳过，不要用手工代替
3. `codegraph explore <关键类>` — 获取符号源 + 调用路径
4. `codegraph impact <符号>` — 分析改动影响范围（如果需要）
5. `codegraph query <关键词>` — 搜索符号
6. `codegraph callers/callees <符号>` — 调用关系
7. 最后才用 Read/Grep 补充细节

## /learn-codebase 执行规范

`/learn-codebase` 或任何"学习代码库""了解项目""阅读源码"的请求，同样优先使用 codegraph 而非逐文件遍历：

1. `codegraph status` → 如未初始化则 `codegraph init && codegraph index`
2. `codegraph explore <项目>` → 获取模块架构、路由、关键类
3. `codegraph callers/callees <关键方法>` → 调用链
4. `codegraph query <业务关键词>` → 定位所有相关符号（类、方法、路由）
5. 补读 codegraph 覆盖不了的业务逻辑文件（设计意图、配置含义、已知风险等）
6. 写记忆文件

**Why**: codegraph 索引（精确到每个方法/字段/路由的节点和边）比手工读文件更完整、更准确、更快。纯手工遍历容易遗漏或记错，且与"分析流程规范"割裂。

**注意**: codegraph 是静态分析，无法表达设计意图和已知风险（如"7 天静默期是留修正窗口"），所以需要少量手工阅读补全业务上下文。

## 修改约束

**任何涉及修改代码、配置、文件的请求，必须先向用户说明"要改什么、为什么改、怎么改"，等用户确认后才能动手。禁止擅自修改。**
