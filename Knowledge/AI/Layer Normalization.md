# 什么是 Layer Normalization

## 🧠 Summary
Layer Normalization 是一种对单个样本内部特征进行归一化的技术，用于稳定训练并提升神经网络收敛速度。

## 🧩 Canonical Concept
Layer Normalization

## 🧩 Primary Concept
一种对样本的特征维度做标准化处理、以改善训练稳定性的归一化方法。

## 🔑 Key Points
- 它在每个样本内部计算均值和方差，而不是在整个 batch 上计算。
- 常用于 Transformer 等模型中，尤其适合 batch size 较小或变化较大的场景。
- 通常能缓解梯度不稳定，加快收敛，并提升训练鲁棒性。

## 🔗 Relations
- relates_to: [[Batch Normalization]]

## 📚 References

## 🏷 Tags
#LayerNormalization #神经网络 #归一化
