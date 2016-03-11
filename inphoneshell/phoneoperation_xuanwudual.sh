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

function TouchInfo
{
    toolbox sendevent /dev/input/event1 0003 0058 00000054
    toolbox sendevent /dev/input/event1 0003 0048 00000054
    toolbox sendevent /dev/input/event1 0003 0057 00000000
    toolbox sendevent /dev/input/event1 0003 0053 $1
    toolbox sendevent /dev/input/event1 0003 0054 $2
    toolbox sendevent /dev/input/event1 0000 0002 00000000
    toolbox sendevent /dev/input/event1 0000 0000 00000000
    return 0
}


######################################################################
##### 手机屏幕上进行点击，$1和$2是坐标
##### 坐标的获得方法
######################################################################
function TouchPhone
{
    toolbox sendevent /dev/input/event1 0001 0330 00000001 
    TouchInfo $1 $2
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
    TouchPhone 465 1199
    return 0
}

######################################################################
##### 手机上按BACK键
######################################################################
function BackPhone
{
    TouchPhone 662 1249
    return 0
}

######################################################################
##### 手机屏幕解锁时向上滑动屏幕
######################################################################
function SlipUpPhone
{
    toolbox sendevent /dev/input/event1 0001 0330 00000001 
    TouchInfo 513 1188
    TouchInfo 513 1168
    TouchInfo 513 1148
    TouchInfo 513 1128
    TouchInfo 513 1108
    TouchInfo 513 1088
    TouchInfo 513 1068
    TouchInfo 513 1048
    TouchInfo 513 1028
    TouchInfo 513 1008
    TouchInfo 513 988
    TouchInfo 513 968
    TouchInfo 513 948
    TouchInfo 513 928
    TouchInfo 513 908
    TouchInfo 513 888
    TouchInfo 513 868
    TouchInfo 513 848
    TouchInfo 513 828
    TouchInfo 513 808
    TouchInfo 513 788
    TouchInfo 513 768
    TouchInfo 513 748
    TouchInfo 513 728
    TouchInfo 513 708
    TouchInfo 513 688
    TouchInfo 513 668
    TouchInfo 513 648
    TouchInfo 513 628
    TouchInfo 513 608
    TouchInfo 513 588
    TouchInfo 513 568
    TouchInfo 513 548
    TouchInfo 513 528
    TouchInfo 513 508
    TouchInfo 513 488
    TouchInfo 513 468
    TouchInfo 513 448
    TouchInfo 513 428
    TouchInfo 513 408
    TouchInfo 513 388
    TouchInfo 513 368
    TouchInfo 513 348
    TouchInfo 513 328
    TouchInfo 513 308
    TouchInfo 513 288
    TouchInfo 513 268
    TouchInfo 513 248
    TouchInfo 513 228
    TouchInfo 513 208
    TouchInfo 513 188
    toolbox sendevent /dev/input/event1 0001 0330 00000000
    toolbox sendevent /dev/input/event1 0000 0002 00000000
    toolbox sendevent /dev/input/event1 0000 0000 00000000

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

######################################################################
##### 输入手机密码
######################################################################
function InputDigitalPassword
{
    local setpassword="$1"
    for ((i = 0; i < 4; ++i))
    do
        case "${setpassword:$i:1}" in
            1)  TouchPhone 110 640  ;;
            2)  TouchPhone 343 640  ;;
            3)  TouchPhone 589 640  ;;
            4)  TouchPhone 110 806  ;;
            5)  TouchPhone 343 806  ;;
            6)  TouchPhone 589 806  ;;
            7)  TouchPhone 110 964 ;;
            8)  TouchPhone 343 964 ;;
            9)  TouchPhone 589 964 ;;
            0)  TouchPhone 343 1153 ;;
        esac
        sleep 0.2
    done
    return 0
}

######################################################################
##### 解锁手机屏幕，$1是数字密码
######################################################################
function UnlockPhoneScreen
{
    PowerPhone && sleep 0.5
    LightPhoneScreen
    SlipUpPhone && sleep 0.5
    InputDigitalPassword "$1"
    return 0
}

######################################################################
##### 手机上连接wifi，$1和$2是wifi的名称和密码
##### 可用的wifi
#####               nqi         --> 9876543299
#####               SYBEROS     --> 2015201499 需要绑定MAC地址
######################################################################
function PhoneConnectWiFi
{
    ! [ -x /bin/dbus-send ] && echo "Error: !!! Can't find the command of /bin/dbus-send !!!" >&2 && return 1
    su - system -c "/bin/dbus-send --system --type=method_call --print-reply --dest=net.connman /net/connman/technology/wifi net.connman.Technology.SetProperty string:Powered variant:boolean:false; rm -rf /var/lib/connman/wifi_*; /bin/dbus-send --system --type=method_call --print-reply --dest=net.connman / net.connman.Manager.ConfigWiFi 'string:$1' 'variant:string:$2' && /bin/dbus-send --system --type=method_call --print-reply --dest=net.connman /net/connman/technology/wifi net.connman.Technology.SetProperty string:Powered variant:boolean:true"
    return 0
}

######################################################################
##### 手机上关闭wifi连接
######################################################################
function PhoneDisconnectWiFi
{
    ! [ -x /bin/dbus-send ] && echo "Error: !!! Can't find the command of /bin/dbus-send !!!" >&2 && return 1
    su - system -c '/bin/dbus-send --system --type=method_call --print-reply --dest=net.connman /net/connman/technology/wifi net.connman.Technology.SetProperty string:Powered variant:boolean:false; rm -rf /var/lib/connman/wifi_*'
    return 0
}
