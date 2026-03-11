# 网络层

选型：允许并推荐 **Dio**、**dio_retrofit**、**chopper**；统一封装对外暴露接口，业务只依赖封装层。

## 4.1 统一封装与入口

1. **单例 Client**：全项目一个（或按域少数几个）网络 Client；禁止在 Page/Widget/Controller 内直接 `dio.get()`。
2. **抽象接口**：暴露 IApiClient 或 XxxApi 接口，内部实现可替换。
3. **强类型 API**：请求/响应用 Model/DTO；列表/分页用 PageResult<T>；推荐 Retrofit 风格（dio_retrofit/chopper）。

## 4.2 高可用

4. **超时与重试**：连接/读/写超时分开配置；重试可配置（次数、仅幂等、退避）；避免雪崩与无限重试。
5. **熔断与降级（可选）**：连续失败 N 次后短时不再请求或走缓存/默认数据；超时或 5xx 返回友好错误或缓存。
6. **取消与防抖**：CancelToken；列表/搜索防抖或节流；页面销毁时取消未完成请求。
7. **连接复用**：Keep-Alive、连接池；同一 BaseUrl 复用连接。
8. **缓存与离线**：可缓存 GET 做短期内存/磁盘缓存；无网时返回缓存或明确「离线」状态。

## 4.3 配置、安全与可观测

9. **配置集中**：BaseUrl、超时、重试、公共 Header、证书在单处配置；多环境切换；敏感配置不写死。
10. **安全**：全站 HTTPS；敏感信息不入日志；Token 刷新与 401 在拦截器统一处理；证书 Pinning 按需。
11. **错误统一**：ApiException、NetworkException、TimeoutException；服务端错误在拦截器/Mapper 转换，UI 只消费统一模型。
12. **可观测**：关键请求打点（URL 模板、耗时、状态码、是否重试）；日志开关与生产脱敏。

## 4.4 推荐依赖

- **Dio**：底层 Client（拦截器、CancelToken、超时、重试、FormData）。
- **dio_retrofit / chopper**：声明式 API、强类型、代码生成。
- **dio_smart_retry** 或自定义拦截器：带退避的重试、仅幂等重试。
- 业务层只依赖 IApiClient/XxxApi 与 DTO，不依赖 dio 包类型，便于 Mock 与替换。
