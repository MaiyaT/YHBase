//
//  NNJokeManager.m
//  SuoShi
//
//  Created by 林宁宁 on 15/12/31.
//  Copyright © 2015年 林宁宁. All rights reserved.
//

#import "NNJokeManager.h"

@implementation NNJokeManager

+(NNJokeManager *)shareManager
{
    static NNJokeManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NNJokeManager alloc] init];
        
        manager.itemList = [[NSArray alloc] initWithArray:[manager getLocalJokeList]];
    });
    
    return manager;
}

- (NSArray *)getLocalJokeList
{
    NSArray * list = @[
                       @"冬天，农夫发现了一条蛇冻僵了，于是就把他放到了自己的怀里，回家后发现蛇还没清醒，为了让蛇快点醒过来，农夫把他放到了一个管子里，为了让蛇快点醒，他还加了，人参三十克，枸杞三百克，地黄一百克，白酒五千毫升",
                       @"张飞和刘备正被魏国大军追杀，突然张飞看见前方一悬崖，张飞大呼：＂大哥！你快勒马。刘备闻言怒道：我快乐尼玛！",
                       @"有一天，我朋友跟我说:“你背上好多痣啊。”然后我就问:“写的啥？”",
                       @"今天我给一个人发了一毛钱红包，然后他给我发两毛， 然后我三毛，他四毛。。。。 到我给她发99.9的时候，他不发了， 那么问题来了， 我亏了多少",
                       @"刚刚听同事说：“中国最有种的男人落网了……”",
                       @"今天有个小混混来理发，把王振华的照片摔在桌上：按着照片剪，知道不？ 我战战兢兢用左手开始理发，右手狠狠按着照片，一动也不敢动。。。",
                       @"我有一次上山里玩，路上遇到一只狐狸，心血来潮远远冲它大喝一声：“孽畜！还不快快现出原形？！”狐狸楞了一下，突然开口说话了：“这本来就是原形啊！”“妈呀有妖怪！！！”我大叫一声撒丫子跑了,狐狸嗷地一声跟着在后面跑,边跑边叫：“哪儿哪儿有妖怪啊!别丢下我呀!吓死我了…”",
                       @"王超问我最近在忙什么，我说：“最近研究佛学，已经看了一个月经书了。” 王超说：“大哥，佛学还研究月经？”",
                       @"上课的时候， 老师提问小明：我有十斤黄金和十斤棉花哪一个比较重 ？\n小明当时就泪流满面，紧紧抱住老师的大腿 ：土豪，土豪我们做朋友吧 ",
                       @"“金庸小说里五大高手东邪、西毒、南帝、北丐、中神通谁最厉害？” “中神通最厉害。” “那东邪和西毒谁更厉害些呢？” “西毒吧。” “为什么？” “西毒可镇东。”",
                       @"李代沫和张默在监狱聊起毒品，代沫叹气说：“有时候没钱，偶尔我也会嗑假药，这下倒好，进来了连假药都没得嗑。” 张默不屑道：“要嗑就嗑真东西！“ 这时巡逻的狱警刚好过来了，问张默：“你刚说什么？柯震东吸什么？”",
                       @"到家的时候，看见邻居家的孩子忘带钥匙，坐在家门口冷的直打哆嗦， 我过去问她：“进来喝杯咖啡？” 她扑通一声跪下来说：“大叔，我还小。”",
                       @"有科学家做了个“温水煮青蛙”的实验，把青蛙投入已经煮沸的开水中时青蛙会跳出来，把青蛙放进冷水再慢慢加热，青蛙因为开始时水温的舒适而放松，等水热时已无力跳出来而最终被煮熟。实验后科学家得出一个结论：青蛙不加调料煮真特么难吃。",
                       @"俩小孩在小区花园玩过家家...... 男孩对女孩说道：“你有多少存款啊。” 女孩从粉红色小兜兜里面掏出了二十块钱道：“我就这些，你呢。” 男孩接过女孩的钱看了看，然后说道：“你的钱是2005年的，过期了，我家有冰箱，我给你保管好嘛。” 女孩点了点头道：“你真好。” 我目睹男孩拿过钱后，然后偷偷跑去卖好吃的。心道，此子日后必成大器啊。。。",
                       @"听众：电台吗？我今天在超市门口捡了一个装有五千块钱的钱包！主持人：那我先替失主感谢你了！听众：你误会了，我只想点一首歌给自己祝贺一下！",
                       @"..女儿放学回来把试卷让我签字，分数很低，把我气坏了：考这么低，笨死了，你知道猪是怎么死的？女儿低声说：气死的吧！我。。。",
                       @"一次路上遇到一哥们，这脑残喜欢开玩笑叫我儿子，于是我说:谁爹谁儿子？这货十分配合的回答:我爹你儿子！于是我满意的拍拍他的肩膀:孙子乖！",
                       @"爸爸和儿子一起看动物纪录片，看到了一头大象。 爸爸问：“大象体格那么巨大，它怕谁呀？” 儿子不假思索地说：“大象媳妇呗！” 爸爸瞬间无语。想：早知道就不问了！！",
                       @"今天和哥几个喝酒吟诗，我说：别人笑我太疯癫，我笑他人看不穿……还没说完，刘兄就接上了：别人笑我太淫荡，我笑他人不开放……张兄又来：别人笑我不开放，我和他们不一样，他们又色又淫荡，才会笑我不开放。我听完在想：刘关张都被你们黑出翔了！",
                       @"孟婆：喝了这碗孟婆汤，能忘记所有的烦恼。\n小明：喝之前我能提个小小的愿望吗？\n孟婆：好，你说。\n小明：能加多点肉么！\n孟婆：%@%#**&！！",
                       @"少年，我看你天庭饱满，地阁方圆，定非池中之物哇。”\n“大爷，谢谢您勒，不过您能不能先搭把手，先把我从池塘里拉上去…。”",
                       @"早上叫了个滴滴专车，司机给我聊了他的人生观，他说：我有房子，有车，有自己的生意，自己当老板，多么自由。除了天王老子谁也命令不了他。我说：前面那条路左拐。他说：好的",
                       @"周末在家在打英雄联盟，忽接到快递小哥电话“在家吗，出来拿下快递”。我“你等会，打团呢，就一波了”。10分钟后开门他还在，就给了我一个眼神，拆快递的时候看到上面写“少壮不努力长大干快递”",
                       @"大河向东流啊。霸气的汉子没男友啊。诶嘿诶嘿没男友啊。一人两份全家桶啊。说走咱就走啊。洗澡化妆都木有啊。诶嘿诶嘿都木有啊。又不是相亲怕个求啊。胸若平湖一声吼啊。面有惊雷抓小偷啊。煤气自己扛五楼啊。嘿～嘿～嘿哟嘿嘿。嘿～嘿～嘿哟嘿嘿",
                       @"“ 老师问：“有钱，任性”的下联是？”\n小明答：“没钱，认命”。 老师哑然！\n“用一句话形容现代男人的婚后生活！”\n小明：“娶了个祖宗生了个爹！” 老师再问：“古代女人为什么要裹脚？”\n小明大声道：“怕她们逛街”。\n老师接着问：“那么为什么现在不裹了”\n小明继续回答：“现在有了支付宝，裹脚也没用。”\n老师：“来来来…小逼崽子你讲课吧！",
                       @"今天股市暴跌，妹子直接亏了二百多万，打开窗户想跳楼，再想想总得换件漂亮衣裳吧。\n短裙？怕走光；长裤？不飘逸；白衣？染血难看；红衣？太像厉鬼…\n好容易挑了一身紫花长裙穿妥，大盘已经涨回来了，还赚了好几万。\n好险，幸亏是女人",
                       @"程序员相亲，说：我是程序员。美女：程先生你好。程序员：叫我序员就好了\n架构师相亲，说：我是架构师。美女：贾先生你好。架构师：叫我狗屎就好了"
                       ];
    
    return list;
}

- (NSString *)getAnyObject
{
    NSInteger index = (random()%10000)%self.itemList.count;
    
    return self.itemList[index];
}


@end
