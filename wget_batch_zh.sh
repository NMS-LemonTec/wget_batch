#!/bin/bash

# 批量 wget 下载脚本
# 运行后可以逐行输入下载链接，输入空行结束输入
# By NMS-LemonTec
# https://github.com/NMS-LemonTec/wget_batch/

TMP_FILE=$(mktemp)   # 临时文件存储链接

echo "请输入需要下载的链接（每行一个，输入空行结束）："

# 循环读取用户输入
while true; do
    read -r url
    if [ -z "$url" ]; then
        break
    fi
    echo "$url" >> "$TMP_FILE"
done

# 检查是否有输入链接
if [ ! -s "$TMP_FILE" ]; then
    echo "未输入任何链接，脚本退出。"
    rm -f "$TMP_FILE"
    exit 1
fi

echo "以下是即将下载的链接："
cat "$TMP_FILE"

# 让用户确认是否开始下载
read -p "是否开始下载？(y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "下载已取消。"
    rm -f "$TMP_FILE"
    exit 0
fi

echo "开始批量下载..."

# 执行 wget 下载，-c 支持断点续传，--show-progress 显示进度
wget -c -i "$TMP_FILE" --show-progress

# 清理临时文件
rm -f "$TMP_FILE"

echo "下载完成。"
