#!/bin/bash

######################################################################
##### 手机上各种按键的事件可以通过toolbox getevent /dev/input/event3查看
######################################################################

######################################################################
##### 手机上按电源键
######################################################################
function PowerPhone
{
    toolbox sendevent /dev/input/event0 0001 116 00000001
    toolbox sendevent /dev/input/event0 0000 0000 00000000
    toolbox sendevent /dev/input/event0 0001 116 00000000
    toolbox sendevent /dev/input/event0 0000 0000 00000000
    return 0
}

######################################################################
##### 手机上按任务栏键
######################################################################
function MenuPhone
{
    toolbox sendevent /dev/input/event3 0001 139 00000001
    toolbox sendevent /dev/input/event3 0000 0000 00000000
    toolbox sendevent /dev/input/event3 0001 139 00000000
    toolbox sendevent /dev/input/event3 0000 0000 00000000
    return 0
}

######################################################################
##### 手机上按HOME键
######################################################################
function HomePhone
{
    toolbox sendevent /dev/input/event3 0001 102 00000001
    toolbox sendevent /dev/input/event3 0000 0000 00000000
    toolbox sendevent /dev/input/event3 0001 102 00000000
    toolbox sendevent /dev/input/event3 0000 0000 00000000
    return 0
}

######################################################################
##### 手机上按BACK键
######################################################################
function BackPhone
{
    toolbox sendevent /dev/input/event3 0001 0158 00000001
    toolbox sendevent /dev/input/event3 0000 0000 00000000
    toolbox sendevent /dev/input/event3 0001 0158 00000000
    toolbox sendevent /dev/input/event3 0000 0000 00000000
    return 0
}

######################################################################
##### 手机屏幕上进行点击，$1和$2是坐标
##### 坐标的获得方法：
#####     在手机建立文件/data/systemservice/framework/frame_rate，重启手机。
#####     手机启动后，触屏时在手机右上角就会有坐标信息
######################################################################
function TouchPhone
{
    toolbox sendevent /dev/input/event3 3 47 0
    toolbox sendevent /dev/input/event3 3 57 0
    toolbox sendevent /dev/input/event3 3 53 $1
    toolbox sendevent /dev/input/event3 3 54 $2
    toolbox sendevent /dev/input/event3 3 48 62
    toolbox sendevent /dev/input/event3 3 50 62
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 47 0
    toolbox sendevent /dev/input/event3 3 57 -1
    toolbox sendevent /dev/input/event3 0 0 0
    return 0
}

