# Transformer模型

## 🧠 Summary
Transformer是一种基于自注意力机制的深度学习架构，由Google于2017年提出，彻底改变了自然语言处理和序列建模领域。

## 🧩 Primary Concept
**自注意力机制（Self-Attention）**：通过计算序列中所有位置两两之间的关联强度，使模型能够同时捕捉长距离依赖关系。

## 🔑 Key Points
- **自注意力机制**：并行计算序列内任意位置的关系，解决长距离依赖问题
- **多头注意力（Multi-Head Attention）**：多组自注意力并行学习不同子空间表示
- **位置编码（Positional Encoding）**：使用正弦/余弦函数注入序列位置信息
- **编码器-解码器架构**：编码器提取序列特征，解码器生成输出序列
- **并行计算**：摆脱RNN时序依赖，训练效率大幅提升

## 🔗 Relations
- relates_to: [[RNN]], [[LSTM]], [[Attention机制]], [[BERT]], [[GPT]], [[位置编码]]

## 📚 References
- Vaswani et al., "Attention Is All You Need", NeurIPS 2017
- Google Research

## 🏷 Tags
deep-learning, nlp, sequence-modeling, neural-networks, google
