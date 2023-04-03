#!/bin/bash
if ! grep -q "eula=true" eula.txt; then
    echo "Do you agree to the Mojang EULA available at https://account.mojang.com/documents/minecraft_eula ?"
    read -N 1 -p "[y/n] " EULA
    if [ "$EULA" = "y" ]; then
        echo "eula=true" > eula.txt
        echo
    fi
fi
running=1

finish()
{
    running=0
}

trap finish SIGINT

while (( running )); do
    "jre/jdk-17.0.2+8-jre/bin/java" -javaagent:log4jfix/Log4jPatcher-1.0.0.jar -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -Xmx6144M -Xms4096M @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.18.2-40.1.84/unix_args.txt nogui
    clear
    echo "Restarting in 5 seconds"
    sleep 5
done