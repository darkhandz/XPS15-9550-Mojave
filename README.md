### 一些说明

写教程实在是很累的，所以不想再写了，希望你从`pcbeta`的黑苹果各个板块看精华帖学习基本的技能，或者`tonymacx86`里`Rehabman`写的各个基础帖子。

这里只分享我自己目前在用的配置，不一定适合你，可以参考，修改成自己合用的。

这套配置是我从10.13.6直接升级上来10.14用的，不知道在全新安装10.14的时候会不会有什么意外，请自行测试下。

> 请不要开启`filevault`，我的配置里删除掉相关的efi文件了，你有需要的话，自己重新安装一下Clover。

Clover是[Rehabman版本](https://bitbucket.org/RehabMan/clover/downloads/)的`r4658`，你也可以用官方版本。

### 硬件配置

- 机型：DELL XPS15 9550
- BIOS：v1.5.1
- CPU：Intel i7 6700HQ
- 内存：16G DDR4 2400（原厂8G，自己换了）
- 硬盘：SM961 256G NVMe SSD
- 核显：HD530, 1920x1080
- 声卡：Realtek ALC298（也叫ALC3266）
- 无线网卡：DW1830（带蓝牙）

DW1830是免驱的，如果你的无线网卡是Killer的，那就很不幸了，目前还没有驱动，你得去深水宝买一张免驱卡来更换才行。

### 安装完之后的一些问题

- 独显不指望了
- 无线5GHz达不到最高速度（我没具体测试过）
- ThunderBolt/USB-C 应该不行（没设备测试）
- 低亮度会有轻微闪屏
- APFS搭配默认开启TRIM的NVMe SSD，开机时间太长了（要是受不了可以试试各种手段转回HFS+）

### 额外的驱动(Other/LE)

这个文件夹的东西是要安装到`/Library/Extensions/`里面的。

- 执行命令：`sudo cp -r 把AppleGraphicsDevicePolicyInjector.kext拖过来 /Library/Extensions/`
- 执行命令：`sudo kextcache -i /`

第一条命令的`AppleGraphicsDevicePolicyInjector.kext`是用来打开`MacBookPro13,3`这个SMBIOS的HDMI图像输出的。  
第二条是重建缓存，让添加的第三方驱动重建缓存，在重启后生成新的缓存。

对了，Other文件夹里提供了`VoodooI2C`触摸板驱动，这个可以模拟Magic Trackpad的手势(双指缩放，三指拖拽，四指各种），需要配合`VoodooPS2Controller`使用，直接放`clover/kexts/other`里重启就行了，但是目前它并不稳定，**只建议有经验的用户**折腾，否则开不了机什么的你又不会用`UEFI Shell`来删除它，那你就很被动了。

### 耳机拔插(Other/ComboJack)

它的作用：检测耳机拔插，修复耳机孔多合一下产生的一些问题，关于它的原理，请看[wmchris的教程](https://github.com/wmchris/DellXPS15-9550-OSX/blob/master/10.12/Post-Install/AD-Kexts/Audio/VerbStub_knnspeed/README.md)。

- 执行命令：`cd 把ComboJack文件夹拖过来`
- 执行命令：`chmod +x install.sh`
- 执行命令：`./install.sh`
    
    ![](http://darkhandz.qiniudn.com/2017-11-03-132202.png)

看见`Enjoy!`的话，ComboJack就安装完成了，重启一下系统。


### 一些小问题处理

#### 字体细、发虚

终端执行`defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`，注销再登录即可

#### 取消休眠写入 sleepimage 文件

```bash
sudo pmset hibernatemode 0
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```

#### 减少进入睡眠前的等待时间

```bash
sudo pmset dwlinterval 5
```

