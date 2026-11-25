#!/bin/bash
# SPDX-FileCopyrightText: 2026 Itsuki Okubo
# SPDX-License-Identifier: BSD-3-Clause

ng () {
        echo ${1}行目のテスト失敗
        res=1
}

res=0

out=$(./dice)
num=$(echo "$out" | sed -n '1p')
sum=$(echo "$out" | sed -n '2p')

echo "$num" | grep -Eq '^[1-6]$' || ng "$LINENO"
[ "$num" = "$sum" ] || ng "$LINENO"

out=$(./dice 3)
num=$(echo "$out" | sed -n '1p')
sum=$(echo "$out" | sed -n '2p')

echo "$num" | grep -Eq '^[1-6]{3}$' || ng "$LINENO"

calc_sum=0
for ((i=0; i<${#num}; i++)); do
    digit=${num:$i:1}
    calc_sum=$((calc_sum + digit))
done
[ "$calc_sum" -eq "$sum" ] || ng "$LINENO"

[ "$res" = 0 ] && echo "OK"
exit $res
