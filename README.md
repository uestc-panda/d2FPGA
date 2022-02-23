# 走近FPGA

## 简介

本仓库包括《走近FPGA》系列文章的Verilog代码。
《走近FPGA》系列文章发布在[知乎专栏“片上征途”](https://www.zhihu.com/column/conquest-on-chip)，目前已有以下内容（括号内为对应文件夹名）：
| 序号 | 文章标题 | 工程文件夹名 |
| :-: | :-----: | :----------: |
| 1 | 开发板介绍篇 | 无 |
| 2 | 工具篇（上）-Vivado | 无 |
| 3 | 工具篇（下）-Modelsim | 无 |
| 4 | 组合逻辑基础 | comb_basic |
| 5 | 组合逻辑进阶-模块化设计 | comb_adv |
| 6 | 点亮LED | light_LED |
| 7 | 数码管动态显示 | dynamic_display |
| 8 | 二进制转BCD码 | binary2bcd |
| 9 | 矩阵键盘 | keyboard |
| 10 | 最大公约数算法实现 | gcd |
| 11 | LCD驱动 | LCD |

## 仓库说明

每一个文件夹对应一篇《走近FPGA》文章的工程代码，其下的rtl文件夹存放Verilog代码（包括设计和testbench），vivado文件夹存放管脚约束文件。对于部分用C/C++建模的工程，其C/C++代码存放于c文件夹下。

## 贡献

《走近FPGA》系列文章及相应工程实现由@flyjancy, @yyyn-1203, @TheNightCanary协作完成。
