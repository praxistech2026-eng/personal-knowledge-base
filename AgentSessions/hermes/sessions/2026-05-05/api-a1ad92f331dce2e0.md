---
title: Session api-a1ad
date: 2026-05-06
agent: hermes
session_id: api-a1ad92f331dce2e0
model: MiniMax-M2.7
platform: api_server
archived_at: 2026-05-06T20:10:32.894288
type: agent-session
---

# Agent Session: hermes

**Session ID:** `api-a1ad92f331dce2e0`

### [] user

hello

### [] assistant

你好！有什么可以帮你的？

### [] user

你现在用的什么模型

### [] assistant

当前使用 **MiniMax-M2.7** 模型，通过 `minimax-cn` 提供商运行。

### [] user

我怎么切换模型

### [] assistant

你可以通过以下方式切换模型：

**方法 1：配置文件中修改**
在 `config.yaml` 中设置 `model` 和 `provider`：
```yaml
model: your-model-name
provider: your-provider
```

**方法 2：运行时命令**
如果有 `model` 命令可用，直接在对话中切换（部分系统支持）。

**方法 3：环境变量**
设置 `HERMES_MODEL` 和 `HERMES_PROVIDER` 环境变量。

---

如果你告诉我你当前使用的平台或设置，我可以给出更具体的步骤。当前我的配置是：
- **模型**：MiniMax-M2.7
- **提供商**：minimax-cn

你想切换到哪个模型？

### [] user

你有哪些模型可以用

### [] assistant



### [] tool

{"total_count": 0}

### [] tool

{"output": "auth.json\nauth.lock\nbin\ncache\nchannel_directory.json\ncheckpoints\nconfig.yaml\ncron\nfeishu_seen_message_ids.json\ngateway.pid\ngateway_state.json\nhermes-agent\ninterrupt_debug.log\nlogs\nmemories\nmigration\nmodels_dev_cache.json\nollama_cloud_models_cache.json\npastes\nplatforms\nplugins\nprocesses.json\nresponse_store.db\nresponse_store.db-shm\nresponse_store.db-wal\nsandboxes\nsessions\nskills\nSOUL.md\nstate.db\nstate.db-shm\nstate.db-wal\nwebui\nweixin", "exit_code": 0, "error": null}

### [] assistant



### [] tool

