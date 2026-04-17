# Transformer模型

## 🧠 Summary
Transformer是一种基于自注意力机制处理序列数据的深度学习架构，无需循环结构即可并行处理序列。

## 🧩 Primary Concept
自注意力机制（Self-Attention）通过计算序列内各位置之间的关联性，实现全局上下文建模。

## 🔑 Key Points
- **自注意力机制**：Query、Key、Value三个矩阵计算注意力权重，捕捉任意位置间的依赖关系
- **多头注意力**：多个注意力头并行工作，捕获不同类型的依赖模式
- **位置编码**：使用正弦/余弦函数或可学习向量注入序列位置信息
- **编码器-解码器结构**：编码器处理输入序列，解码器自回归生成输出
- **并行计算**：相比RNN，大幅提升训练效率

## 🔗 Relations
- relates_to: [[深度学习]]
- relates_to: [[注意力机制]]
- relates_to: [[自然语言处理]]

## 📚 References
- Vaswani et al., "Attention Is All You Need", NeurIPS 2017

## 🏷 Tags
#深度学习 #NLP #注意力机制 #序列建模 #神经网络
