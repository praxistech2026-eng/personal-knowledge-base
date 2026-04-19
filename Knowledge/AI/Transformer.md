# Transformer

## 🧠 Summary
Transformer是一种基于自注意力机制的深度学习架构，由Google于2017年提出，彻底改变了自然语言处理和序列建模领域。采用编码器-解码器架构实现序列到序列的转换。

## 🧩 Primary Concept
基于自注意力机制（Self-Attention）的深度学习架构，由编码器和解码器两大部分组成，用于处理序列到序列任务。

## 🔑 Key Points
- **自注意力机制（Self-Attention）**：并行计算序列内任意位置的关系，解决长距离依赖问题，使模型能够同时捕捉长距离依赖关系
- **多头注意力（Multi-Head Attention）**：将注意力机制并行运行多次，多组自注意力并行学习不同子空间表示
- **位置编码（Positional Encoding）**：由于无循环结构，使用正弦/余弦函数注入序列位置信息
- **编码器（Encoder）**：由 N=6 个相同层堆叠，每层包含多头自注意力子层和前馈神经网络子层，采用残差连接和层归一化
- **解码器（Decoder）**：同样由 N=6 个相同层堆叠，每层在编码器结构基础上增加掩码多头注意力子层，确保训练时无法访问未来位置信息
- **前馈神经网络（FFN）**：每个子层包含两层线性变换，中间使用 ReLU 激活
- **并行计算**：摆脱RNN时序依赖，训练效率大幅提升

## 🔗 Relations
- relates_to: [[Attention机制]]
- relates_to: [[Self-Attention]]
- relates_to: [[Positional Encoding]]
- relates_to: [[Sequence-to-Sequence]]
- relates_to: [[BERT]]
- relates_to: [[GPT]]

## 📚 References
- Vaswani et al., "Attention Is All You Need", NeurIPS 2017
- Google Research

## 🏷 Tags
#transformer #self-attention #deep-learning #nlp #sequence-modeling #neural-networks #encoder-decoder #google
