# KTJNightVersion
    KTJNightVersion :快速部署夜间模式。
    通过引用一个头文件 KTJNightVersionHelper.h，然后在initialize中添加类，然后在代码中设置夜间模式需要改变的颜色，于是乎一个夜间模式就OK了，尝试切换一下试试吧。
    虽然足够快速，但是并不能自动生成夜间模式。不过可以通过加工设置为苹果自带的颜色反转。但是话又说回来，苹果自带的系统直接切换了，还用App里面做什么呢。。郁闷。。
    

#  使用例子

    辅助快速部署第二种皮肤管理。

    两步设置：
    //  1、注册该类可切换夜间模式（只对本类有效，父类、子类无效。
    [KTJNightVersion addClassToSet:cell.textLabel.class];
    //  2、配置两种颜色  其中 'setKtj_normalTextColor' ==> 'setTextColor'。
    cell.textLabel.ktj_normalTextColor = [UIColor grayColor];
    cell.textLabel.ktj_nightTextColor = [UIColor whiteColor];

    切换模式，全局任意地方调用
    //  切换至正常模式
    [KTJNightVersion changeToNormal];
    //  切换至夜间模式
    [KTJNightVersion changeToNight];
#备注
  根据 https://github.com/Draveness/DKNightVersion.git 进行优化。
  深深感谢DK的思路。
  
  目前至进行小范围测试，并未暴力测试，如果发现问题请留言，谢谢。
  
  括弧：其实逻辑挺简单的。。
