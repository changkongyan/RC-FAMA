!/bin/bash

echo -e "执行仿真程序.....\n"

if [ -x "./build/rc-fama.exe" ] && [  -e "./build/rc-fama.exe"  ]
then
	echo  -e "可以执行程序\n"
    read  -p "请输入仿真节点个数、仿真窗口:" node_number CW simu_time
    if [ -z ${node_number} ] && [ -z ${CW} ] && [ -z ${simu_time} ]
    then
	    node_number=5
        CW=2
        simu_time=1800
    fi

    # 程序执行的次数
    times=60
    for i in `seq 1 ${times}`
    do
        echo -e "\n第"${i}"次执行"
        ./build/c-fama.exe -n ${node_number} -C ${CW} -s ${simu_time}
        # sleep 1
    done
    
    cat "${node_number} nodes of simulator result.txt" | awk 'NR%4==0' | awk ' { sum += $2 };END {print "\n\n"'${node_number}'"个节点的吞吐量: "sum/'${times}' >> "'${node_number}' nodes of simulator result.txt"}' 

else
	echo -e "不可以执行程序,开始编译程序.....\n"
    g++.exe -v
	if [ $? == 0 ]
    then
		g++ -std=c++11 *.h *.cpp -o ./build/rc-fama
		g++ -std=c++11 *.h *.cpp -o ./build/rc-fama-d -D MY_DEBUG
		echo -e "rc-fama为执行版本  rc-fama-d为调试版本\n"
	else
		echo -e "请添加g++到环境变量或者安装g++编译器，完成编译\n"
	fi
fi