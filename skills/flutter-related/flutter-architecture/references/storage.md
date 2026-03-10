# 本地存储

1. **抽象接口**：定义 IKVStorage、IPersistentStorage 等；业务只依赖接口；实现可为 shared_preferences、Hive、Isar、SQLite，可替换。
2. **分层使用**：简单配置/开关用 KV；结构化、可查询用本地 DB；大对象或敏感数据考虑加密与压缩。
3. **生命周期**：存储实例单例或按模块注入；异步初始化（如 Hive.init）在 App 启动完成，不阻塞首帧。
4. **迁移与版本**：Schema 变更提供迁移方案（版本号 + 迁移脚本）；避免破坏性变更导致旧数据不可读。
5. **安全**：敏感数据（Token、密码）用 flutter_secure_storage 或等价方案；不把敏感信息写进普通 KV 或未加密 DB。
