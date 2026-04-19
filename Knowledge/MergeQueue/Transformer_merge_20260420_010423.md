# Transformer

## 🧠 Summary
Transformer是一种基于自注意力机制的深度学习架构，由Google于2017年提出，彻底改变了自然语言处理和序列建模领域。首个完全基于注意力机制实现序列建模的架构，采用编码器-解码器架构实现序列到序列的转换。

## 🧩 Primary Concept
一种通过自注意力机制并行处理序列数据的深度学习架构，由多层编码器和解码器堆叠组成。

## 🔑 Key Points
- **自注意力机制（Self-Attention）**：并行计算序列内任意位置的关系，解决长距离依赖问题，使模型能够同时捕捉长距离依赖关系
- **多头注意力（Multi-Head Attention）**：将注意力机制并行运行多次，多组自注意力并行学习不同子空间表示
- **位置编码（Positional Encoding）**：由于无循环结构，使用正弦/余弦函数注入序列位置信息
- **编码器（Encoder）**：由 N=6 层相同的子层组成，每层包含多头自注意力和前馈网络两个子层，采用残差连接和层归一化
- **解码器（Decoder）**：同样由 N=6 层组成，每层包含掩码多头自注意力、编码器-解码器注意力和前馈网络三个子层，确保训练时无法访问未来位置信息
- **编码器-解码器注意力**：解码器中间层通过 Q 来自解码器、K/V 来自编码器的交叉注意力机制实现跨模态对齐
- **前馈神经网络（FFN）**：每个子层包含两层线性变换，中间使用 ReLU 激活
- **残差连接**：每个子层周围使用残差连接，随后进行层归一化
- **并行计算**：摆脱RNN时序依赖，训练效率大幅提升

## 🔗 Relations
- relates_to: [[Attention机制]]
- relates_to: [[Self-Attention]]
- relates_to: [[Multi-Head Attention]]
- relates_to: [[Positional Encoding]]
- relates_to: [[Feed-Forward Network]]
- relates_to: [[Sequence-to-Sequence]]
- relates_to: [[BERT]]
- relates_to: [[GPT]]

## 📚 References
- Vaswani et al., "Attention Is All You Need", NeurIPS 2017
- Google Research

## 🏷 Tags
#transformer #self-attention #deep-learning #nlp #sequence-modeling #neural-networks #encoder-decoder #google #attention-mechanism #multi-head-attention #positional-encoding
