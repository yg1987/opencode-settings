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

## 修改约束

**任何涉及修改代码、配置、文件的请求，必须先向用户说明"要改什么、为什么改、怎么改"，等用户确认后才能动手。禁止擅自修改。**