######################################################################
##### 手机屏幕解锁时向上滑动屏幕
######################################################################
function SlipUpPhone
{
    toolbox sendevent /dev/input/event3 3 57 0
    toolbox sendevent /dev/input/event3 3 53 527
    toolbox sendevent /dev/input/event3 3 54 1208
    toolbox sendevent /dev/input/event3 3 48 62
    toolbox sendevent /dev/input/event3 3 50 62
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 528
    toolbox sendevent /dev/input/event3 3 54 1185
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 529
    toolbox sendevent /dev/input/event3 3 54 1147
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 530
    toolbox sendevent /dev/input/event3 3 54 1125
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 532
    toolbox sendevent /dev/input/event3 3 54 1108
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 1098
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 1088
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 1076
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 533
    toolbox sendevent /dev/input/event3 3 54 1067
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 534
    toolbox sendevent /dev/input/event3 3 54 1058
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 535
    toolbox sendevent /dev/input/event3 3 54 1039
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 536
    toolbox sendevent /dev/input/event3 3 54 1028
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 537
    toolbox sendevent /dev/input/event3 3 54 1016
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 539
    toolbox sendevent /dev/input/event3 3 54 1005
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 540
    toolbox sendevent /dev/input/event3 3 54 994
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 542
    toolbox sendevent /dev/input/event3 3 54 983
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 543
    toolbox sendevent /dev/input/event3 3 54 976
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 968
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 544
    toolbox sendevent /dev/input/event3 3 54 962
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 545
    toolbox sendevent /dev/input/event3 3 54 952
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 546
    toolbox sendevent /dev/input/event3 3 54 942
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 548
    toolbox sendevent /dev/input/event3 3 54 934
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 550
    toolbox sendevent /dev/input/event3 3 54 926
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 554
    toolbox sendevent /dev/input/event3 3 54 916
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 556
    toolbox sendevent /dev/input/event3 3 54 911
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 558
    toolbox sendevent /dev/input/event3 3 54 905
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 560
    toolbox sendevent /dev/input/event3 3 54 899
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 561
    toolbox sendevent /dev/input/event3 3 54 894
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 564
    toolbox sendevent /dev/input/event3 3 54 891
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 566
    toolbox sendevent /dev/input/event3 3 54 886
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 565
    toolbox sendevent /dev/input/event3 3 54 888
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 567
    toolbox sendevent /dev/input/event3 3 54 884
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 570
    toolbox sendevent /dev/input/event3 3 54 873
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 572
    toolbox sendevent /dev/input/event3 3 54 863
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 857
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 573
    toolbox sendevent /dev/input/event3 3 54 850
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 843
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 574
    toolbox sendevent /dev/input/event3 3 54 834
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 825
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 575
    toolbox sendevent /dev/input/event3 3 54 805
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 788
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 574
    toolbox sendevent /dev/input/event3 3 54 771
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 572
    toolbox sendevent /dev/input/event3 3 54 752
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 746
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 736
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 573
    toolbox sendevent /dev/input/event3 3 54 728
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 574
    toolbox sendevent /dev/input/event3 3 54 719
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 576
    toolbox sendevent /dev/input/event3 3 54 712
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 577
    toolbox sendevent /dev/input/event3 3 54 702
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 578
    toolbox sendevent /dev/input/event3 3 54 689
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 579
    toolbox sendevent /dev/input/event3 3 54 675
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 578
    toolbox sendevent /dev/input/event3 3 54 659
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 577
    toolbox sendevent /dev/input/event3 3 54 643
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 576
    toolbox sendevent /dev/input/event3 3 54 628
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 610
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 601
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 591
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 577
    toolbox sendevent /dev/input/event3 3 54 582
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 578
    toolbox sendevent /dev/input/event3 3 54 572
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 580
    toolbox sendevent /dev/input/event3 3 54 563
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 581
    toolbox sendevent /dev/input/event3 3 54 553
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 543
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 531
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 521
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 580
    toolbox sendevent /dev/input/event3 3 54 502
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 579
    toolbox sendevent /dev/input/event3 3 54 492
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 484
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 476
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 580
    toolbox sendevent /dev/input/event3 3 54 469
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 460
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 581
    toolbox sendevent /dev/input/event3 3 54 450
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 582
    toolbox sendevent /dev/input/event3 3 54 441
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 583
    toolbox sendevent /dev/input/event3 3 54 432
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 423
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 584
    toolbox sendevent /dev/input/event3 3 54 413
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 394
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 386
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 583
    toolbox sendevent /dev/input/event3 3 54 378
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 582
    toolbox sendevent /dev/input/event3 3 54 371
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 580
    toolbox sendevent /dev/input/event3 3 54 364
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 355
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 349
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 341
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 335
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 327
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 323
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 319
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 582
    toolbox sendevent /dev/input/event3 3 54 304
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 583
    toolbox sendevent /dev/input/event3 3 54 294
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 286
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 584
    toolbox sendevent /dev/input/event3 3 54 278
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 270
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 261
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 583
    toolbox sendevent /dev/input/event3 3 54 253
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 582
    toolbox sendevent /dev/input/event3 3 54 243
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 233
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 581
    toolbox sendevent /dev/input/event3 3 54 225
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 579
    toolbox sendevent /dev/input/event3 3 54 217
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 576
    toolbox sendevent /dev/input/event3 3 54 196
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 575
    toolbox sendevent /dev/input/event3 3 54 187
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 574
    toolbox sendevent /dev/input/event3 3 54 179
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 54 169
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 573
    toolbox sendevent /dev/input/event3 3 54 155
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 572
    toolbox sendevent /dev/input/event3 3 54 139
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 570
    toolbox sendevent /dev/input/event3 3 54 121
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 567
    toolbox sendevent /dev/input/event3 3 54 102
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 564
    toolbox sendevent /dev/input/event3 3 54 85
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 561
    toolbox sendevent /dev/input/event3 3 54 66
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 557
    toolbox sendevent /dev/input/event3 3 54 34
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 555
    toolbox sendevent /dev/input/event3 3 54 22
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 554
    toolbox sendevent /dev/input/event3 3 54 15
    toolbox sendevent /dev/input/event3 3 48 59
    toolbox sendevent /dev/input/event3 3 50 59
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 553
    toolbox sendevent /dev/input/event3 3 54 11
    toolbox sendevent /dev/input/event3 3 48 51
    toolbox sendevent /dev/input/event3 3 50 51
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 57 4294967295
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 0 0 0

    return 0
}

