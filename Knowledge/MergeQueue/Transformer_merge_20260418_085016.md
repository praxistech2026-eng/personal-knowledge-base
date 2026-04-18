# Transformer模型

## 🧠 Summary
Transformer是一种基于自注意力机制的序列建模架构，通过编码器提取输入序列的上下文表示，并由解码器结合已生成内容与编码信息逐步生成输出；它摆脱了RNN的时序依赖，显著提升了并行计算能力和长距离依赖建模效果。

## 🧩 Canonical Concept
Transformer

## 🧩 Primary Concept
Transformer 是一种基于注意力机制的深度学习架构，核心由编码器和解码器组成，广泛用于自然语言处理与序列建模任务。

## 🔑 Key Points
- **自注意力机制（Self-Attention）**：通过计算序列中任意位置两两之间的关联，捕捉长距离依赖关系。
- **多头注意力（Multi-Head Attention）**：并行学习多个子空间中的关系表示，增强模型表达能力。
- **位置编码（Positional Encoding）**：通过正弦/余弦或可学习方式注入位置信息，弥补注意力机制缺少顺序感知的问题。
- **编码器结构**：由多层“自注意力 + 前馈网络”堆叠而成，用于将输入序列转换为上下文相关表示。
- **解码器结构**：由“掩码自注意力 + 编码器-解码器注意力 + 前馈网络”组成，按自回归方式生成输出。
- **残差连接与层归一化**：贯穿各子层，帮助稳定训练并加快收敛。
- **并行计算优势**：相较RNN，Transformer更适合并行训练，效率更高。

## 🔗 Relations
- relates_to: [[Attention机制]]
- relates_to: [[Seq2Seq]]
- relates_to: [[BERT]]
- relates_to: [[GPT]]

## 📚 References
- Vaswani et al., "Attention Is All You Need", NeurIPS 2017
- Google Research

## 🏷 Tags
#Transformer #NLP #Attention #EncoderDecoder #Seq2Seq #deep-learning #sequence-modeling #neural-networks #google