{"content": "     1|model:\n     2|  default: MiniMax-M2.7\n     3|  provider: minimax-cn\n     4|providers: {}\n     5|credential_pool_strategies: {}\n     6|fallback_model:\n     7|  provider: openai-codex\n     8|  model: gpt-5.4-mini\n     9|toolsets:\n    10|- hermes-cli\n    11|agent:\n    12|  max_turns: 90\n    13|  gateway_timeout: 1800\n    14|  restart_drain_timeout: 60\n    15|  service_tier: ''\n    16|  tool_use_enforcement: auto\n    17|  gateway_timeout_warning: 900\n    18|  gateway_notify_interval: 600\n    19|terminal:\n    20|  backend: local\n    21|  modal_mode: auto\n    22|  cwd: .\n    23|  timeout: 180\n    24|  env_passthrough: []\n    25|  docker_image: nikolaik/python-nodejs:python3.11-nodejs20\n    26|  docker_forward_env: []\n    27|  docker_env: {}\n    28|  singularity_image: docker://nikolaik/python-nodejs:python3.11-nodejs20\n    29|  modal_image: nikolaik/python-nodejs:python3.11-nodejs20\n    30|  daytona_image: nikolaik/python-nodejs:python3.11-nodejs20\n    31|  container_cpu: 1\n    32|  container_memory: 5120\n    33|  container_disk: 51200\n    34|  container_persistent: true\n    35|  docker_volumes: []\n    36|  docker_mount_cwd_to_workspace: false\n    37|  persistent_shell: true\n    38|browser:\n    39|  inactivity_timeout: 120\n    40|  command_timeout: 30\n    41|  record_sessions: false\n    42|  allow_private_urls: false\n    43|  camofox:\n    44|    managed_persistence: false\n    45|checkpoints:\n    46|  enabled: true\n    47|  max_snapshots: 50\n    48|file_read_max_chars: 100000\n    49|compression:\n    50|  enabled: true\n    51|  threshold: 0.5\n    52|  target_ratio: 0.2\n    53|  protect_last_n: 20\n    54|bedrock:\n    55|  region: ''\n    56|  discovery:\n    57|    enabled: true\n    58|    provider_filter: []\n    59|    refresh_interval: 3600\n    60|  guardrail:\n    61|    guardrail_identifier: ''\n    62|    guardrail_version: ''\n    63|    stream_processing_mode: async\n    64|    trace: disabled\n    65|smart_model_routing:\n    66|  enabled: false\n    67|  max_simple_chars: 160\n    68|  max_simple_words: 28\n    69|  cheap_model: {}\n    70|auxiliary:\n    71|  vision:\n    72|    provider: auto\n    73|    model: ''\n    74|    base_url: ''\n    75|    api_key: ''\n    76|    timeout: 120\n    77|    download_timeout: 30\n    78|  web_extract:\n    79|    provider: auto\n    80|    model: ''\n    81|    base_url: ''\n    82|    api_key: ''\n    83|    timeout: 360\n    84|  compression:\n    85|    provider: auto\n    86|    model: ''\n    87|    base_url: ''\n    88|    api_key: ''\n    89|    timeout: 120\n    90|  session_search:\n    91|    provider: auto\n    92|    model: ''\n    93|    base_url: ''\n    94|    api_key: ''\n    95|    timeout: 30\n    96|  skills_hub:\n    97|    provider: auto\n    98|    model: ''\n    99|    base_url: ''\n   100|    api_key: ''\n   101|    timeout: 30\n   102|  approval:\n   103|    provider: auto\n   104|    model: ''\n   105|    base_url: ''\n   106|    api_key: ''\n   107|    timeout: 30\n   108|  mcp:\n   109|    provider: auto\n   110|    model: ''\n   111|    base_url: ''\n   112|    api_key: ''\n   113|    timeout: 30\n   114|  flush_memories:\n   115|    provider: auto\n   116|    model: ''\n   117|    base_url: ''\n   118|    api_key: ''\n   119|    timeout: 30\n   120|display:\n   121|  compact: false\n   122|  personality: kawaii\n   123|  resume_display: full\n   124|  busy_input_mode: interrupt\n   125|  bell_on_complete: false\n   126|  show_reasoning: false\n   127|  streaming: false\n   128|  inline_diffs: true\n   129|  show_cost: false\n   130|  skin: default\n   131|  interim_assistant_messages: true\n   132|  tool_progress_command: false\n   133|  tool_progress_overrides: {}\n   134|  tool_preview_length: 0\n   135|  platforms: {}\n   136|dashboard:\n   137|  theme: default\n   138|privacy:\n   139|  redact_pii: false\n   140|tts:\n   141|  provider: edge\n   142|  edge:\n   143|    voice: en-US-AriaNeural\n   144|  elevenlabs:\n   145|    voice_id: pNInz6obpgDQGcFmaJgB\n   146|    model_id: eleven_multilingual_v2\n   147|  openai:\n   148|    model: gpt-4o-mini-tts\n   149|    voice: alloy\n   150|  xai:\n   151|    voice_id: eve\n   152|    language: en\n   153|    sample_rate: 24000\n   154|    bit_rate: 128000\n   155|  mistral:\n   156|    model: voxtral-mini-tts-2603\n   157|    voice_id: c69964a6-ab8b-4f8a-9465-ec0925096ec8\n   158|  neutts:\n   159|    ref_audio: ''\n   160|    ref_text: ''\n   161|    model: neuphonic/neutts-air-q4-gguf\n   162|    device: cpu\n   163|stt:\n   164|  enabled: true\n   165|  provider: local\n   166|  local:\n   167|    model: base\n   168|    language: ''\n   169|  openai:\n   170|    model: whisper-1\n   171|  mistral:\n   172|    model: voxtral-mini-latest\n   173|voice:\n   174|  record_key: ctrl+b\n   175|  max_recording_seconds: 120\n   176|  auto_tts: false\n   177|  silence_threshold: 200\n   178|  silence_duration: 3.0\n   179|human_delay:\n   180|  mode: 'off'\n   181|  min_ms: 800\n   182|  max_ms: 2500\n   183|context:\n   184|  engine: compressor\n   185|memory:\n   186|  memory_enabled: true\n   187|  user_profile_enabled: true\n   188|  memory_char_limit: 2200\n   189|  user_char_limit: 1375\n   190|  provider: ''\n   191|delegation:\n   192|  model: gpt-5.4\n   193|  provider: openai-codex\n   194|  base_url: ''\n   195|  api_key: ''\n   196|  max_iterations: 50\n   197|  reasoning_effort: ''\n   198|prefill_messages_file: ''\n   199|skills:\n   200|  external_dirs: []\n   201|honcho: {}\n   202|timezone: ''\n   203|discord:\n   204|  require_mention: true\n   205|  free_response_channels: ''\n   206|  allowed_channels: ''\n   207|  auto_thread: true\n   208|  reactions: true\n   209|  channel_prompts: {}\n   210|whatsapp: {}\n   211|telegram:\n   212|  channel_prompts: {}\n   213|slack:\n   214|  channel_prompts: {}\n   215|mattermost:\n   216|  channel_prompts: {}\n   217|approvals:\n   218|  mode: manual\n   219|  timeout: 60\n   220|command_allowlist: []\n   221|quick_commands: {}\n   222|personalities: {}\n   223|security:\n   224|  redact_secrets: true\n   225|  tirith_enabled: true\n   226|  tirith_path: tirith\n   227|  tirith_timeout: 5\n   228|  tirith_fail_open: true\n   229|  website_blocklist:\n   230|    enabled: false\n   231|    domains: []\n   232|    shared_files: []\n   233|cron:\n   234|  wrap_response: true\n   235|logging:\n   236|  level: INFO\n   237|  max_size_mb: 5\n   238|  backup_count: 3\n   239|network:\n   240|  force_ipv4: false\n   241|_config_version: 18\n   242|system_prompt: |\n   243|  你是一个多模型调度系统（Hermes），负责任务编排、质量控制与长期沉淀把关。\n   244|\n   245|  【核心角色定位】\n   246|\n   247|  1. Hermes 是决策层，不是执行层。\n   248|  2. OpenClaw 是执行层，负责具体动作、skills、工具调用与工作流执行。\n   249|  3. GPT 只作为高阶子代理使用，负责裁决、诊断、定稿与沉淀审查。\n   250|  4. 默认情况下，主线程始终优先使用低成本模型（MiniMax）处理任务。\n   251|\n   252|  【强制模型路由规则】\n   253|\n   254|  默认使用 MiniMax 处理任务，不要主动把主线程切换到 GPT。\n   255|\n   256|  当满足以下任一条件时，必须通过 delegation 调用高阶子代理，不得省略、不得仅凭主线程直接作答：\n   257|\n   258|  - 高价值方案设计\n   259|  - 多结果冲突，且需要明确裁决\n   260|  - 连续失败 >= 2 次\n   261|  - 需要判断失败根因（工具问题 / 网络问题 / 目标限制 / 任务设计问题）\n   262|  - 当前结果将写入 memory / skill / workflow / 长期规则\n   263|  - 最终输出将直接面向用户、客户、审批、正式文档或关键决策\n   264|  - 存在高风险动作（删除、覆盖、发布、外部副作用、权限相关）\n   265|  - 任务需要抽象总结、长期规则提炼、经验沉淀审查\n   266|\n   267|  【高阶子代理（delegation）的职责】\n   268|\n   269|  delegation 子代理默认使用 GPT-5.4，只负责以下事项：\n   270|\n   271|  - 裁决冲突结果\n   272|  - 诊断失败原因\n   273|  - 判断是否终止、返工或继续\n   274|  - 审核和定稿\n   275|  - 审核 memory / skill / workflow 的沉淀内容\n   276|  - 提炼高价值规则与长期经验\n   277|\n   278|  delegation 子代理不得承担以下职责：\n   279|\n   280|  - 大规模资料搜集\n   281|  - 重复执行机械步骤\n   282|  - 常规工具调用\n   283|  - 普通格式改写\n   284|  - 在没有触发条件时替代主线程完成整个任务\n   285|\n   286|  【普通任务处理规则】\n   287|\n   288|  如果任务属于以下类型，则不得调用高阶子代理，应由默认低成本模型直接处理：\n   289|\n   290|  - 简单总结\n   291|  - 格式整理\n   292|  - 普通改写\n   293|  - 常规信息抽取\n   294|  - 明确模板内的重复执行\n   295|  - 已有固定修复路径的错误处理\n   296|  - 常规 if/else 路由判断\n   297|\n   298|  【失败与升级规则】\n   299|\n   300|  1. 同一任务连续失败 1 次时，优先调整策略，不升级 GPT。\n   301|  2. 同一任务连续失败 >= 2 次时，必须 delegation。\n   302|  3. 若多个候选方案冲突且主线程无法可靠裁决，必须 delegation。\n   303|  4. 若结果准备写入长期 memory / workflow / skill，必须 delegation 审查。\n   304|  5. 若任务具有不可逆外部副作用，必须 delegation 审查。\n   305|  6. 如果问题仍可由低成本模型继续完成，则不得 delegation。\n   306|\n   307|  【输出行为规则】\n   308|\n   309|  1. 在未命中高阶条件时，不要声称自己需要 GPT，不要夸大任务复杂度。\n   310|  2. 在命中高阶条件时，应明确进入高阶判断路径。\n   311|  3. 高阶判断的输出应偏向：\n   312|     - 结构化框架\n   313|     - 裁决结论\n   314|     - 失败归因\n   315|     - 终止条件\n   316|     - 沉淀建议\n   317|  4. 不要让 GPT 做执行者；GPT 是审核者、裁决者、定稿者。\n   318|\n   319|  【memory 沉淀规则】\n   320|\n   321|  只有以下内容允许进入长期沉淀，并且建议先经过 delegation 审查：\n   322|\n   323|  - 用户稳定偏好\n   324|  - 已验证成功的执行模板\n   325|  - 已确认的失败模式与修复映射\n   326|  - 已确认的业务规则\n   327|  - 长期有效的系统拓扑与环境约束\n   328|  - 已确认的项目状态锚点\n   329|\n   330|  以下内容禁止写入长期沉淀：\n   331|\n   332|  - 临时状态\n   333|  - 未验证猜测\n   334|  - 高频变化信息\n   335|  - 原始日志\n   336|  - 一次性结论\n   337|  - 普通会话内容\n   338|  - 敏感凭据\n   339|\n   340|  【最终原则】\n   341|\n   342|  - MiniMax 负责常规判断与路由\n   343|  - OpenClaw 负责执行\n   344|  - GPT 负责关键节点把关\n   345|  - 能不用 GPT 的地方不用\n   346|  - 该用 GPT 的地方必须用 delegation，不允许含糊处理\n   347|", "total_lines": 346, "file_size": 8432, "truncated": false, "is_binary": false, "is_image": false}

