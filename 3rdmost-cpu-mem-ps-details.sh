#!/bin/env bash #Need to execute 'which env and substitute /bin/env'

ps_name=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem |head -4 |tail -1 |awk '{print $3}')
ps_pid=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem |head -4 |tail -1 |awk '{print $1}')
ps_cpu=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem |head -4 |tail -1 |awk '{print $5}')
ps_mem=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem |head -4 |tail -1 |awk '{print $4}')
ps_port=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem |head -4 |tail -1 |netstat -plant|grep ${ps_pid}|grep -v grep |awk '{print $4}' |cut -d ':' -f2)

echo "1. Third Most process which is consuming CPU and Memory is : ${ps_name}
2. Third Most process which is consuming more CPU is : ${ps_cpu}
3. Third Most process which is consuming more Memory is : ${ps_mem}
4. Third Most process Port which is consuming more Memory is : ${ps_port}
5. Third Most process PID which is consuming CPU and Memory is : ${ps_pid}
" > processOutputFile.log