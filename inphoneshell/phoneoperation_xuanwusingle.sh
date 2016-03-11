#!/bin/bash

######################################################################
##### 手机上各种按键的事件可以通过toolbox getevent /dev/input/event3查看
######################################################################

######################################################################
##### 手机上按电源键
######################################################################
function PowerPhone
{
    toolbox sendevent /dev/input/event7 0001 116 00000001
    toolbox sendevent /dev/input/event7 0000 0000 00000000
    toolbox sendevent /dev/input/event7 0001 116 00000000
    toolbox sendevent /dev/input/event7 0000 0000 00000000
    return 0
}

######################################################################
##### 手机屏幕上进行点击，$1和$2是坐标
##### 坐标的获得方法
######################################################################
function TouchPhone
{
    toolbox sendevent /dev/input/event1 0001 0330 00000001 
    toolbox sendevent /dev/input/event1 0003 0058 00000054
    toolbox sendevent /dev/input/event1 0003 0048 00000054
    toolbox sendevent /dev/input/event1 0003 0057 00000000
    toolbox sendevent /dev/input/event1 0003 0053 $1
    toolbox sendevent /dev/input/event1 0003 0054 $2
    toolbox sendevent /dev/input/event1 0000 0002 00000000
    toolbox sendevent /dev/input/event1 0000 0000 00000000
    toolbox sendevent /dev/input/event1 0001 0330 00000000
    toolbox sendevent /dev/input/event1 0000 0002 00000000
    toolbox sendevent /dev/input/event1 0000 0000 00000000
    return 0
}

######################################################################
##### 手机上按HOME键
######################################################################
function HomePhone
{
    TouchPhone 355 1234
    return 0
}

######################################################################
##### 点亮手机屏幕
######################################################################
function LightPhoneScreen
{
    [ "$(cat /sys/class/graphics/fb0/state)" != "0" ] && PowerPhone && sleep 1
    #[ "$(cat /sys/class/backlight/sprd_backlight/brightness)" -lt 20 ] && PowerPhone && sleep 1
    #[ "$(cat /sys/devices/platform/sprd_backlight/backlight/sprd_backlight/brightness)" -lt 20 ] && PowerPhone && sleep 1
    #[ "$(cat /sys/devices/platform/sprd_backlight/backlight/sprd_backlight/actual_brightness)" -lt 20 ] && PowerPhone && sleep 1
    return 0
}

######################################################################
##### 关闭手机屏幕
######################################################################
function ClosePhoneScreen
{
    [ "$(cat /sys/class/graphics/fb0/state)" == "0" ] && PowerPhone && sleep 1
    return 0
}

######################################################################
##### 烧机后设置密码
######################################################################
function SetDigitalPassword
{
    local setpassword="$1"
    for ((j = 0; j < 2; ++j))
    do
        for ((i = 0; i < 4; ++i))
        do
            case "${setpassword:$i:1}" in
                1)  TouchPhone 121 867  ;;
                2)  TouchPhone 366 867  ;;
                3)  TouchPhone 606 867  ;;
                4)  TouchPhone 121 990  ;;
                5)  TouchPhone 366 990  ;;
                6)  TouchPhone 606 990  ;;
                7)  TouchPhone 121 1112 ;;
                8)  TouchPhone 366 1112 ;;
                9)  TouchPhone 606 1112 ;;
                0)  TouchPhone 366 1230 ;;
            esac
            sleep 0.2
        done
        sleep 2
    done
    return 0
}