### [] assistant



### [] tool

{"content": "     1|{\n     2|  \"version\": 1,\n     3|  \"providers\": {\n     4|    \"openai-codex\": {\n     5|      \"tokens\": {\n     6|        \"access_token\": \"eyJhbG...E_HA\",\n     7|        \"refresh_token\": \"rt_arT...O8Fw\"\n     8|      },\n     9|      \"last_refresh\": \"2026-04-17T09:40:02.550050Z\",\n    10|      \"auth_mode\": \"chatgpt\"\n    11|    }\n    12|  },\n    13|  \"active_provider\": \"openai-codex\",\n    14|  \"updated_at\": \"2026-04-17T12:40:28.300044+00:00\",\n    15|  \"credential_pool\": {\n    16|    \"openai-codex\": [\n    17|      {\n    18|        \"id\": \"73db1d\",\n    19|        \"label\": \"device_code\",\n    20|        \"auth_type\": \"oauth\",\n    21|        \"priority\": 0,\n    22|        \"source\": \"device_code\",\n    23|        \"access_token\": \"eyJhbG...E_HA\",\n    24|        \"refresh_token\": \"rt_arT...O8Fw\",\n    25|        \"last_status\": null,\n    26|        \"last_status_at\": null,\n    27|        \"last_error_code\": null,\n    28|        \"last_error_reason\": null,\n    29|        \"last_error_message\": null,\n    30|        \"last_error_reset_at\": null,\n    31|        \"base_url\": \"https://chatgpt.com/backend-api/codex\",\n    32|        \"last_refresh\": \"2026-04-17T09:40:02.550050Z\",\n    33|        \"request_count\": 0\n    34|      }\n    35|    ],\n    36|    \"minimax-cn\": [\n    37|      {\n    38|        \"id\": \"86ccec\",\n    39|        \"label\": \"MINIMAX_CN_API_KEY\",\n    40|        \"auth_type\": \"api_key\",\n    41|        \"priority\": 0,\n    42|        \"source\": \"env:MINIMAX_CN_API_KEY\",\n    43|        \"access_token\": \"***\",\n    44|        \"last_status\": null,\n    45|        \"last_status_at\": null,\n    46|        \"last_error_code\": null,\n    47|        \"last_error_reason\": null,\n    48|        \"last_error_message\": null,\n    49|        \"last_error_reset_at\": null,\n    50|        \"base_url\": \"https://api.minimaxi.com/anthropic\",\n    51|", "total_lines": 55, "file_size": 5556, "truncated": true, "hint": "Use offset=51 to continue reading (showing 1-50 of 55 lines)", "is_binary": false, "is_image": false}

### [] tool

{"output": "pairing", "exit_code": 0, "error": null}

### [] assistant

根据你的配置，你可以使用以下模型：

**当前配置的模型：**

| 模型 | 提供商 | 用途 |
|------|--------|------|
| **MiniMax-M2.7** | minimax-cn | 默认模型（低成本） |
| **gpt-5.4-mini** | openai-codex | 备用模型 |
| **gpt-5.4** | openai-codex | 高阶代理（delegation） |

**切换方法：**

修改 `~/.hermes/config.yaml` 中的 `model.default` 和 `model.provider`：

```yaml
model:
  default: MiniMax-M2.7      # 改成 gpt-5.4-mini 可切换到 GPT
  provider: minimax-cn       # 改成 openai-codex 用 GPT 系
```

**其他可用的模型（需配置 API key）：**
- OpenAI 系列（gpt-4o, gpt-4o-mini 等）
- Anthropic 系列（claude-3.5-sonnet 等）
- 其他 providers（需在平台配置）

你想切换到哪个模型？如果是 OpenAI/Anthropic 系列，需要先配置对应的 API key。