######################################################################
##### 手机屏幕向左滑动
######################################################################
function SlipLeftPhone
{
    toolbox sendevent /dev/input/event3 3 57 0
    toolbox sendevent /dev/input/event3 3 53 683
    toolbox sendevent /dev/input/event3 3 54 777
    toolbox sendevent /dev/input/event3 3 48 59
    toolbox sendevent /dev/input/event3 3 50 59
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 640
    toolbox sendevent /dev/input/event3 3 54 763
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 507
    toolbox sendevent /dev/input/event3 3 54 739
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 351
    toolbox sendevent /dev/input/event3 3 54 707
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 149
    toolbox sendevent /dev/input/event3 3 54 685
    toolbox sendevent /dev/input/event3 3 48 57
    toolbox sendevent /dev/input/event3 3 50 57
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 57 4294967295
    toolbox sendevent /dev/input/event3 0 0 0
    return 0
}

######################################################################
##### 手机屏幕向右滑动
######################################################################
function SlipRightPhone
{
    toolbox sendevent /dev/input/event3 3 57 0
    toolbox sendevent /dev/input/event3 3 53 251
    toolbox sendevent /dev/input/event3 3 54 658
    toolbox sendevent /dev/input/event3 3 48 65
    toolbox sendevent /dev/input/event3 3 50 65
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 257
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 283
    toolbox sendevent /dev/input/event3 3 54 657
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 325
    toolbox sendevent /dev/input/event3 3 54 655
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 472
    toolbox sendevent /dev/input/event3 3 54 654
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 521
    toolbox sendevent /dev/input/event3 3 54 656
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 565
    toolbox sendevent /dev/input/event3 3 54 664
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 612
    toolbox sendevent /dev/input/event3 3 54 676
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 654
    toolbox sendevent /dev/input/event3 3 54 691
    toolbox sendevent /dev/input/event3 3 48 53
    toolbox sendevent /dev/input/event3 3 50 53
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 53 688
    toolbox sendevent /dev/input/event3 3 54 701
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 3 57 4294967295
    toolbox sendevent /dev/input/event3 0 0 0
    toolbox sendevent /dev/input/event3 0 0 0
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
                1)  TouchPhone 132 853  ;;
                2)  TouchPhone 382 853  ;;
                3)  TouchPhone 600 853  ;;
                4)  TouchPhone 132 964  ;;
                5)  TouchPhone 382 964  ;;
                6)  TouchPhone 600 964  ;;
                7)  TouchPhone 132 1075 ;;
                8)  TouchPhone 382 1075 ;;
                9)  TouchPhone 600 1075 ;;
                0)  TouchPhone 382 1224 ;;
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
