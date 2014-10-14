if ( GetLocale() == "zhCN" ) then

------------ TEXT VARIABLEN
--Color
local GREY = "|cff999999";
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local YELLOW = "|cffffff00";

--*********************
-- Options translation
--*********************
AQHelpText = ""..WHITE.."命令格式为： /aq or atlasquest "..YELLOW.."[命令参数]"..WHITE.."\n命令参数有: help; option/config; show/hide; left/right; colour; autoshow"..RED.."(仅 Atlas)"
--
AQOptionsCaptionTEXT = "AtlasQuest 选项";
AQ_OK = "OK"
-- autoshow
AQOptionsAutoshowTEXT = ""..WHITE.."伴随"..RED.."Atlas"..WHITE.."打开 AtlasQuest 面板。";
AQAtlasAutoON = "当你打开Atlas时，AtlasQuest面板现在会自动显示"..GREEN.."(默认)"
AQAtlasAutoOFF = "当你打开Atlas时，AtlasQuest面板"..RED.."不会"..WHITE.."自动显示"
-- right/left
AQOptionsLEFTTEXT = ""..WHITE.."Show the AtlasQuest panel "..RED.."left"..WHITE..".";
AQOptionsRIGHTTEXT = ""..WHITE.."Show the AtlasQuest panel "..RED.."right"..WHITE..".";
AQShowRight = "现在在右侧显示AtlasQuest面板";
AQShowLeft = "现在在左侧显示AtlasQuest面板（默认）";
-- Colour Check
AQOptionsCCTEXT = ""..WHITE.."根据任务等级显示任务颜色。"
AQCCON = "AtlasQuest 现在根据任务等级显示任务颜色。"
AQCCOFF = "AtlasQuest 现在不根据任务等级显示任务颜色。"
-- QuestLog Colour Check
AQQLColourChange = ""..WHITE.."将你任务日志里有的的任务染成"..BLUE.."蓝色。"
-- Set Fraction Option
AQOptionsSetFractionTEXT = "" .. WHITE .. "当你打开AtlasQuest时，默认显示为" .. BLUE .. "联盟部分";
-- Set Equip Compare
AQOptionEquipCompareTEXT = "使用Equip Compare"

AQFinishedTEXT = "已完成的任务：";
AQSERVERASKInformation = "按右键察看物品窗口。"
AQSERVERASK = "在服务器上搜寻: "
AQOptionB = "选项"
AQStoryB = "任务背景"
AQNoReward = "没有奖励"
AQERRORNOTSHOWN = "此物品不安全！"
AQERRORASKSERVER = "要按右键在服务器上查询吗？你可能会掉线。"
AQDiscription_OR = "|cffff0000 或 "..WHITE..""
AQDiscription_AND = "|cff008000 和 "..WHITE..""
AQDiscription_REWARD = "奖励回报："
AQDiscription_ATTAIN = "获得任务："
AQDiscription_LEVEL = "需要等级："
AQDiscription_START = "开始地点：\n"
AQDiscription_AIM = "任务目标：\n"
AQDiscription_NOTE = "任务注释：\n"
AQDiscription_PREQUEST= "前导任务："
AQDiscription_FOLGEQUEST = "后续任务："
ATLAS_VERSIONWARNINGTEXT = "你的Atlas是老板本的！请先升级它 :) （最新版本为1.8.1）"

-- ITEM TRANSLATION
AQITEM_DAGGER = "匕首"
AQITEM_SWORD = "剑"
AQITEM_AXE = "斧"
AQITEM_WAND = "魔杖"
AQITEM_STAFF = "法杖"
AQITEM_MACE = "锤"
AQITEM_SHIELD = "盾"
AQITEM_BOWS = "弓"
AQITEM_CROSSBOWS = "弩"
AQITEM_GUN = "枪"

AQITEM_WAIST = "腰"
AQITEM_SHOULDER = "肩"
AQITEM_CHEST = "胸"
AQITEM_LEGS = "腿"
AQITEM_HANDS = "手"
AQITEM_FEET = "脚"
AQITEM_WRIST = "腕"
AQITEM_HEAD = "头"
AQITEM_BACK = "背"

AQITEM_CLOTH = "布甲"
AQITEM_LEATHER = "皮甲"
AQITEM_MAIL = "锁甲"
AQITEM_PLATE = "板甲"

AQITEM_OFFHAND = "副手"
AQITEM_MAINHAND = "主手"
AQITEM_ONEHAND = "单手"
AQITEM_TWOHAND = "双手"

AQITEM_TRINKET = "饰品"
AQITEM_POTION = "药水"
AQITEM_OFFHAND = "握在手里"
AQITEM_NECK = "颈"
AQITEM_PATTERN = "图样"
AQITEM_BAG = "背包"
AQITEM_RING = "戒指"
AQITEM_KEY = "钥匙"
--------------DEADMINES/Inst1 ( 5 Quests)------------
Inst1Story = "这里曾经是人类最主要的产金地，希望矿井在部落第一次大战期间席卷暴风城的时候被废弃。现在迪菲亚兄弟会的人占据了那里并将这个黑暗的通道转变成他们的避难所。据说那些盗贼已经劝说了聪明的地精帮助他们在矿井的深处建造一些可怕的东西——但是没有人知道这是真的还是假的。有传言说，死亡矿井的入口在安宁的月溪镇中。"
Inst1Caption = "死亡矿井"
Inst1QAA = "5 任务" -- how much quest for alliance
Inst1QAH = "无任务" -- for horde

testid = "19135"
--QUEST1 Allianz

Inst1Quest1 = "1. 红色丝质面罩"
Inst1Quest1_Level = "17"
Inst1Quest1_Attain = "12"
Inst1Quest1_Aim = "给哨兵岭哨塔的哨兵瑞尔带回10条红色丝质面罩。."
Inst1Quest1_Location = "哨兵瑞尔 <人民军> (西部荒野 - 哨兵岭; "..YELLOW.."56, 47"..WHITE..")"
Inst1Quest1_Note = "你可以在副本内外的矿工身上找到红色丝质面罩。"
Inst1Quest1_Prequest = "无"
Inst1Quest1_Folgequest = "无"
--
Inst1Quest1name1 = "结实的短剑"
Inst1Quest1name2 = "贝雕匕首"
Inst1Quest1name3 = "破甲之斧"

--Quest 2 allianz

Inst1Quest2 = "2. 收集记忆"
Inst1Quest2_Level = "18"
Inst1Quest2_Attain = "?"
Inst1Quest2_Aim = "给暴风城的维尔德·蓟草带回4张矿业工会会员卡。"
Inst1Quest2_Location = "维尔德·蓟草 (暴风城; "..YELLOW.."65, 21"..WHITE.." )"
Inst1Quest2_Note = "就在你刚要进入副本之前的亡灵（精英）掉落矿工工会会员卡。"
Inst1Quest2_Prequest = "无"
Inst1Quest2_Folgequest = "无"
--
Inst1Quest2name1 = "掘地工之靴"
Inst1Quest2name2 = "陈旧的矿工手套"
--Quest 3 allianz

Inst1Quest3 = "3. 我的兄弟……"
Inst1Quest3_Level = "20"
Inst1Quest3_Attain = "?"
Inst1Quest3_Aim = "将工头希斯耐特的探险者协会徽章交给暴风城的维尔德·蓟草。"
Inst1Quest3_Location = "维尔德·蓟草 (暴风城; "..YELLOW.."65,21"..WHITE.." )"
Inst1Quest3_Note = "就在你刚要进入副本之前的亡灵（精英）掉落矿工工会会员卡。"
Inst1Quest3_Prequest = "无"
Inst1Quest3_Folgequest = "无"
--
Inst1Quest3name1 = "矿工的报复"

--Quest 4 allianz

Inst1Quest4 = "4. 地底突袭"
Inst1Quest4_Level = "20"
Inst1Quest4_Attain = "15"
Inst1Quest4_Aim = "从死亡矿井中带回小型高能发动机，将其带给暴风城矮人区中的沉默的舒尼。"
Inst1Quest4_Location = "沉默的舒尼 (暴风城; "..YELLOW.."55,12"..WHITE.." )"
Inst1Quest4_Note = "你可以从诺恩那里接到此任务的前导任务 (暴风城; 69,50)。\n斯尼德的伐木机掉落小型高能发动机，位置在 [3]。"
Inst1Quest4_Prequest = "有，沉默的舒尼"
Inst1Quest4_Folgequest = "无"
Inst1Quest4PreQuest = "true"
--
Inst1Quest4name1 = "极地护手"
Inst1Quest4name2 = "紫貂魔杖"

--Quest 5 allianz

Inst1Quest5 = "5. 迪菲亚兄弟会 (系列任务)"
Inst1Quest5_Level = "22"
Inst1Quest5_Attain = "14"
Inst1Quest5_Aim = "杀死艾德温·范克里夫，把他的头交给格里安·斯托曼。"
Inst1Quest5_Location = "格里安·斯托曼 (西部荒野 - 哨兵岭 "..YELLOW.."56,47 "..WHITE..")"
Inst1Quest5_Note = "此系列任务开始于 格里安·斯托曼 (西部荒野 - 哨兵岭; 56,47)。\n艾德温·范克里夫是死亡矿井的最后一个Boss。你可以在他的船的最上层找到他，位置在 [6]。"
Inst1Quest5_Prequest = "有，迪菲亚兄弟会"
Inst1Quest5_Folgequest = "有，未寄出的信"
Inst1Quest5PreQuest = "true"
--
Inst1Quest5name1 = "西部荒野马裤"
Inst1Quest5name2 = "西部荒野外套"
Inst1Quest5name3 = "西部荒野法杖"

--Quest 6 allianz

Inst1Quest6 = "6. 正义试炼 (圣骑士专属任务)"
Inst1Quest6_Level = "22"
Inst1Quest6_Attain = "20"
Inst1Quest6_Aim = "按照乔丹的武器材料单上的说明去寻找一些白石橡木、精炼矿石、乔丹的铁锤和一块科尔宝石，然后回到铁炉堡去见乔丹·斯迪威尔。"
Inst1Quest6_Location = "乔丹·斯迪威尔(丹莫罗 - 铁炉堡 "..YELLOW.."52,36 "..WHITE..")"
Inst1Quest6_Note = "点击 [The Test of Righteousness Information] 查看乔丹的武器材料单。"
Inst1Quest6_Prequest = "有，勇气之书 > 正义试炼"
Inst1Quest6_Folgequest = "有，正义试炼"
--
Inst1Quest6name1 = "维里甘之拳 "
Inst1Quest6_Page = {2, "只有圣骑士们才能接到这个任务！\n1. 你可以从地精木匠那儿得到白石橡木[死亡矿井]。\n2. 要得到精炼矿石，你必须先与白洛尔·石手交谈 (洛克莫丹; 35,44 )。他会给你《白洛尔的矿石》任务。 你在一棵树后面找到乔丹的矿石（71,21）。 \n3. 你可以在 [影牙城堡] 紧靠 [B] 的地方找到乔丹的铁锤(安全地点)。\n4. 要得到科尔宝石，你必须去找 桑迪斯·织风 (黑海岸; 37,40) 并且做完《寻找科尔宝石》任务。为了完成这个任务，你必须杀掉[黑暗深渊]前的 黑暗深渊智者 或者 黑暗深渊海潮祭司。他们会掉落被污染的科尔宝石。桑迪斯·织风会为你清洁它的。", };

--------------WaillingCaverns/HDW ( 7 quests)------------
Inst2Story = "最近一个名叫纳拉雷克斯的暗夜精灵德鲁伊在贫瘠之地中的地下发现了一个错综复杂的洞穴网。这个被称作“哀嚎洞穴”的地方有很多的蒸汽缝隙，所以当蒸气喷射的时候发出的声音就犹如哀嚎一般，其因此而得名。纳拉雷克斯可以利用洞穴中的温泉来恢复贫瘠之地的生态，让这里重新获得生机——但是这样做需要吸收传说中的翡翠梦境的能量。一旦和翡翠梦境相连接，德鲁伊的视线中就变成了一场噩梦。不久之后，哀嚎洞穴开始变化——洞中的水开始腐化——曾经温顺的生物开始变成狂暴，致命的捕食者。据说纳拉雷克斯自己还居住在这个迷宫的最深处，他被翡翠梦境的边缘所困扰着。即使他以前的随从也被他们的主人所经历的噩梦所腐化——他们都变成了邪恶的尖牙德鲁伊。"
Inst2Caption = "哀嚎洞穴(WC)"
Inst2QAA = "5 任务"
Inst2QAH = "7 任务"
--QUEST 1 Alliance

Inst2Quest1 = "1. 变异皮革"
Inst2Quest1_Level = "17"
Inst2Quest1_Attain = "?"
Inst2Quest1_Aim = "哀嚎洞穴的纳尔帕克想要20张变异皮革。"
Inst2Quest1_Location = "纳尔帕克 (贫瘠之地 - 哀嚎洞穴; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_Note = "每个副本前面或里面的变异的怪都可能掉落变异皮革。纳尔帕克在入口上方的山顶洞穴里。"
Inst2Quest1_Prequest = "无"
Inst2Quest1_Folgequest = "无"
--
Inst2Quest1name1 = "光滑的蛇鳞护腿"
Inst2Quest1name2 = "变异皮包"


--QUEST 2 Allianz

Inst2Quest2 = "2. 港口的麻烦"
Inst2Quest2_Level = "18"
Inst2Quest2_Attain = "14"
Inst2Quest2_Aim = "棘齿城的起重机操作员比戈弗兹让你从疯狂的马格利什那儿取回一瓶99年波尔多陈酿，疯狂的马格利什就藏在哀嚎洞穴里。"
Inst2Quest2_Location = "起重机操作员比戈弗兹 (贫瘠之地 - 棘齿城; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_Note = "你进入副本杀死疯狂的马格利什，拿到酒瓶。当你进入洞穴后向右转，他就在一个凹进去的洞里。赶快，他很小而且是隐形的（潜行）。刷新时间超过３０分钟，所以最好组满队杀 (18 级精英) 。"
Inst2Quest2_Prequest = "无"
Inst2Quest2_Folgequest = "无"

--QUEST 3 Allianz

Inst2Quest3 = "3. 智慧饮料"
Inst2Quest3_Level = "18"
Inst2Quest3_Attain = "?"
Inst2Quest3_Aim = "收集6份哀嚎香精，把它们交给棘齿城的麦伯克·米希瑞克斯。"
Inst2Quest3_Location = "麦伯克·米希瑞克斯 (贫瘠之地 - 棘齿城; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest3_Note = "此任务的前导任务也是在麦伯克·米希瑞克斯这儿接到的。\n软浆怪掉落香精。"
Inst2Quest3_Prequest = "有，迅猛龙角"
Inst2Quest3_Folgequest = "无"
Inst2Quest3PreQuest = "true"

--QUEST 4 horde

Inst2Quest4 = "4. 清除变异者"
Inst2Quest4_Level = "21"
Inst2Quest4_Attain = "?"
Inst2Quest4_Aim = "哀嚎洞穴的厄布鲁要求你杀掉7只变异破坏者、7只剧毒飞蛇、7只变异蹒跚者和7只变异尖牙风蛇。"
Inst2Quest4_Location = "厄布鲁 (贫瘠之地 - 哀嚎洞穴; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest4_Note = "厄布鲁在入口上方山顶的洞穴里。"
Inst2Quest4_Prequest = "无"
Inst2Quest4_Folgequest = "无"
--
Inst2Quest4name1 = "图样：蛇鳞腰带"
Inst2Quest4name2 = "烧灼之棒"
Inst2Quest4name3 = "达格米尔护手   "

--QUEST 5 Allianz

Inst2Quest5 = "5. 发光的碎片"
Inst2Quest5_Level = "25"
Inst2Quest5_Attain = "21"
Inst2Quest5_Aim = "去棘齿城寻找更多有关这块噩梦碎片的信息。"
Inst2Quest5_Location = "发光的碎片(掉落) (哀嚎洞穴)"
Inst2Quest5_Note = "当你杀死了最后的Boss吞噬者穆坦努斯后，你就会得到发光的碎片。而只有当你杀死了4个德鲁伊，并完成护送德鲁伊(位置在入口[9])任务后，吞噬者穆坦努斯才会出现。\n当你拿到碎片后，你必须把它带回棘齿城，然后返回哀嚎洞穴外面山顶找到菲拉·古风。注意：去棘齿城找个地精说话，（就是做《什么什么平衡器》那个任务的地精），他头上是没有问号的，要自己去点他。"
Inst2Quest5_Prequest = "无"
Inst2Quest5_Folgequest = "有，在噩梦中"
--
Inst2Quest5name1 = "塔巴尔护肩   "
Inst2Quest5name2 = "泥潭沼泽长靴"


--QUEST 1 horde

Inst2Quest1_HORDE = "1. 变异皮革"
Inst2Quest1_HORDE_Level = "17"
Inst2Quest1_HORDE_Attain = "?"
Inst2Quest1_HORDE_Aim = "哀嚎洞穴的纳尔帕克想要20张变异皮革。"
Inst2Quest1_HORDE_Location = "纳尔帕克 <纳拉雷克斯的信徒> (贫瘠之地 - 哀嚎洞穴; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_HORDE_Note = "副本内外的变异的怪物都会掉变异皮革。纳尔帕克在绿洲旁的入口上方的山洞里，不要从入口进入，要从外面绕道山上。"
Inst2Quest1_HORDE_Prequest = "无"
Inst2Quest1_HORDE_Folgequest = "无"
--
Inst2Quest1name1_HORDE = "光滑的蛇鳞护腿"
Inst2Quest1name2_HORDE = "变异皮包"

--QUEST 2 horde

Inst2Quest2_HORDE = "2. 港口的麻烦"
Inst2Quest2_HORDE_Level = "18"
Inst2Quest2_HORDE_Attain = "14"
Inst2Quest2_HORDE_Aim = "棘齿城的起重机操作员比戈弗兹让你从疯狂的马格利什那儿取回一瓶99年波尔多陈酿，疯狂的马格利什就藏在哀嚎洞穴里。"
Inst2Quest2_HORDE_Location = "起重机操作员比戈弗兹 (贫瘠之地 - 棘齿城; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_HORDE_Note = "进入山洞右转，在一个凹槽里，你会很容易发现他的。赶快！他是个隐藏的小地精 (潜行)。"
Inst2Quest2_HORDE_Prequest = "无"
Inst2Quest2_HORDE_Folgequest = "无"

--QUEST 3 horde

Inst2Quest3_HORDE = "3. 毒蛇花"
Inst2Quest3_HORDE_Level = "18"
Inst2Quest3_HORDE_Attain = "14"
Inst2Quest3_HORDE_Aim = "为雷霆崖的药剂师扎玛收集10朵毒蛇花。"
Inst2Quest3_HORDE_Location = "药剂师扎玛 (雷霆崖; "..YELLOW.."22,20 "..WHITE..")"
Inst2Quest3_HORDE_Note = "你可以在药剂师赫布瑞姆处领取前导任务 (贫瘠之地 - 十字路口; "..YELLOW.."51,30"..WHITE..")。\n你可以在山洞里副本前或副本内采到毒蛇花。学习草药学的玩家打开寻找草药技能就可以在自己的小地图上看到毒蛇花的位置。"
Inst2Quest3_HORDE_Prequest = "有, 菌类孢子 -> 药剂师扎玛"
Inst2Quest3_HORDE_Folgequest = "无"
Inst2Quest3PreQuest_HORDE = "true"
--
Inst2Quest3name1_HORDE = "药剂师手套"

--QUEST 4 horde

Inst2Quest4_HORDE = "4. 智慧饮料"
Inst2Quest4_HORDE_Level = "18"
Inst2Quest4_HORDE_Attain = "?"
Inst2Quest4_HORDE_Aim = "收集6份哀嚎香精，把它们交给棘齿城的麦伯克·米希瑞克斯。"
Inst2Quest4_HORDE_Location = "麦伯克·米希瑞克斯 (贫瘠之地 - 棘齿城; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest4_HORDE_Note = "你也是在麦伯克·米希瑞克斯处领取前导任务。\n这种物质可以在西边的哀嚎洞穴里的那些怪物身上找到，去猎捕这种生物，帮麦伯克·米希瑞克斯收集哀嚎香精吧。 "
Inst2Quest4_HORDE_Prequest = "有, 迅猛龙角"
Inst2Quest4_HORDE_Folgequest = "无"
Inst2Quest4PreQuest_HORDE = "true"

--QUEST 5 horde

Inst2Quest5_HORDE = "5. 清除变异者"
Inst2Quest5_HORDE_Level = "21"
Inst2Quest5_HORDE_Attain = "?"
Inst2Quest5_HORDE_Aim = "哀嚎洞穴的厄布鲁要求你杀掉7只变异破坏者、7只剧毒飞蛇、7只变异蹒跚者和7只变异尖牙风蛇。"
Inst2Quest5_HORDE_Location = "厄布鲁 (贫瘠之地; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest5_HORDE_Note = "厄布鲁在哀嚎洞穴入口上方的山洞里。"
Inst2Quest5_HORDE_Prequest = "无"
Inst2Quest5_HORDE_Folgequest = "无"
--
Inst2Quest5name1_HORDE = "图样：蛇鳞腰带"
Inst2Quest5name2_HORDE = "烧灼之棒"
Inst2Quest5name3_HORDE = "达格米尔护手"

--QUEST 6 horde

Inst2Quest6_HORDE = "6. 尖牙德鲁伊(Questline)"
Inst2Quest6_HORDE_Level = "22"
Inst2Quest6_HORDE_Attain = "18"
Inst2Quest6_HORDE_Aim = "将考布莱恩宝石、安娜科德拉宝石、皮萨斯宝石和瑟芬迪斯宝石交给雷霆崖的纳拉·蛮鬃。"
Inst2Quest6_HORDE_Location = "纳拉·蛮鬃 (雷霆崖; "..YELLOW.."75,31 "..WHITE..")"
Inst2Quest6_HORDE_Note = "系列任务始于哈缪尔·符文图腾 (雷霆崖; 78,28)\n掉落宝石的4个德鲁伊位于 [2],[3],[5],[7]"
Inst2Quest6_HORDE_Prequest = "有, 哈缪尔·符文图腾 > 纳拉·蛮鬃 > 尖牙德鲁伊"
Inst2Quest6_HORDE_Folgequest = "无"
Inst2Quest6PreQuest_HORDE = "true"
--
Inst2Quest6name1_HORDE = "新月法杖"
Inst2Quest6name2_HORDE = "翼刃"

--QUEST 7 horde

Inst2Quest7_HORDE = "7. 发光的碎片"
Inst2Quest7_HORDE_Level = "25"
Inst2Quest7_HORDE_Attain = "21"
Inst2Quest7_HORDE_Aim = "到棘齿城去寻找更多有关这块噩梦碎片的信息。"
Inst2Quest7_HORDE_Location = "发光的碎片(掉落) (哀嚎洞穴)"
Inst2Quest7_HORDE_Note = "当你杀死最后的BOSS吞噬者穆坦努斯后，你就能得到发光的碎片。 如果你完成了杀死4个德鲁伊并且护卫门口那个德鲁伊的任务，吞噬者穆坦努斯才会出现。[9]\n当你取得了碎片，你必须带着它返回棘齿城 (去银行旁找那个做什么什么平衡器任务时认识的地精 <工匠协会>斯布特瓦夫), 然后他会指引你返回哀嚎洞穴山顶找菲拉·古风。"
Inst2Quest7_HORDE_Prequest = "无"
Inst2Quest7_HORDE_Folgequest = "有, 在噩梦中"
--
Inst2Quest7name1_HORDE = "塔巴尔护肩"
Inst2Quest7name2_HORDE = "泥潭沼泽长靴"


--------------Uldaman/Inst4 ( 16 quests)------------
Inst4Story = "奥达曼是古代泰坦创世之时所留下的深埋于地下的城市。矮人探险队最近发觉到了这块被遗忘的城市，将泰坦一款失败的创造物：食腭怪唤醒了。传说说泰坦是从石头中创造了食腭怪。当实施证明这次试验很失败的时候，泰坦把食腭怪锁了起来并进行了第二次的尝试——最终创造了矮人这个种族。矮人创造的秘密被记录在精密的白金圆盘中——那是位于古代城市最底部的大型泰坦遗迹。最近，黑铁矮人在奥达曼进行了一系列的侵入活动，希望为他们的火焰之主拉格纳罗斯获得圆盘。然而，在这个地下城市中，有一些巨大的石头守卫会攻击任何入侵者。而白金圆盘是由一名巨大的石头守卫阿扎达斯。有传言说矮人的一些石头皮肤的祖先，土灵还居住在城市的隐蔽之处。"
Inst4Caption = "奥达曼"
Inst4QAA = "16 任务"
Inst4QAH = "10 任务"

--QUEST 1 Allianz

Inst4Quest1 = "1. 一线希望"
Inst4Quest1_Level = "35"
Inst4Quest1_Attain = "35"
Inst4Quest1_Aim = "在奥达曼找到铁趾格雷兹。"
Inst4Quest1_Location = "勘察员雷杜尔 (荒芜之地; "..YELLOW.."53,43 "..WHITE..")"
Inst4Quest1_Note = "前导任务始于 弄皱的地图 (荒芜之地; 53,33)。\n你可以在进入副本前找到铁趾格雷兹 (北, 西)。"
Inst4Quest1_Prequest = "有，一线希望"
Inst4Quest1_Folgequest = "有，铁趾的护符"
Inst4Quest1PreQuest = "true"

--QUEST 2 Allianz

Inst4Quest2 = "2. 铁趾的护符"
Inst4Quest2_Level = "40"
Inst4Quest2_Attain = "?"
Inst4Quest2_Aim = "找到铁趾的护符，把它交给奥达曼的铁趾。"
Inst4Quest2_Location = "铁趾格雷兹 (奥达曼 - 副本前)"
Inst4Quest2_Note = "护符在副本入口的北方，进入副本之前的通道东部尽头。"
Inst4Quest2_Prequest = "有，一线希望"
Inst4Quest2_Folgequest = "有，铁趾的遗愿"
Inst4Quest2FQuest = "true"


--QUEST 3 Allianz

Inst4Quest3 = "3. 意志石板"
Inst4Quest3_Level = "45"
Inst4Quest3_Attain = "38"
Inst4Quest3_Aim = "找到意志石板，把它们交给铁炉堡的顾问贝尔格拉姆。"
Inst4Quest3_Location = "顾问贝尔格拉姆 (铁炉堡; "..YELLOW.."77,10 "..WHITE..")"
Inst4Quest3_Note = "石板位置在 [8]。"
Inst4Quest3_Prequest = "有，铁趾的遗愿 -> 邪恶的使者"
Inst4Quest3_Folgequest = "无"
Inst4Quest3FQuest = "true"
--
Inst4Quest3name1 = "勇气勋章 "

--QUEST 4 Allianz

Inst4Quest4 = "4. 能量石"
Inst4Quest4_Level = "36"
Inst4Quest4_Attain = "?"
Inst4Quest4_Aim = "给荒芜之地的里格弗兹带去8块德提亚姆能量石和8块安纳洛姆能量石。"
Inst4Quest4_Location = "里格弗兹 (荒芜之地; "..YELLOW.."42,52 "..WHITE..")"
Inst4Quest4_Note = "能量石可以在副本内外的暗炉敌人身上找到。"
Inst4Quest4_Prequest = "无"
Inst4Quest4_Folgequest = "无"
--
Inst4Quest4name1 = "能量石环"
Inst4Quest4name2 = "杜拉辛护腕"
Inst4Quest4name3 = "持久长靴"

--QUEST 5 Allianz

Inst4Quest5 = "5. 阿戈莫德的命运"
Inst4Quest5_Level = "38"
Inst4Quest5_Attain = "38"
Inst4Quest5_Aim = "收集4个雕纹石罐，把它们交给洛克莫丹的勘察员基恩萨·铁环。"
Inst4Quest5_Location = "勘察员基恩萨·铁环 (洛克莫丹; "..YELLOW.."65,65 "..WHITE..")"
Inst4Quest5_Note = "前导任务始于勘察员塔伯斯·雷矛 (铁炉堡; 74,12)。\n雕纹石罐散布于副本前的山洞里。"
Inst4Quest5_Prequest = "有，铁环挖掘场需要你！! -> 莫达洛克"
Inst4Quest5_Folgequest = "无"
Inst4Quest5PreQuest = "true"
--
Inst4Quest5name1 = "勘察者手套"

--QUEST 6 Allianz

Inst4Quest6 = "6. Solution to Doom"
Inst4Quest6_Level = "40"
Inst4Quest6_Attain = "31"
Inst4Quest6_Aim = "把雷乌纳石板带给迷失者塞尔杜林。"
Inst4Quest6_Location = "迷失者塞尔杜林 (荒芜之地; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest6_Note = "石板在进入副本前的洞穴北部，通道的东部尽头。"
Inst4Quest6_Prequest = "无"
Inst4Quest6_Folgequest = "有，远赴铁炉堡"
--
Inst4Quest6name1 = "末日预言者长袍"

--QUEST 7 Allianz

Inst4Quest7 = "7. 失踪的矮人"
Inst4Quest7_Level = "40"
Inst4Quest7_Attain = "?"
Inst4Quest7_Aim = "在奥达曼找到巴尔洛戈。"
Inst4Quest7_Location = "勘察员塔伯斯·雷矛 (铁炉堡; "..YELLOW.."46,12 "..WHITE..")"
Inst4Quest7_Note = "巴尔洛戈 在 [1]。"
Inst4Quest7_Prequest = "无"
Inst4Quest7_Folgequest = "有，密室"

--QUEST 8 Allianz

Inst4Quest8 = "8. 密室"
Inst4Quest8_Level = "40"
Inst4Quest8_Attain = "?"
Inst4Quest8_Aim = "阅读巴尔洛戈的日记，探索密室，然后向铁炉堡的勘察员塔伯斯·雷矛汇报。"
Inst4Quest8_Location = "巴尔洛戈 (奥达曼 - [1])"
Inst4Quest8_Note = "密室 在 [4]."
Inst4Quest8_Prequest = "有，失踪的矮人"
Inst4Quest8_Folgequest = "无"
Inst4Quest8FQuest = "true"
--
Inst4Quest8name1 = "矮人冲锋斧"
Inst4Quest8name2 = "探险者联盟徽章"

--QUEST 9 Allianz

Inst4Quest9 = "9. 破碎的项链"
Inst4Quest9_Level = "41"
Inst4Quest9_Attain = "37"
Inst4Quest9_Aim = "找到破碎的项链的来源，从而了解其潜在的价值。"
Inst4Quest9_Location = "破碎的项链 (随机掉落) (奥达曼)"
Inst4Quest9_Note = "把项链带给铁炉堡的塔瓦斯德·基瑟尔 (36,3)"
Inst4Quest9_Prequest = "无"
Inst4Quest9_Folgequest = "有，昂贵的知识"

--QUEST 10 Allianz

Inst4Quest10 = "10. 回到奥达曼"
Inst4Quest10_Level = "41"
Inst4Quest10_Attain = "37"
Inst4Quest10_Aim = "去奥达曼寻找塔瓦斯的魔法项链，被杀的圣骑士是最后一个拿着它的人。"
Inst4Quest10_Location = "塔瓦斯德·基瑟尔 (铁炉堡; "..YELLOW.."36,3 "..WHITE..")"
Inst4Quest10_Note = "圣骑士 在 [2]."
Inst4Quest10_Prequest = "有，昂贵的知识"
Inst4Quest10_Folgequest = "有，寻找宝石"

--QUEST 11 Allianz

Inst4Quest11 = "11. 寻找宝石"
Inst4Quest11_Level = "43"
Inst4Quest11_Attain = "37"
Inst4Quest11_Aim = "在奥达曼寻找红宝石、蓝宝石和黄宝石的下落。找到它们之后，通过塔瓦斯德给你的占卜之瓶和他进行联系。"
Inst4Quest11_Location = "圣骑士的遗体 (奥达曼)"
Inst4Quest11_Note = "宝石在[1], [8], 和 [9]."
Inst4Quest11_Prequest = "有，回到奥达曼"
Inst4Quest11_Folgequest = "有，修复项链"
Inst4Quest11FQuest = "true"

--QUEST 12 Allianz

Inst4Quest12 = "12. 修复项链"
Inst4Quest12_Level = "44"
Inst4Quest12_Attain = "38"
Inst4Quest12_Aim = "从奥达曼最强大的石人身上获得能量源，然后将其交给铁炉堡的塔瓦斯德。"
Inst4Quest12_Location = "塔瓦斯德的占卜之碗"
Inst4Quest12_Note = "破碎项链的能量源在阿扎达斯掉落 [10]."
Inst4Quest12_Prequest = "有，寻找宝石"
Inst4Quest12_Folgequest = "无"-- AUFPASSEN HIER IS EIN FOLGEQUEST ABER ES GIBT NUR BELOHNUNG!
--
Inst4Quest12name1 = "塔瓦斯德的魔法项链"
Inst4Quest12FQuest = "true"

--QUEST 13 Allianz

Inst4Quest13 = "13. 奥达曼的蘑菇"
Inst4Quest13_Level = "42"
Inst4Quest13_Attain = "38"
Inst4Quest13_Aim = "收集12颗紫色蘑菇，把它们交给塞尔萨玛的加克。"
Inst4Quest13_Location = "加克 (洛克莫丹 - 塞尔萨玛; "..YELLOW.."37,49 "..WHITE..")"
Inst4Quest13_Note = "蘑菇散布于副本各处。"
Inst4Quest13_Prequest = "无"
Inst4Quest13_Folgequest = "无"
--
Inst4Quest13name1 = "滋补药剂"

--QUEST 14 Allianz

Inst4Quest14 = "14. Reclaimed Treasures"
Inst4Quest14_Level = "43"
Inst4Quest14_Attain = "?"
Inst4Quest14_Aim = "到奥达曼的北部大厅去找到克罗姆·粗臂的箱子，从里面拿出他的宝贵财产，然后回到铁炉堡把东西交给他。"
Inst4Quest14_Location = "克罗姆·粗臂 (铁炉堡; "..YELLOW.."74,9 "..WHITE..")"
Inst4Quest14_Note = "你在进入副本前就找到克罗姆·粗臂的财产。它就在洞穴的北部，第一个通道的东南角尽头。"
Inst4Quest14_Prequest = "无"
Inst4Quest14_Folgequest = "无"

--QUEST 15 Allianz

Inst4Quest15 = "15. 白金圆盘"
Inst4Quest15_Level = "45"
Inst4Quest15_Attain = "40"
Inst4Quest15_Aim = "和石头守护者交谈，从他那里了解更多古代的知识。一旦你了解到了所有的内容之后就激活诺甘农圆盘。 -> 把迷你版的诺甘农圆盘带到铁炉堡的探险者协会去。"
Inst4Quest15_Location = "诺甘农圆盘 (奥达曼 - [11])"
Inst4Quest15_Note = "接到任务后，和石头守护者交谈左边的盘子。然后再次使用白金圆盘，取得缩小版的圆盘， 并把缩小版的白金圆盘带给铁炉堡的资深探险家麦格拉斯 (69,18)。"
Inst4Quest15_Prequest = "无"
Inst4Quest15_Folgequest = "无"
--
Inst4Quest15name1 = "软皮袋"
Inst4Quest15name2 = "超强治疗药水"
Inst4Quest15name3 = "强效法力药水 "

--QUEST 16 Allianz

Inst4Quest16 = "16. 奥达曼的能量源 (法是专属任务)"
Inst4Quest16_Level = "40"
Inst4Quest16_Attain = "35"
Inst4Quest16_Aim = "找到一个黑曜石能量源，将其交给尘泥沼泽的塔贝萨。"
Inst4Quest16_Location = "塔贝萨 (尘泥沼泽; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest16_Note = "这个任务只能法师做！\n黑曜石哨兵 [5] 掉落黑曜石能量源。"
Inst4Quest16_Prequest = "有，驱除魔鬼"
Inst4Quest16_Folgequest = "有，法力怒灵"
Inst4Quest16PreQuest = "true"

--QUEST 1 Horde

Inst4Quest1_HORDE = "1. 能量石"
Inst4Quest1_HORDE_Level = "36"
Inst4Quest1_HORDE_Attain = "?"
Inst4Quest1_HORDE_Aim = "给荒芜之地的里格弗兹带去8块德提亚姆能量石和8块安纳洛姆能量石。"
Inst4Quest1_HORDE_Location = "里格弗兹 (荒芜之地; "..YELLOW.."42:52 "..WHITE..")"
Inst4Quest1_HORDE_Note = "能量石可以在副本前面或里面的暗炉敌人那里找到。"
Inst4Quest1_HORDE_Prequest = "无"
Inst4Quest1_HORDE_Folgequest = "无"
--
Inst4Quest1name1_HORDE = "能量石环"
Inst4Quest1name2_HORDE = "杜拉辛护腕"
Inst4Quest1name3_HORDE = "持久长靴"

--QUEST 2 Horde

Inst4Quest2_HORDE = "2. 化解灾难"
Inst4Quest2_HORDE_Level = "40"
Inst4Quest2_HORDE_Attain = "31"
Inst4Quest2_HORDE_Aim = "把雷乌纳石板带给迷失者塞尔杜林。 "
Inst4Quest2_HORDE_Location = "迷失者塞尔杜林 (荒芜之地; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest2_HORDE_Note = "石板在洞穴的北部，一条通道的东面尽头，副本前面。"
Inst4Quest2_HORDE_Prequest = "无"
Inst4Quest2_HORDE_Folgequest = "有, ？？To 铁炉堡 for Yagyin's Digest（估计有问题）"
--
Inst4Quest2name1_HORDE = "末日预言者长袍"

--QUEST 3 Horde

Inst4Quest3_HORDE = "3. 搜寻项链"
Inst4Quest3_HORDE_Level = "41"
Inst4Quest3_HORDE_Attain = "37"
Inst4Quest3_HORDE_Aim = "在奥达曼挖掘场中寻找一条珍贵的项链，然后将其交给奥格瑞玛的德兰·杜佛斯。项链有可能已经损坏。 "
Inst4Quest3_HORDE_Location = "德兰·杜佛斯 (奥格瑞玛; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest3_HORDE_Note = "项链在副本里是随机掉落的。"
Inst4Quest3_HORDE_Prequest = "无"
Inst4Quest3_HORDE_Folgequest = "有, 搜寻项链，再来一次"

--QUEST 4 Horde

Inst4Quest4_HORDE = "4. 搜寻项链，再来一次"
Inst4Quest4_HORDE_Level = "41"
Inst4Quest4_HORDE_Attain = "38"
Inst4Quest4_HORDE_Aim = "在奥达曼里找寻宝石的线索。"
Inst4Quest4_HORDE_Location = "德兰·杜佛斯 (奥格瑞玛; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest4_HORDE_Note = "圣骑士在 [2]."
Inst4Quest4_HORDE_Prequest = "有, 搜寻项链"
Inst4Quest4_HORDE_Folgequest = "有, 翻译日记"
Inst4Quest4FQuest_HORDE = "true"

--QUEST 5 Horde

Inst4Quest5_HORDE = "5. 翻译日记"
Inst4Quest5_HORDE_Level = "42"
Inst4Quest5_HORDE_Attain = "40"
Inst4Quest5_HORDE_Aim = "在荒芜之地的卡加斯哨所里寻找一个可以帮你翻译圣骑士日记的人。"
Inst4Quest5_HORDE_Location = "圣骑士的遗体 (奥达曼 - [2])"
Inst4Quest5_HORDE_Note = "翻译圣骑士日记的人 (加卡尔 Mossmeld) 在卡加斯 (荒芜之地 2,46). -> 将项链借给加卡尔，他帮你翻译日记。"
Inst4Quest5_HORDE_Prequest = "有, 搜寻项链，再来一次"
Inst4Quest5_HORDE_Folgequest = "有, 寻找宝贝"
Inst4Quest5FQuest_HORDE = "true"

--QUEST 6 Horde

Inst4Quest6_HORDE = "6. 寻找宝贝"
Inst4Quest6_HORDE_Level = "44"
Inst4Quest6_HORDE_Attain = "37"
Inst4Quest6_HORDE_Aim = "从奥达曼找回项链上的所有三块宝石和能量源，然后把它们交给卡加斯的加卡尔。\n红宝石被藏在暗影矮人层层设防的地区。\n黄宝石藏在石腭怪活动地区的一个瓮中。\n蓝宝石在格瑞姆洛克手中，他是石腭怪的领袖。\n能量源可能在奥达曼的某个最强生物的手中。"
Inst4Quest6_HORDE_Location = "加卡尔 Mossmeld (荒芜之地; "..YELLOW.."2,46 "..WHITE..")"
Inst4Quest6_HORDE_Note = "红宝石在暗炉矮人手里，黄宝石在石腭怪手里，而蓝宝石则在一个名叫格瑞姆洛克的石腭怪那里 [1], [8], 和 [9]。  破碎项链的能量源从阿扎达斯身上掉落 [10]。"
Inst4Quest6_HORDE_Prequest = "有, 翻译日记。"
Inst4Quest6_HORDE_Folgequest = "有, 交付宝石"
Inst4Quest6FQuest_HORDE = "true"
--
Inst4Quest6name1_HORDE = "加卡尔的强化项链"

--QUEST 7 Horde

Inst4Quest7_HORDE = "7. 奥达曼的蘑菇"
Inst4Quest7_HORDE_Level = "42"
Inst4Quest7_HORDE_Attain = "38"
Inst4Quest7_HORDE_Aim = "收集12颗紫色蘑菇，把它们交给卡加斯的加卡尔。"
Inst4Quest7_HORDE_Location = "加卡尔 Mossmeld (荒芜之地; "..YELLOW.."2,69 "..WHITE..")"
Inst4Quest7_HORDE_Note = "前导任务也是在加卡尔这儿领取。\n蘑菇散布于副本内各处。"
Inst4Quest7_HORDE_Prequest = "有, 荒芜之地的材料"
Inst4Quest7_HORDE_Folgequest = "有, 荒芜之地的材料 II"
Inst4Quest7PreQuest_HORDE = "true"
--
Inst4Quest7name1_HORDE = "滋补药剂"

--QUEST 8 Horde

Inst4Quest8_HORDE = "8. 寻找宝藏"
Inst4Quest8_HORDE_Level = "43"
Inst4Quest8_HORDE_Attain = "?"
Inst4Quest8_HORDE_Aim = "从奥达曼南部大厅的箱子中找到加勒特的家族宝藏，然后把它交给幽暗城的帕特里克·加瑞特。"
Inst4Quest8_HORDE_Location = "帕特里克·加瑞特 (幽暗城; "..YELLOW.."72,48 "..WHITE..")"
Inst4Quest8_HORDE_Note = "你在进入副本之前就会找到加勒特的家族宝藏。它就在南部通道的尽头。"
Inst4Quest8_HORDE_Prequest = "无"
Inst4Quest8_HORDE_Folgequest = "无"


--QUEST 9 Horde

Inst4Quest9_HORDE = "9. 白金圆盘"
Inst4Quest9_HORDE_Level = "45"
Inst4Quest9_HORDE_Attain = "40"
Inst4Quest9_HORDE_Aim = "和石头守护者交谈，从他那里了解更多古代的知识。一旦你了解到了所有的内容之后就激活诺甘农圆盘。 -> 把迷你版的诺甘农圆盘带到雷霆崖的贤者(圣者图希克)那里。"
Inst4Quest9_HORDE_Location = "诺甘农圆盘 (奥达曼 - [11])"
Inst4Quest9_HORDE_Note = "你领取到任务后，和石头守护着交谈盘子的左边。然后再次使用白金圆盘得到迷你版的圆盘，带着它去雷霆崖找圣者图希克 (34,46) "
Inst4Quest9_HORDE_Prequest = "无"
Inst4Quest9_HORDE_Folgequest = "无"
--
Inst4Quest9name1_HORDE = "软皮袋"
Inst4Quest9name2_HORDE = "超强治疗药水"
Inst4Quest9name3_HORDE = "强效法力药水"

--QUEST 10 Horde

Inst4Quest10_HORDE = "10. 奥达曼的能量源 (法师专属)"
Inst4Quest10_HORDE_Level = "40"
Inst4Quest10_HORDE_Attain = "35"
Inst4Quest10_HORDE_Aim = "找到一个黑曜石能量源，将其交给尘泥沼泽的塔贝萨。"
Inst4Quest10_HORDE_Location = "塔贝萨 (尘泥沼泽; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest10_HORDE_Note = "这个任务只有法师可以获得！\n为了得到能量源，你必须到奥达曼去打败那里的黑曜石守卫。他体型巨大而且很难对付，但是你可以从他身上得到我们所需要的能量源！黑曜石能量源从5区的黑曜石守卫身上掉落"
Inst4Quest10_HORDE_Prequest = "有, 驱除魔鬼"
Inst4Quest10_HORDE_Folgequest = "有, 法力怒灵"
Inst4Quest10PreQuest_HORDE = "true"


--------------------------Ragfire ( 5 Quests)
Inst3Story = "怒焰裂谷是一个错综复杂的火焰洞穴，它位于兽人的新都城奥格瑞玛中。最近，有传言说一批崇拜恶魔阴影教的信徒占据了怒焰裂谷。这个被称为火刃的组织对杜隆塔尔的安全。许多人认为兽人的酋长萨尔已经意识到了火刃的存在并不打算摧毁他们，因为萨尔希望能够将他引到阴影议会那里。不管怎么样，黑暗的力量从怒焰裂谷散发出来，它们可能毁了兽人所有的一切。"
Inst3Caption = "怒焰裂谷"
Inst3QAA = "无任务"
Inst3QAH = "5 任务"

--QUEST 1 Horde

Inst3Quest1_HORDE = "1. 试探敌人"
Inst3Quest1_HORDE_Level = "15"
Inst3Quest1_HORDE_Attain = "?"
Inst3Quest1_HORDE_Aim = "在奥格瑞玛找到怒焰裂谷，杀掉8个怒焰穴居人和8个怒焰萨满祭司，然后向雷霆崖的拉哈罗复命。"
Inst3Quest1_HORDE_Location = "拉哈罗 ( 雷霆崖; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest1_HORDE_Note = "你一开始就能找到穴居人。"
Inst3Quest1_HORDE_Prequest = "无"
Inst3Quest1_HORDE_Folgequest = "无"

--QUEST 2 Horde

Inst3Quest2_HORDE = "2. 毁灭之力"
Inst3Quest2_HORDE_Level = "16"
Inst3Quest2_HORDE_Attain = "?"
Inst3Quest2_HORDE_Aim = "将《暗影法术研究》和《扭曲虚空的魔法》这两本书交给幽暗城的瓦里玛萨斯。"
Inst3Quest2_HORDE_Location = "瓦里玛萨斯 ( 幽暗城; "..YELLOW.."56,92 "..WHITE..")"
Inst3Quest2_HORDE_Note = "燃刃信徒和燃刃术士掉落这两本书。"
Inst3Quest2_HORDE_Prequest = "无"
Inst3Quest2_HORDE_Folgequest = "无"
--
Inst3Quest2name1_HORDE = "苍白长裤"
Inst3Quest2name2_HORDE = "泥泞护腿"
Inst3Quest2name3_HORDE = "石像鬼护腿"

--QUEST 3 Horde

Inst3Quest3_HORDE = "3. 寻找背包"
Inst3Quest3_HORDE_Level = "16"
Inst3Quest3_HORDE_Attain = "?"
Inst3Quest3_HORDE_Aim = "在怒焰裂谷搜寻玛尔·恐怖图腾的尸体以及他留下的东西。"
Inst3Quest3_HORDE_Location = "拉哈罗 ( 雷霆崖; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest3_HORDE_Note = "你会在[1]发现玛尔·恐怖图腾。得到背包后你需要把它交回给雷霆崖的拉哈罗。"
Inst3Quest3_HORDE_Prequest = "无"
Inst3Quest3_HORDE_Folgequest = "有, 归还背包"
--
Inst3Quest3name1_HORDE = "羽珠护腕"
Inst3Quest3name2_HORDE = "草原狮护腕"

--QUEST 4 Horde

Inst3Quest4_HORDE = "4. 隐藏的敌人"
Inst3Quest4_HORDE_Level = "16"
Inst3Quest4_HORDE_Attain = "?"
Inst3Quest4_HORDE_Aim = "杀死巴扎兰和祈求者耶戈什，然后返回奥格瑞玛见萨尔"
Inst3Quest4_HORDE_Location = "萨尔 ( 奥格瑞玛; "..YELLOW.."31,37 "..WHITE..")"
Inst3Quest4_HORDE_Note = "你会在 [4] 发现巴扎兰，在 [3] 发现祈求者耶戈什。"
Inst3Quest4_HORDE_Prequest = "有, 隐藏的敌人"
Inst3Quest4_HORDE_Folgequest = "有, 隐藏的敌人"
Inst3Quest4PreQuest_HORDE = "true"
--
Inst3Quest4name1_HORDE = "奥格瑞玛之剑"
Inst3Quest4name2_HORDE = "奥格瑞玛之锤"
Inst3Quest4name3_HORDE = "奥格瑞玛之斧"
Inst3Quest4name4_HORDE = "奥格瑞玛法杖"

--QUEST 5 Horde

Inst3Quest5_HORDE = "5. 饥饿者塔拉加曼"
Inst3Quest5_HORDE_Level = "16"
Inst3Quest5_HORDE_Attain = "?"
Inst3Quest5_HORDE_Aim = "进入怒焰裂谷，杀死饥饿者塔拉加曼，然后把他的心脏交给奥格瑞玛的尼尔鲁·火刃。"
Inst3Quest5_HORDE_Location = "尼尔鲁·火刃 ( 奥格瑞玛; "..YELLOW.."49,50 "..WHITE..")"
Inst3Quest5_HORDE_Note = "你会在 [2] 找到塔拉加曼。"
Inst3Quest5_HORDE_Prequest = "无"
Inst3Quest5_HORDE_Folgequest = "无"

--------------------------Inst27 Zul'Farrak / ZUL
Inst27Story = "日光暴晒下的这座城市是沙怒巨魔的家园，他们一向以来都以其无情和黑暗魔法而闻名。巨魔传说中有一把强大的名叫鞭笞者苏萨斯的武器能够让最弱小的人可以击败最强大的敌人。很久以前，这把武器被分成了两半。然而，有传言说这两半可以在祖尔法拉克任何地方找到。据说还有一批加基森派来的雇佣兵进入了城市并被困住。他们的命运还不得而知。但是也许最让人感到不安的是一头远古生物正沉睡在城市中心的一个神圣的水池中——它是一个半神，它会摧毁任何胆敢唤醒它的人。"
Inst27Caption = "祖尔法拉克(ZF)"
Inst27QAA = "7 任务"
Inst27QAH = "7 任务"

--QUEST 1 Allianz

Inst27Quest1 = "1. 巨魔调和剂"
Inst27Quest1_Level = "45"
Inst27Quest1_Attain = "?"
Inst27Quest1_Aim = "收集20瓶巨魔调和剂，把它们交给加基森的特伦顿·轻锤。"
Inst27Quest1_Location = "特伦顿·轻锤 (塔纳利斯 - 加基森; "..YELLOW.."51,28 "..WHITE..")"
Inst27Quest1_Note = "每个巨魔都可能掉落调和剂"
Inst27Quest1_Prequest = "无"
Inst27Quest1_Folgequest = "无"

--QUEST 2 Allianz

Inst27Quest2 = "2. 圣甲虫的壳"
Inst27Quest2_Level = "45"
Inst27Quest2_Attain = "?"
Inst27Quest2_Aim = "给加基森的特兰雷克带去5个完整的圣甲虫壳。"
Inst27Quest2_Location = "特兰雷克 (塔纳利斯 - 加基森; "..YELLOW.."51,26 "..WHITE..")"
Inst27Quest2_Note = "前导任务始于克拉兹克 (荆棘谷 - 藏宝海湾); 25,77 )。\n每个圣甲虫都可能掉落壳儿。大量圣甲虫集中在 [2]。"
Inst27Quest2_Prequest = "有，特兰雷克"
Inst27Quest2_Folgequest = "无"
Inst27Quest2PreQuest = "true"

--QUEST 3 Allianz

Inst27Quest3 = "3. 深渊皇冠"
Inst27Quest3_Level = "46"
Inst27Quest3_Attain = "40"
Inst27Quest3_Aim = "将深渊皇冠交给尘泥沼泽的塔贝萨。"
Inst27Quest3_Location = "塔贝萨 (尘泥沼泽; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest3_Note = "前导任务从 彬克 (铁炉堡; 25,8)处获得。\n水占师维蕾萨掉落深渊皇冠。你可以在 [6] 找到她。"
Inst27Quest3_Prequest = "有，塔贝萨的任务"
Inst27Quest3_Folgequest = "无"
Inst27Quest3PreQuest = "true"
--
Inst27Quest3name1 = "幻法之杖"
Inst27Quest3name2 = "晶岩肩铠"

--QUEST 4 Allianz

Inst27Quest4 = "4. 耐克鲁姆的徽章 (系列任务)"
Inst27Quest4_Level = "47"
Inst27Quest4_Attain = "40"
Inst27Quest4_Aim = "将耐克鲁姆的徽章交给诅咒之地的萨迪斯·格希德。"
Inst27Quest4_Location = "萨迪斯·格希德 (诅咒之地; "..YELLOW.."66,19 "..WHITE..")"
Inst27Quest4_Note = "此系列任务始于 狮鹫管理员沙拉克·鹰斧 (辛特兰; 9,44)。\n你可以在 [4] 找到耐克鲁姆。"
Inst27Quest4_Prequest = "有，枯木巨魔的牢笼 -> 萨迪斯·格希德"
Inst27Quest4_Folgequest = "有，占卜"
Inst27Quest4PreQuest = "true"

--QUEST 5 Allianz

Inst27Quest5 = "5. 摩沙鲁的预言 (系列任务)"
Inst27Quest5_Level = "47"
Inst27Quest5_Attain = "40"
Inst27Quest5_Aim = "将第一块和第二块摩沙鲁石板交给塔纳利斯的叶基亚。"
Inst27Quest5_Location = "叶基亚 (塔纳利斯 - 热砂港; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_Note = "前导任务也是在这个NPC处获得。\n你会在 [2] 和 [6] 找到两块石板."
Inst27Quest5_Prequest = "有，尖啸者的灵魂"
Inst27Quest5_Folgequest = "有，远古之卵"
Inst27Quest5PreQuest = "true"

--QUEST 6 Allianz

Inst27Quest6 = "6. 探水棒"
Inst27Quest6_Level = "46"
Inst27Quest6_Attain = "?"
Inst27Quest6_Aim = "把探水棒交给加基森的首席工程师沙克斯·比格维兹。"
Inst27Quest6_Location = "比格维兹 (塔纳利斯 - 加基森; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_Note = "你可以从布莱中士那里得到探水棒。你可以在 [4] 神庙找到他。但要在神庙百人战事件后后打败布莱中士，才能得到探水棒。"
Inst27Quest6_Prequest = "无"
Inst27Quest6_Folgequest = "无"
--
Inst27Quest6name1 = "石工兄弟会之戒"
Inst27Quest6name2 = "工程学协会头盔"


--QUEST 7 Allianz

Inst27Quest7 = "7. 加兹瑞拉"
Inst27Quest7_Level = "50"
Inst27Quest7_Attain = "40"
Inst27Quest7_Aim = "把加兹瑞拉的鳞片交给闪光平原的维兹尔·铜栓。"
Inst27Quest7_Location = "维兹尔·铜栓 (千针石林 - 闪光平原; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_Note = "前导任务从 科罗莫特·钢尺(铁炉堡; 68,46)得到。\n你可以在 [6] 召唤加兹瑞拉。"
Inst27Quest7_Prequest = "Yes, The Brassbolts Brothers"
Inst27Quest7_Folgequest = "无"
Inst27Quest7PreQuest = "true"
--
Inst27Quest7name1 = "棍子上的胡萝卜"

--QUEST 1 Horde

Inst27Quest1_HORDE = "1. 蜘蛛之神 (系列任务)"
Inst27Quest1_HORDE_Level = "45"
Inst27Quest1_HORDE_Attain = "42"
Inst27Quest1_HORDE_Aim = "阅读塞卡石板，了解枯木巨魔的蜘蛛之神的名字，然后回到加德林大师那里。"
Inst27Quest1_HORDE_Location = "加德林大师 ( 杜隆塔尔; "..YELLOW.."55,74 "..WHITE..")"
Inst27Quest1_HORDE_Note = "此任务始于毒液瓶任务 (辛特兰，巨魔村庄)。\n你会在 [2] 发现石板。"
Inst27Quest1_HORDE_Prequest = "有, 毒液瓶 -> 完好无损的毒囊 -> 请教加德林大师"
Inst27Quest1_HORDE_Folgequest = "有, 召唤沙德拉"
Inst27Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst27Quest2_HORDE = "2. 巨魔调和剂"
Inst27Quest2_HORDE_Level = "45"
Inst27Quest2_HORDE_Attain = "?"
Inst27Quest2_HORDE_Aim = "收集20瓶巨魔调和剂，把它们交给加基森的特伦顿·轻锤。"
Inst27Quest2_HORDE_Location = "特伦顿·轻锤 (塔纳利斯 - 加基森; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest2_HORDE_Note = "任何巨魔都可能掉落调和剂。"
Inst27Quest2_HORDE_Prequest = "无"
Inst27Quest2_HORDE_Folgequest = "无"

--QUEST 3 Horde

Inst27Quest3_HORDE = "3. 圣甲虫的壳"
Inst27Quest3_HORDE_Level = "45"
Inst27Quest3_HORDE_Attain = "?"
Inst27Quest3_HORDE_Aim = "给加基森的特兰雷克带去5个完整的圣甲虫壳。"
Inst27Quest3_HORDE_Location = "特兰雷克 (塔纳利斯 - 加基森; "..YELLOW.."51,36 "..WHITE..")"
Inst27Quest3_HORDE_Note = "前导任务始于 克拉兹克 (荆棘谷 - 藏宝海湾; 25,77 )。\n每个甲虫都掉壳，特别在 [2] 数量最多。"
Inst27Quest3_HORDE_Prequest = "有, 特兰雷克"
Inst27Quest3_HORDE_Folgequest = "无"
Inst27Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst27Quest4_HORDE = "4. 深渊皇冠"
Inst27Quest4_HORDE_Level = "46"
Inst27Quest4_HORDE_Attain = "40"
Inst27Quest4_HORDE_Aim = "将深渊皇冠交给尘泥沼泽的塔贝萨。"
Inst27Quest4_HORDE_Location = "塔贝萨 (尘泥沼泽; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest4_HORDE_Note = "你可以从迪诺 <法师训练师>那里领取前导任务 (奥格瑞玛; 38,85)。\n维蕾萨掉落深渊皇冠。你可以在 [6] 找到她。"
Inst27Quest4_HORDE_Prequest = "有, 塔贝萨的任务"
Inst27Quest4_HORDE_Folgequest = "无"
Inst27Quest4PreQuest_HORDE = "true"
--
Inst27Quest4name1_HORDE = "幻法之杖"
Inst27Quest4name2_HORDE = "晶岩肩铠"

--QUEST 5 Horde

Inst27Quest5_HORDE = "5. 摩沙鲁的预言 (系列任务)"
Inst27Quest5_HORDE_Level = "47"
Inst27Quest5_HORDE_Attain = "40"
Inst27Quest5_HORDE_Aim = "将第一块和第二块摩沙鲁石板交给塔纳利斯的叶基亚。"
Inst27Quest5_HORDE_Location = "叶基亚 (塔纳利斯; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_HORDE_Note = "前导任务也是从这个NPC领取。\n你可以在 [2] 和 [6] 找到石板。"
Inst27Quest5_HORDE_Prequest = "有, 尖啸者的灵魂"
Inst27Quest5_HORDE_Folgequest = "有, 远古之卵"
Inst27Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst27Quest6_HORDE = "6. 探水棒"
Inst27Quest6_HORDE_Level = "46"
Inst27Quest6_HORDE_Attain = "?"
Inst27Quest6_HORDE_Aim = "把探水棒交给加基森的首席工程师沙克斯·比格维兹。"
Inst27Quest6_HORDE_Location = "沙克斯·比格维兹 (塔纳利斯 - 加基森; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_HORDE_Note = "神庙百人战后，你可以从布莱中士那里得到探水棒。你可以在 [4] 找到他。"
Inst27Quest6_HORDE_Prequest = "无"
Inst27Quest6_HORDE_Folgequest = "无"
--
Inst27Quest6name1_HORDE = "石工兄弟会之戒"
Inst27Quest6name2_HORDE = "工程学协会头盔"

--QUEST 7 Horde

Inst27Quest7_HORDE = "7. 加兹瑞拉"
Inst27Quest7_HORDE_Level = "50"
Inst27Quest7_HORDE_Attain = "40"
Inst27Quest7_HORDE_Aim = "把加兹瑞拉的鳞片交给闪光平原的维兹尔·铜栓。"
Inst27Quest7_HORDE_Location = "维兹尔·铜栓 (千针石林; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_HORDE_Note = "你可以在 [6] 召唤出加兹瑞拉。"
Inst27Quest7_HORDE_Prequest = "无"
Inst27Quest7_HORDE_Folgequest = "无"
--
Inst27Quest7name1_HORDE = "棍子上的胡萝卜"

--------------------------Stockade/verlies (6 quests)
Inst24Story = "监狱是位于暴风城运河区戒备森原的牢房。那里由典狱官塞尔沃特看守着，监狱是那些小偷，政治犯，谋杀者和许多最危险的罪犯的家园。最近，异常暴动导致了监狱的混乱——所有的守卫都被赶了出来，里面的罪犯可以自由的活动。典狱官塞尔沃特试图控制局面并召集勇敢的冒险者进入监狱杀死暴动的主脑——那个狡猾的巴吉尔·特雷德。"
Inst24Caption = "监狱"
Inst24QAA = "6 任务"
Inst24QAH = "无任务"



--QUEST 1 Allianz

Inst24Quest1 = "1. 伸张正义"
Inst24Quest1_Level = "25"
Inst24Quest1_Attain = "22"
Inst24Quest1_Aim = "把塔格尔的头颅带给湖畔镇的卫兵伯尔顿。"
Inst24Quest1_Location = "卫兵伯尔顿 (赤脊山 - 湖畔镇 - 止水湖畔; "..YELLOW.."26,46 "..WHITE..")"
Inst24Quest1_Note = "你可以在 [1] 找到塔格尔。"
Inst24Quest1_Prequest = "无"
Inst24Quest1_Folgequest = "无"
--
Inst24Quest1name1 = "磷铝长剑"
Inst24Quest1name2 = "硬根法杖"

--QUEST 2 Allianz

Inst24Quest2 = "2. 罪与罚"
Inst24Quest2_Level = "26"
Inst24Quest2_Attain = "22"
Inst24Quest2_Aim = "夜色镇的米尔斯迪普议员要你杀死迪克斯特·瓦德，并把他的手带回来作为证明。"
Inst24Quest2_Location = "米尔斯迪普议员 (暮色森林 - 夜色镇; "..YELLOW.."72,47 "..WHITE..")"
Inst24Quest2_Note = "你可以在 [5] 找到迪克斯特·瓦德."
Inst24Quest2_Prequest = "无"
Inst24Quest2_Folgequest = "无"
--
Inst24Quest2name1 = "大使之靴"
Inst24Quest2name2 = "夜色郡锁甲护腿"


--QUEST 3 Allianz

Inst24Quest3 = "3. 镇压暴动"
Inst24Quest3_Level = "26"
Inst24Quest3_Attain = "22"
Inst24Quest3_Aim = "暴风城的典狱官塞尔沃特要求你杀死监狱中的10名迪菲亚囚徒、8名迪菲亚罪犯和8名迪菲亚叛军。"
Inst24Quest3_Location = "典狱官塞尔沃特 (暴风城; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest3_Note = "副本外的监狱长会给你这个任务。"
Inst24Quest3_Prequest = "无"
Inst24Quest3_Folgequest = "无"

--QUEST 4 Allianz

Inst24Quest4 = "4. 鲜血的颜色"
Inst24Quest4_Level = "26"
Inst24Quest4_Attain = "?"
Inst24Quest4_Aim = "暴风城的尼科瓦·拉斯克要你取得10条红色毛纺面罩。"
Inst24Quest4_Location = "尼科瓦·拉斯克 (暴风城; "..YELLOW.."73,46 "..WHITE..")"
Inst24Quest4_Note = "副本里每个敌人都可能掉落面罩。"
Inst24Quest4_Prequest = "无"
Inst24Quest4_Folgequest = "无"

--QUEST 5 Allianz

Inst24Quest5 = "5. 卡姆·深怒"
Inst24Quest5_Level = "27"
Inst24Quest5_Attain = "25"
Inst24Quest5_Aim = "丹莫德的莫特雷·加玛森要求你把卡姆·深怒的头颅交给他。"
Inst24Quest5_Location = "莫特雷·加玛森 (湿地 - 丹莫德; "..YELLOW.."49,18 "..WHITE..")"
Inst24Quest5_Note = "前导任务也从 莫特雷·加玛森 处得到。\n你可以在 [2] 找到卡姆·深怒。"
Inst24Quest5_Prequest = "有，黑铁战争"
Inst24Quest5_Folgequest = "无"
Inst24Quest5PreQuest = "true"
--
Inst24Quest5name1 = "辩护腰带 "
Inst24Quest5name2 = "碎头者"


--QUEST 6 Allianz

Inst24Quest6 = "6. 监狱暴动 (系列任务)"
Inst24Quest6_Level = "29"
Inst24Quest6_Attain = "16"
Inst24Quest6_Aim = "杀死巴基尔·斯瑞德，把他的头带给监狱的典狱官塞尔沃特。"
Inst24Quest6_Location = "典狱官塞尔沃特 (暴风城; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest6_Note = "前导任务详情请参见 [死亡矿井, 迪菲亚兄弟会].\n You find Bazil Thredd at [4]."
Inst24Quest6_Prequest = "有，未寄出的信 -> 巴吉尔·特雷德"
Inst24Quest6_Folgequest = "有，好奇的访客"
Inst24Quest6PreQuest = "true"



--------------Razorfen Downs/Inst17 ( 4 quests)------------
Inst17Story = "剃刀高地和剃刀沼泽一样由巨大的藤蔓组成，剃刀高地是野猪人的传统都城。在那错综复杂的荆棘迷宫中居住着大群忠诚的野猪人军队以及他们的高等牧师——亡首部族。然而最近，一股阴影力量笼罩了这个原始的洞穴。亡灵天灾的人在巫妖寒冰之王亚门纳尔的带领下控制了野猪部族并将荆棘迷宫变成了亡灵力量的堡垒。现在野猪人正奋力战斗来重新夺回他们的城市，并阻止亚门纳尔继续控制贫瘠之地。"
Inst17Caption = "剃刀高地"
Inst17QAA = "3 任务"
Inst17QAH = "4 任务"

--QUEST 1 Allianz

Inst17Quest1 = "1. 邪恶之地"
Inst17Quest1_Level = "35"
Inst17Quest1_Attain = "30"
Inst17Quest1_Aim = "杀掉8个剃刀沼泽护卫者、8个剃刀沼泽织棘者和8个亡首教徒，然后向剃刀高地入口处的麦雷姆·月歌复命。"
Inst17Quest1_Location = "麦雷姆·月歌 (贫瘠之地 - 剃刀高地; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_Note = "这些怪出现在你进入副本前经过的路上。"
Inst17Quest1_Prequest = "无"
Inst17Quest1_Folgequest = "无"

--QUEST 2 Allianz

Inst17Quest2 = "2. 封印神像"
Inst17Quest2_Level = "37"
Inst17Quest2_Attain = "34"
Inst17Quest2_Aim = "保护奔尼斯特拉兹来到剃刀高地的野猪人神像处。当他在进行仪式封印神像时保护他。"
Inst17Quest2_Location = "奔尼斯特拉兹 (剃刀高地; "..YELLOW.."[2] "..WHITE..")"
Inst17Quest2_Note = "你可以在 [2] 找到奔尼斯特拉兹。"
Inst17Quest2_Prequest = "有，剃刀高地的亡灵天灾"
Inst17Quest2_Folgequest = "无"
Inst17Quest2PreQuest = "true"
--
Inst17Quest2name1 = "龙爪戒指"

--QUEST 3 Allianz

Inst17Quest3 = "3. 与圣光同在"
Inst17Quest3_Attain = "39"
Inst17Quest3_Level = "42"
Inst17Quest3_Aim = "大主教本尼迪塔斯要你去杀死剃刀高地的寒冰之王亚门纳尔。"
Inst17Quest3_Location = "大主教本尼迪塔斯 (暴风城; "..YELLOW.."39,27 "..WHITE..")"
Inst17Quest3_Note = "寒冰之王亚门纳尔是剃刀高地的最后一个Boss。你可以在 [6] 找到他。"
Inst17Quest3_Prequest = "无"
Inst17Quest3_Folgequest = "无"
--
Inst17Quest3name1 = "征服者之剑"
Inst17Quest3name2 = "琥珀之光"

--QUEST 1 Horde

Inst17Quest1_HORDE = "1. 邪恶之地"
Inst17Quest1_HORDE_Level = "35"
Inst17Quest1_HORDE_Attain = "30"
Inst17Quest1_HORDE_Aim = "杀掉8个剃刀沼泽护卫者、8个剃刀沼泽织棘者和8个亡首教徒，然后向剃刀高地入口处的麦雷姆·月歌复命。"
Inst17Quest1_HORDE_Location = "麦雷姆·月歌 (贫瘠之地 - 剃刀高地; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_HORDE_Note = "剃刀沼泽护卫者、剃刀沼泽织棘者和亡首教徒都是在进入副本之前外面出现的怪物。"
Inst17Quest1_HORDE_Prequest = "无"
Inst17Quest1_HORDE_Folgequest = "无"

--Quest 2 Horde

Inst17Quest2_HORDE = "2. 邪恶的盟友"
Inst17Quest2_HORDE_Level = "36"
Inst17Quest2_HORDE_Attain = "?"
Inst17Quest2_HORDE_Aim = "把玛克林大使的头颅带给幽暗城的瓦里玛萨斯"
Inst17Quest2_HORDE_Location = "瓦里玛萨斯  (幽暗城; "..YELLOW.."56,92 "..WHITE..")"
Inst17Quest2_HORDE_Note = "剃刀沼泽最后的Boss给出前导任务。\n 玛克林大使位置在进入副本前外面的空地上(贫瘠之地 - 剃刀高地, (48,92))。"
Inst17Quest2_HORDE_Prequest = "有, 邪恶的盟友"
Inst17Quest2_HORDE_Folgequest = "无"
Inst17Quest2PreQuest_HORDE = "true"
--
Inst17Quest2name1_HORDE = "破颅者"
Inst17Quest2name2_HORDE = "钉枪"
Inst17Quest2name3_HORDE = "狂热长袍"

-- Quest 3 Horde

Inst17Quest3_HORDE = "3. 封印神像 "
Inst17Quest3_HORDE_Level = "37"
Inst17Quest3_HORDE_Attain = "34"
Inst17Quest3_HORDE_Aim = "保护奔尼斯特拉兹来到剃刀高地的野猪人神像处。当他在进行仪式封印神像时保护他。"
Inst17Quest3_HORDE_Location = "剃刀高地; "..YELLOW.."[2] "..WHITE..")"
Inst17Quest3_HORDE_Note = "奔尼斯特拉兹 位于 [2]."
Inst17Quest3_HORDE_Prequest = "有, 剃刀高地的亡灵天灾(也是 奔尼斯特拉兹 给的任务)"
Inst17Quest3_HORDE_Folgequest = "无"
Inst17Quest3PreQuest_HORDE = "true"
--
Inst17Quest3name1_HORDE = "龙爪戒指"

--QUEST 4 Horde

Inst17Quest4_HORDE = "4. 寒冰之王"
Inst17Quest4_HORDE_Attain = "37"
Inst17Quest4_HORDE_Level = "42"
Inst17Quest4_HORDE_Aim = "安德鲁·布隆奈尔要你杀了寒冰之王亚门纳尔并将其头骨带回来。"
Inst17Quest4_HORDE_Location = "安德鲁·布隆奈尔 (幽暗城; "..YELLOW.."72,32 "..WHITE..")"
Inst17Quest4_HORDE_Note = "寒冰之王亚门纳尔是剃刀高地最后一个Boss。位于 [6] 。"
Inst17Quest4_HORDE_Prequest = "无"
Inst17Quest4_HORDE_Folgequest = "无"
--
Inst17Quest4name1_HORDE = "征服者之剑"
Inst17Quest4name2_HORDE = "琥珀之光"

--------------Kloster/SM ( 6 quests)------------
Inst19Story = "血色修道院曾经是洛丹伦王国牧师的荣耀之地——那里是学习圣光只是和膜拜的中心。随着在第三次大战中亡灵天灾的崛起，宁静的修道院成为了疯狂的血色十字军的要塞。十字军对于所有非人类都有着偏激的态度，无论他们是自己的盟友还是对手。他们相信所有任何外来者都带着亡灵的瘟疫——他们必须被摧毁。有报告说所有进入修道院的冒险者都要面对血色十字军指挥官莫格莱尼——他控制了一群狂热的十字军战士。然而，修道院的真正主人是大检察官怀特迈恩——一个疯狂的牧师，她具有复活死去的战士来为其效劳的能力。"
Inst19Caption = "血色修道院(SM)"
Inst19QAA = "3 任务"
Inst19QAH = "6 任务"

--QUEST 1 Allianz

Inst19Quest1 = "1. 泰坦神话"
Inst19Quest1_Level = "38"
Inst19Quest1_Attain = "?"
Inst19Quest1_Aim = "从修道院拿回《泰坦神话》，把它交给铁炉堡的图书馆员麦伊·苍尘。"
Inst19Quest1_Location = "图书馆员麦伊·苍尘 (铁炉堡; "..YELLOW.."74,12 "..WHITE..")"
Inst19Quest1_Note = "你可以在血色修道院的图书馆里找到这本书。"
Inst19Quest1_Prequest = "无"
Inst19Quest1_Folgequest = "无"
--
Inst19Quest1name1 = "探险者协会的奖状"

--QUEST 2 Allianz

Inst19Quest2 = "2. 以圣光之名"
Inst19Quest2_Level = "40"
Inst19Quest2_Attain = "39"
Inst19Quest2_Aim = "杀死大检察官怀特迈恩，血色十字军指挥官莫格莱尼，十字军的勇士赫洛德和驯犬者洛克希并向南海镇的莱雷恩复命。"
Inst19Quest2_Location = "虔诚的莱雷恩 (希尔斯布莱德 - 南海镇; "..YELLOW.."51,58 "..WHITE..")"
Inst19Quest2_Note = "此系列任务始于 克罗雷修士 (暴风城; 42,24)。\n你可以在 [5] 找到大检察官怀特迈恩和血色十字军指挥官莫格莱尼，赫洛德在 [3] and 驯犬者洛克希在 [1]。"
Inst19Quest2_Prequest = "有，安东修士 -> 血色之路（任务领取地点在凄凉之地前哨站，任务要杀的骷髅兵在地图底部中间偏右的一个山谷里面）"
Inst19Quest2_Folgequest = "无"
Inst19Quest2PreQuest = "true"
--
Inst19Quest2name1 = "平静之剑"
Inst19Quest2name2 = "咬骨之斧"
Inst19Quest2name3 = "黑暗威胁"
Inst19Quest2name4 = "洛瑞卡宝珠"


--QUEST 3 Allianz MAGIER

Inst19Quest3 = "3. 能量仪祭 (法师专属任务)"
Inst19Quest3_Level = "40"
Inst19Quest3_Attain = "31"
Inst19Quest3_Aim = "将《能量仪祭》交给尘泥沼泽的塔贝萨。"
Inst19Quest3_Location = "塔贝萨 (尘泥沼泽; "..YELLOW.."43,57 "..WHITE..")"
Inst19Quest3_Note = "只有法师玩家能够接到这个人物！\n你可以在血色修道院图书馆里找到这本书。"
Inst19Quest3_Prequest = "有，解封咒语"
Inst19Quest3_Folgequest = "有，法师的魔杖"
Inst19Quest3PreQuest = "true"

--QUEST 1 Horde

Inst19Quest1_HORDE = "1. 沃瑞尔的复仇"
Inst19Quest1_HORDE_Level = "33"
Inst19Quest1_HORDE_Attain = "?"
Inst19Quest1_HORDE_Aim = "把沃瑞尔·森加斯的结婚戒指还给塔伦米尔的莫尼卡·森古特斯。"
Inst19Quest1_HORDE_Location = "沃瑞尔·森加斯 (血色修道院, 墓地)"
Inst19Quest1_HORDE_Note = "沃瑞尔·森加斯就位于血色修道院墓地前部。 南希每小时出现在奥特兰克山脉(31,32)。 她有戒指。"
Inst19Quest1_HORDE_Prequest = "无"
Inst19Quest1_HORDE_Folgequest = "无"
--
Inst19Quest1name1_HORDE = "沃瑞尔的靴子"
Inst19Quest1name2_HORDE = "悲哀衬肩"
Inst19Quest1name3_HORDE = "十字军斗篷"

--Quest 2 Horde

Inst19Quest2_HORDE = "2. 狂热之心"
Inst19Quest2_HORDE_Level = "33"
Inst19Quest2_HORDE_Attain = "?"
Inst19Quest2_HORDE_Aim = "幽暗城的大药剂师法拉尼尔需要20颗狂热之心。"
Inst19Quest2_HORDE_Location = "大药剂师法拉尼尔  (幽暗城; "..YELLOW.."48,69 "..WHITE..")"
Inst19Quest2_HORDE_Note = "更多关于前导任务的信息详见 [剃刀沼泽]\n你可以从血色修道院里任何怪物身上得到狂热之心。"
Inst19Quest2_HORDE_Prequest = "有, 蝙蝠的粪便"
Inst19Quest2_HORDE_Folgequest = "无"
Inst19Quest2PreQuest_HORDE = "true"


-- Quest 3 Horde

Inst19Quest3_HORDE = "3. 知识试炼 (系列任务)"
Inst19Quest3_HORDE_Level = "36"
Inst19Quest3_HORDE_Attain = "32"
Inst19Quest3_HORDE_Aim = "找到《亡灵的起源》，把它交给幽暗城的帕科瓦·芬塔拉斯。"
Inst19Quest3_HORDE_Location = "帕科瓦·芬塔拉斯 (幽暗城; "..YELLOW.."57,65 "..WHITE..")"
Inst19Quest3_HORDE_Note = "此系列任务始于 多恩·平原行者 (千针石林 (53,41).\n 书在血色修道院图书馆里。"
Inst19Quest3_HORDE_Prequest = "有, 信仰的试炼 -> 耐力的试炼 -> 力量的试炼 -> 知识试炼"
Inst19Quest3_HORDE_Folgequest = "有, 知识试炼"
Inst19Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst19Quest4_HORDE = "4. 堕落者纲要"
Inst19Quest4_HORDE_Level = "38"
Inst19Quest4_HORDE_Attain = "?"
Inst19Quest4_HORDE_Aim = "从提瑞斯法林地血色修道院里找到《堕落者纲要》，把它交给雷霆崖的圣者图希克。"
Inst19Quest4_HORDE_Location = "圣者图希克 (Thunderbluff; "..YELLOW.."34,47 "..WHITE..")"
Inst19Quest4_HORDE_Note = "书在血色修道院的图书馆里。"
Inst19Quest4_HORDE_Prequest = "无"
Inst19Quest4_HORDE_Folgequest = "无"
--
Inst19Quest4name1_HORDE = "邪恶防护者"
Inst19Quest4name2_HORDE = "力石圆盾"
Inst19Quest4name3_HORDE = "终结宝珠"

--QUEST 5 Horde

Inst19Quest5_HORDE = "5. 深入血色修道院"
Inst19Quest5_HORDE_Level = "42"
Inst19Quest5_HORDE_Attain = "33"
Inst19Quest5_HORDE_Aim = "杀掉大检察官怀特迈恩、血色十字军指挥官莫格莱尼、血色十字军勇士赫洛德和驯犬者洛克希，然后向幽暗城的瓦里玛萨斯回报。"
Inst19Quest5_HORDE_Location = "瓦里玛萨斯  (幽暗城; "..YELLOW.."56,92 "..WHITE..")"
Inst19Quest5_HORDE_Note = "大检察官怀特迈恩和血色十字军指挥官莫格莱尼在 [5], 血色十字军勇士赫洛德在 [3], 驯犬者洛克希在 [1] 。"
Inst19Quest5_HORDE_Prequest = "无"
Inst19Quest5_HORDE_Folgequest = "无"
--
Inst19Quest5name1_HORDE = "预兆之剑"
Inst19Quest5name2_HORDE = "预言藤杖"
Inst19Quest5name3_HORDE = "龙血项链"

--QUEST 6 Horde

Inst19Quest6_HORDE = "6. 能量仪祭 (法师专属)"
Inst19Quest6_HORDE_Level = "40"
Inst19Quest6_HORDE_Attain = "31"
Inst19Quest6_HORDE_Aim = "将《能量仪祭》交给尘泥沼泽的塔贝萨。"
Inst19Quest6_HORDE_Location = "塔贝萨 (尘泥沼泽; "..YELLOW.."46,57 "..WHITE..")"
Inst19Quest6_HORDE_Note = "只有法师才能得到这个任务!\n书在血色修道院的图书馆里。"
Inst19Quest6_HORDE_Prequest = "有, 解封咒语"
Inst19Quest6_HORDE_Folgequest = "有, 法师的魔杖"
Inst19Quest6PreQuest_HORDE = "true"

--------------Kral ( 5 quests)------------
Inst18Story = "在一万年前的古代战争中，万能的半神阿迦玛甘和燃烧军团进行了激战。虽然这头巨大的猪在战斗中倒下了，但是他的努力最终拯救了艾泽拉斯大陆免遭涂炭。虽然已经过去了很久，但是在它血液流淌的地方巨大的荆棘藤蔓生长出来。那些被认为是半神后代的野猪人占领了这些地区并将其奉为圣地。这些荆棘地的中心被称为剃刀岭。而巨大的剃刀沼泽则被一个老丑婆卡尔加·刺肋所占据。在她的统治下，信奉萨满教的野猪人和别的部族以及部落为敌。有些人甚至猜测卡尔加还在和亡灵天灾的有来往——她想要联合亡灵天灾来达到一些不可告人的险恶目的。"
Inst18Caption = "剃刀沼泽"
Inst18QAA = "5 任务"
Inst18QAH = "5 任务"

--QUEST 1 Allianz

Inst18Quest1 = "1. 蓝叶薯"
Inst18Quest1_Level = "26"
Inst18Quest1_Attain = "20"
Inst18Quest1_Aim = "找到一个开孔的箱子。\n找到一根地鼠指挥棒。\n找到并阅读《地鼠指挥手册》。\n在剃刀沼泽里用开孔的箱子召唤一只地鼠，然后用指挥棒驱使它去搜寻蓝叶薯。\n把地鼠指挥棒、开孔的箱子和10块蓝叶薯交给棘齿城的麦伯克·米希瑞克斯。"
Inst18Quest1_Location = "麦伯克·米希瑞克斯 (贫瘠之地 - 棘齿城; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_Note = "开孔的箱子, 地鼠指挥棒和 《地鼠指挥手册》都在麦伯克·米希瑞克斯附近不远的地方"
Inst18Quest1_Prequest = "无"
Inst18Quest1_Folgequest = "无"
--
Inst18Quest1name1 = "一小袋宝石"

--QUEST 2 Allianz

Inst18Quest2 = "2. 临终遗言"
Inst18Quest2_Level = "30"
Inst18Quest2_Attain = "?"
Inst18Quest2_Aim = "将塔莎拉的坠饰带给达纳苏斯的塔莎拉·静水。"
Inst18Quest2_Location = "赫尔拉斯·静水 (剃刀沼泽; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest2_Note = "坠饰随机掉落。你必须把坠饰带给达纳苏斯的塔莎拉·静水 (69,67)。"
Inst18Quest2_Prequest = "无"
Inst18Quest2_Folgequest = "无"
--
Inst18Quest2name1 = "悲伤披风"
Inst18Quest2name2 = "枪骑兵战靴"

--QUEST 3 Allianz

Inst18Quest3 = "3. 进口商威利克斯"
Inst18Quest3_Level = "30"
Inst18Quest3_Attain = "?"
Inst18Quest3_Aim = "护送进口商威利克斯逃出剃刀沼泽。"
Inst18Quest3_Location = "进口商威利克斯 (剃刀沼泽; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest3_Note = "威利克斯 在 [8]。你必须把他护送到入口处。"
Inst18Quest3_Prequest = "无"
Inst18Quest3_Folgequest = "无"
--
Inst18Quest3name1 = "猴子戒指"
Inst18Quest3name2 = "蛇环"
Inst18Quest3name3 = "猛虎指环"

--QUEST 4 Allianz

Inst18Quest4 = "4. 卡尔加·刺肋"
Inst18Quest4_Level = "34"
Inst18Quest4_Attain = "30"
Inst18Quest4_Aim = "把卡尔加·刺肋的徽章交给萨兰纳尔的法芬德尔。"
Inst18Quest4_Location = "法芬德尔 (菲拉斯 - 萨兰纳尔; "..YELLOW.."89,46"..WHITE..")"
Inst18Quest4_Note = "卡尔加·刺肋 [7] 掉落徽章。"
Inst18Quest4_Prequest = "有，亨里格的日记"
Inst18Quest4_Folgequest = "有，卡尔加·刺肋"
Inst18Quest4PreQuest = "true"
--
Inst18Quest4name1 = "“法师之眼”大口径火枪"
Inst18Quest4name2 = "绿宝石护肩"
Inst18Quest4name3 = "石拳束带"
Inst18Quest4name4 = "石饰圆盾"

--QUEST 5 Allianz KRIEGER

Inst18Quest5 = "5. 弗伦的铠甲 (战士专属任务)"
Inst18Quest5_Level = "28"
Inst18Quest5_Attain = "20"
Inst18Quest5_Aim = "收集必需的材料，将它们交给暴风城的弗伦·长须。"
Inst18Quest5_Location = "弗伦·长须 (暴风城; "..YELLOW.."57,16"..WHITE..")"
Inst18Quest5_Note = "只有战士才能接到这个任务！\n你可以在 [1] 得到燃素。"
Inst18Quest5_Prequest = "有，铸盾师"
Inst18Quest5_Folgequest = "无"
Inst18Quest5PreQuest = "true"
--
Insst18Quest5name1 = "淬火锁甲"


--QUEST 1 Horde

Inst18Quest1_HORDE = "1. 蓝叶薯"
Inst18Quest1_HORDE_Level = "26"
Inst18Quest1_HORDE_Attain = "20"
Inst18Quest1_HORDE_Aim = "找到一个开孔的箱子。\n找到一根地鼠指挥棒。\n找到并阅读《地鼠指挥手册》。\n在剃刀沼泽里用开孔的箱子召唤一只地鼠，然后用指挥棒驱使它去搜寻蓝叶薯。\n把地鼠指挥棒、开孔的箱子和10块蓝叶薯交给棘齿城的麦伯克·米希瑞克斯。"
Inst18Quest1_HORDE_Location = "麦伯克·米希瑞克斯 (贫瘠之地 - 棘齿城; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_HORDE_Note = "开孔的箱子, 地鼠指挥棒和 《地鼠指挥手册》都在麦伯克·米希瑞克斯附近不远的地方"
Inst18Quest1_HORDE_Prequest = "无"
Inst18Quest1_HORDE_Folgequest = "无"
--
Inst18Quest1name1_HORDE = "一小袋宝石"

--Quest 2 Horde

Inst18Quest2_HORDE = "2. 进口商威利克斯"
Inst18Quest2_HORDE_Level = "30"
Inst18Quest2_HORDE_Attain = "?"
Inst18Quest2_HORDE_Aim = "护送进口商威利克斯逃出剃刀沼泽。"
Inst18Quest2_HORDE_Location = "进口商威利克斯 (剃刀沼泽; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest2_HORDE_Note = "威利克斯在 [8]，你必须把它带到入口处。"
Inst18Quest2_HORDE_Prequest = "无"
Inst18Quest2_HORDE_Folgequest = "无"
--
Inst18Quest2name1_HORDE = "猴子戒指"
Inst18Quest2name2_HORDE = "蛇环"
Inst18Quest2name3_HORDE = "猛虎指环"

-- Quest 3 Horde

Inst18Quest3_HORDE = "3. 蝙蝠的粪便"
Inst18Quest3_HORDE_Level = "33"
Inst18Quest3_HORDE_Attain = "?"
Inst18Quest3_HORDE_Aim = "帮幽暗城的大药剂师法拉尼尔带回一堆沼泽蝙蝠的粪便。"
Inst18Quest3_HORDE_Location = "法拉尼尔 (幽暗城; "..YELLOW.."48,69 "..WHITE..")"
Inst18Quest3_HORDE_Note = "任何蝙蝠都会掉落沼泽蝙蝠的粪便。"
Inst18Quest3_HORDE_Prequest = "无"
Inst18Quest3_HORDE_Folgequest = "有, 狂热之心 (参看 [剃刀高地])"

--QUEST 4 Horde

Inst18Quest4_HORDE = "4. 奥尔德的报复"
Inst18Quest4_HORDE_Level = "34"
Inst18Quest4_HORDE_Attain = "29"
Inst18Quest4_HORDE_Aim = "把卡尔加·刺肋的心脏交给雷霆崖的奥尔德·石塔。"
Inst18Quest4_HORDE_Location = "奥尔德·石塔 (雷霆崖; "..YELLOW.."36,59 "..WHITE..")"
Inst18Quest4_HORDE_Note = "卡尔加·刺肋在 [7]"
Inst18Quest4_HORDE_Prequest = "无"
Inst18Quest4_HORDE_Folgequest = "无"
--
Inst18Quest4name1_HORDE = "绿宝石护肩"
Inst18Quest4name2_HORDE = "石拳束带"
Inst18Quest4name3_HORDE = "石饰圆盾"

--QUEST 5 Horde

Inst18Quest5_HORDE = "5. 野蛮护甲 (战士专属)"
Inst18Quest5_HORDE_Level = "30"
Inst18Quest5_HORDE_Attain = "20"
Inst18Quest5_HORDE_Aim = "为索恩格瑞姆收集15根烟雾铁锭、10份蓝铜粉、10块铁锭和1瓶燃素。"
Inst18Quest5_HORDE_Location = "索恩格瑞姆 Firegaze (贫瘠之地; "..YELLOW.."57,30 "..WHITE..")"
Inst18Quest5_HORDE_Note = "只有战士可以取得这个任务！\n你可以在 [1] 获得燃素"
Inst18Quest5_HORDE_Prequest = "有, 和索恩格瑞姆交谈"
Inst18Quest5_HORDE_Folgequest = "有"
Inst18Quest5PreQuest_HORDE = "true"

--------------Scholo ( 9 quests)------------
Inst20Story = "通灵学院位于凯尔达隆废弃的城堡中的地下室中。那里曾经是高贵的巴罗夫家族的，但是在第二次大战中凯尔达隆变成了一块废墟。法师克尔苏加德经常向他的诅咒神教信徒承诺可以用对于巫妖王的效忠来换取永恒的生命。巴罗克家族受到克尔苏加德的魅惑而将城堡和其地下室献给了亡灵天灾。那些信徒然后将巴罗夫家族的人杀死并把地下室变成了通灵学院。虽然克尔苏加德不再住在这个地下室中，但是狂热的信徒和讲师都还留在那里。强大的巫妖，莱斯·霜语以亡灵天灾的名义控制了这里——而凡人亡灵巫师黑暗院长加丁则是这个学校邪恶的校长。"
Inst20Caption = "通灵学院"
Inst20QAA = "9 任务"
Inst20QAH = "9 任务"

--QUEST 1 Allianz

Inst20Quest1 = "1. 瘟疫之龙"
Inst20Quest1_Attain = "55"
Inst20Quest1_Level = "58"
Inst20Quest1_Aim = "杀掉20只瘟疫龙崽，然后向圣光之愿礼拜堂的贝蒂娜·比格辛克复命。"
Inst20Quest1_Location = "贝蒂娜·比格辛克 (东瘟疫之地 - 圣光之愿礼拜堂; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_Note = ""
Inst20Quest1_Prequest = "无"
Inst20Quest1_Folgequest = "有，健康的龙鳞"

--QUEST 2 Allianz

Inst20Quest2 = "2. 健康的龙鳞"
Inst20Quest2_Attain = ""
Inst20Quest2_Level = "58"
Inst20Quest2_Aim = "把健康的龙鳞交给东瘟疫之地圣光之愿礼拜堂中的贝蒂娜·比格辛克。"
Inst20Quest2_Location = "健康的龙鳞 (掉落) (通灵学院)"
Inst20Quest2_Note = "瘟疫龙崽掉落健康的龙鳞 (8% 掉率)。贝蒂娜·比格辛克在 (81,59)。"
Inst20Quest2_Prequest = "有，瘟疫之龙"
Inst20Quest2_Folgequest = "无"
Inst20Quest2FQuest = "true"

--QUEST 3 Allianz

Inst20Quest3 = "3. 瑟尔林·卡斯迪诺夫教授"
Inst20Quest3_Attain = "55"
Inst20Quest3_Level = "60"
Inst20Quest3_Aim = "在通灵学院中找到瑟尔林·卡斯迪诺夫教授。杀死他，并烧毁艾瓦·萨克霍夫和卢森·萨克霍夫的遗体。任务完成后就回到艾瓦·萨克霍夫那儿。"
Inst20Quest3_Location = "艾瓦·萨克霍夫 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_Note = "你可以在 [9] 找到瑟尔林·卡斯迪诺夫教授。"
Inst20Quest3_Prequest = "无"
Inst20Quest3_Folgequest = "有，卡斯迪诺夫的恐惧之袋"

--QUEST 4 Allianz

Inst20Quest4 = "4. 卡斯迪诺夫的恐惧之袋"
Inst20Quest4_Attain = "55"
Inst20Quest4_Level = "60"
Inst20Quest4_Aim = "在通灵学院找到詹迪斯·巴罗夫并打败她。从她的尸体上找到卡斯迪诺夫的恐惧之袋，然后将其交给艾瓦·萨克霍夫。"
Inst20Quest4_Location = "艾瓦·萨克霍夫 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_Note = "你可以在 [3] 詹迪斯·巴罗夫。"
Inst20Quest4_Prequest = "有，瑟尔林·卡斯迪诺夫教授"
Inst20Quest4_Folgequest = "有，传令官基尔图诺斯"
Inst20Quest4FQuest = "true"

--QUEST 5 Allianz

Inst20Quest5 = "5. 传令官基尔图诺斯"
Inst20Quest5_Attain = "56"
Inst20Quest5_Level = "60"
Inst20Quest5_Aim = "带着无辜者之血回到通灵学院，将它放在门廊的火盆下面，基尔图诺斯会前来吞噬你的灵魂。勇敢地战斗吧，不要退缩！杀死基尔图诺斯，然后回到艾瓦·萨克霍夫那儿。"
Inst20Quest5_Location = "艾瓦·萨克霍夫 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_Note = "门廊就在 [2] 区"
Inst20Quest5_Prequest = "有，卡斯迪诺夫的恐惧之袋"
Inst20Quest5_Folgequest = "有，莱斯·霜语"
Inst20Quest5FQuest = "true"
--
Inst20Quest5name1 = "鬼灵精华"
Inst20Quest5name2 = "波尼的玫瑰"
Inst20Quest5name3 = "米拉之歌"

--QUEST 6 Allianz

Inst20Quest6 = "6. 巫妖莱斯·霜语"
Inst20Quest6_Attain = "60"
Inst20Quest6_Level = "60"
Inst20Quest6_Aim = "在通灵学院里找到莱斯·霜语。当你找到他之后，使用禁锢灵魂的遗物破除其亡灵的外壳。如果你成功地破除了他的不死之身，就杀掉他并拿到莱斯·霜语的头颅。把那个头颅交给马杜克镇长。"
Inst20Quest6_Location = "马杜克镇长 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_Note = "你可以在 [7] 区找到莱斯·霜语。"
Inst20Quest6_Prequest = "有，莱斯·霜语  - > 禁锢灵魂的遗物"
Inst20Quest6_Folgequest = "No"
Inst20Quest6PreQuest = "true"
--
Inst20Quest6name1 = "达隆郡之盾"
Inst20Quest6name2 = "凯尔达隆战剑"
Inst20Quest6name3 = "凯尔达隆之冠"
Inst20Quest6name4 = "达隆郡之刺"

--QUEST 7 Allianz

Inst20Quest7 = "7. 巴罗夫家族的宝藏"
Inst20Quest7_Attain = "60"
Inst20Quest7_Level = "60"
Inst20Quest7_Aim = "到通灵学院中去取得巴罗夫家族的宝藏。这份宝藏包括四份地契：凯尔达隆地契、布瑞尔地契、塔伦米尔地契，还有南海镇地契。完成任务之后就回到维尔顿·巴罗夫那儿去。"
Inst20Quest7_Location = "维尔顿·巴罗夫 (西瘟疫之地; "..YELLOW.."43,83"..WHITE..")"
Inst20Quest7_Note = "你可以在 [12] 找到凯尔达隆地契，在 [7] 找到布瑞尔地契，在 [4] 找到塔伦米尔地契，在 [1] 找到南海镇地契。"
Inst20Quest7_Prequest = "无"
Inst20Quest7_Folgequest = "有，巴罗夫的继承人\n（去亡灵壁垒——部落的领地——去暗杀阿莱克斯·巴罗夫。把他的脑袋交给维尔顿·巴罗夫。）"

--QUEST 8 Allianz

Inst20Quest8 = "8. 黎明先锋"
Inst20Quest8_Attain = "59"
Inst20Quest8_Level = "60"
Inst20Quest8_Aim = "将黎明先锋放在通灵学院的观察室里。打败维克图斯,然后回到贝蒂娜·比格辛克那里去。"
Inst20Quest8_Location = "贝蒂娜·比格辛克 (东瘟疫之地 - 圣光之愿礼拜堂; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_Note = "雏龙精华 开始于 丁奇·斯迪波尔 (燃烧平原; 65,23)。 观察室坐落于 [6] 区。"
Inst20Quest8_Prequest = "有，雏龙精华 - > 莱尼德·巴萨罗梅 - > 贝蒂娜·比格辛克"
Inst20Quest8_Folgequest = "无"
Inst20Quest8PreQuest = "true"
--
Inst20Quest8name1 = "断风者"
Inst20Quest8name2 = "舞动之藤"

--QUEST 9 Allaince

Inst20Quest9 = "9. 瓶中的小鬼 (术士专属任务)"
Inst20Quest9_Attain = "60"
Inst20Quest9_Level = "60"
Inst20Quest9_Aim = "把瓶中的小鬼带到通灵学院的炼金实验室中。在小鬼制造出羊皮纸之后，把瓶子还给戈瑟奇·邪眼。"
Inst20Quest9_Location = "戈瑟奇·邪眼 (燃烧平原; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_Note = "只有术士才能得到这个任务！你可以在 [3'] 找到炼金实验室。"
Inst20Quest9_Prequest = "有，莫苏尔·召血者 - > 克索诺斯星尘"
Inst20Quest9_Folgequest = "有，克索诺斯恐惧战马"
Inst20Quest9PreQuest = "true"



--QUEST 1 Horde

Inst20Quest1_HORDE = "1. 瘟疫之龙"
Inst20Quest1_HORDE_Attain = "55"
Inst20Quest1_HORDE_Level = "58"
Inst20Quest1_HORDE_Aim = "杀掉20只瘟疫龙崽，然后向圣光之愿礼拜堂的贝蒂娜·比格辛克复命。"
Inst20Quest1_HORDE_Location = "贝蒂娜·比格辛克 (东瘟疫之地 - 圣光之愿礼拜堂; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_HORDE_Note = ""
Inst20Quest1_HORDE_Prequest = "无"
Inst20Quest1_HORDE_Folgequest = "有，健康的龙鳞"


--QUEST 2 Horde

Inst20Quest2_HORDE = "2. 健康的龙鳞"
Inst20Quest2_HORDE_Attain = ""
Inst20Quest2_HORDE_Level = "58"
Inst20Quest2_HORDE_Aim = "把健康的龙鳞交给东瘟疫之地圣光之愿礼拜堂中的贝蒂娜·比格辛克。"
Inst20Quest2_HORDE_Location = "健康的龙鳞 (掉落) (通灵学院)"
Inst20Quest2_HORDE_Note = "瘟疫龙崽掉落健康的龙鳞 (8% 掉率)。贝蒂娜·比格辛克在 (81,59)。"
Inst20Quest2_HORDE_Prequest = "有，瘟疫幼龙 "
Inst20Quest2_HORDE_Folgequest = "无"
Inst20Quest2FQuest_HORDE = "true"


--QUEST 3 Horde

Inst20Quest3_HORDE = "3. 瑟尔林·卡斯迪诺夫教授"
Inst20Quest3_HORDE_Attain = "55"
Inst20Quest3_HORDE_Level = "60"
Inst20Quest3_HORDE_Aim = "在通灵学院中找到瑟尔林·卡斯迪诺夫教授。杀死他，并烧毁艾瓦·萨克霍夫和卢森·萨克霍夫的遗体。任务完成后就回到艾瓦·萨克霍夫那儿。"
Inst20Quest3_HORDE_Location = "艾瓦·萨克霍夫 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_HORDE_Note = "瑟尔林·卡斯迪诺夫教授在 [9]"
Inst20Quest3_HORDE_Prequest = "无"
Inst20Quest3_HORDE_Folgequest = "有，卡斯迪诺夫的恐惧之袋"

--QUEST 4 Horde

Inst20Quest4_HORDE = "4. 卡斯迪诺夫的恐惧之袋"
Inst20Quest4_HORDE_Attain = "55"
Inst20Quest4_HORDE_Level = "60"
Inst20Quest4_HORDE_Aim = "在通灵学院找到詹迪斯·巴罗夫并打败她。从她的尸体上找到卡斯迪诺夫的恐惧之袋，然后将其交给艾瓦·萨克霍夫。"
Inst20Quest4_HORDE_Location = "艾瓦·萨克霍夫 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_HORDE_Note = "詹迪斯·巴罗夫在 [3]."
Inst20Quest4_HORDE_Prequest = "有，瑟尔林·卡斯迪诺夫教授"
Inst20Quest4_HORDE_Folgequest = "有，传令官基尔图诺斯"
Inst20Quest4FQuest_HORDE = "true"


--QUEST 5 Horde

Inst20Quest5_HORDE = "5. 传令官基尔图诺斯"
Inst20Quest5_HORDE_Attain = "56"
Inst20Quest5_HORDE_Level = "60"
Inst20Quest5_HORDE_Aim = "带着无辜者之血回到通灵学院。找到门廊，然后把无辜者之血放到火盆里。基尔图诺斯会来享用你的灵魂。不要退缩，勇敢地战斗吧！杀死他，然后回到艾瓦·萨克霍夫那儿。"
Inst20Quest5_HORDE_Location = "艾瓦·萨克霍夫 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_HORDE_Note = "门廊在 [2]."
Inst20Quest5_HORDE_Prequest = "有，卡斯迪诺夫的恐惧之袋"
Inst20Quest5_HORDE_Folgequest = "有，莱斯·霜语"
Inst20Quest5FQuest_HORDE = "true"
--
Inst20Quest5name1_HORDE = "鬼灵精华"
Inst20Quest5name2_HORDE = "波尼的玫瑰"
Inst20Quest5name3_HORDE = "米拉之歌"

--QUEST 6 Horde

Inst20Quest6_HORDE = "6. 巫妖莱斯·霜语"
Inst20Quest6_HORDE_Attain = "60"
Inst20Quest6_HORDE_Level = "60"
Inst20Quest6_HORDE_Aim = "在通灵学院里找到莱斯·霜语。当你找到他之后，使用禁锢灵魂的遗物破除其亡灵的外壳。如果你成功地破除了他的不死之身，就杀掉他并拿到莱斯·霜语的头颅。把那个头颅交给马杜克镇长。"
Inst20Quest6_HORDE_Location = "马杜克镇长 (西瘟疫之地; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_HORDE_Note = "莱斯·霜语在 [7]."
Inst20Quest6_HORDE_Prequest = "有，莱斯·霜语 -> 禁锢灵魂的遗物"
Inst20Quest6_HORDE_Folgequest = "无"
Inst20Quest6PreQuest_HORDE = "true"
--
Inst20Quest6name1_HORDE = "达隆郡之盾"
Inst20Quest6name2_HORDE = "凯尔达隆战剑"
Inst20Quest6name3_HORDE = "凯尔达隆之冠"
Inst20Quest6name4_HORDE = "达隆郡之刺"

--QUEST 7 Horde

Inst20Quest7_HORDE = "7. 巴罗夫家族的宝藏"
Inst20Quest7_HORDE_Attain = "60"
Inst20Quest7_HORDE_Level = "60"
Inst20Quest7_HORDE_Aim = "到通灵学院中去取得巴罗夫家族的宝藏。这份宝藏包括四份地契：凯尔达隆地契、布瑞尔地契、塔伦米尔地契，还有南海镇地契。当你拿到这四份地契之后就回到阿莱克斯·巴罗夫那儿去。"
Inst20Quest7_HORDE_Location = "阿莱克斯·巴罗夫 (西瘟疫之地; "..YELLOW.."28,57"..WHITE..")"
Inst20Quest7_HORDE_Note = "凯尔达隆地契 在 [12],  布瑞尔地契 在 [7],  塔伦米尔地契 在 [4] , 南海镇地契 在 [1]."
Inst20Quest7_HORDE_Prequest = "无"
Inst20Quest7_HORDE_Folgequest = "有，巴罗夫的继承人\n（到冰风岗——联盟的领地——去暗杀维尔顿·巴罗夫。把他的脑袋交给阿莱克斯·巴罗夫。）"


--QUEST 8 Horde

Inst20Quest8_HORDE = "8. 黎明先锋"
Inst20Quest8_HORDE_Attain = "59"
Inst20Quest8_HORDE_Level = "60"
Inst20Quest8_HORDE_Aim = "将黎明先锋放在通灵学院的观察室里。打败维克图斯,然后回到贝蒂娜·比格辛克那里去。"
Inst20Quest8_HORDE_Location = "贝蒂娜·比格辛克 (东瘟疫之地 - 圣光之愿礼拜堂; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_HORDE_Note = "雏龙精华 开始于 丁奇·斯迪波尔 (燃烧平原, 65,23). 观察室 在 [6].\n"
Inst20Quest8_HORDE_Prequest = "有，黎明先锋是黑上任务的后续，最初的任务起始与燃烧平原的雏龙精华。前面要完成的任务依次是：\n雏龙精华 > 菲诺克 > 冰风奇美拉角 > 返回丁奇身边 > 冷冻龙蛋 > 收集龙蛋 > 莱尼德·巴萨罗梅 > 贝蒂娜·比格辛克 > 黎明先锋"
Inst20Quest8_HORDE_Folgequest = "无"
Inst20Quest8PreQuest_HORDE = "true"
--
Inst20Quest8name1_HORDE = "断风者"
Inst20Quest8name2_HORDE = "舞动之藤"

--QUEST 9 Horde

Inst20Quest9_HORDE = "9. 瓶中的小鬼 (术士专属任务)"
Inst20Quest9_HORDE_Attain = "60"
Inst20Quest9_HORDE_Level = "60"
Inst20Quest9_HORDE_Aim = "把瓶中的小鬼带到通灵学院的炼金实验室中。在小鬼制造出羊皮纸之后，把瓶子还给戈瑟奇·邪眼。"
Inst20Quest9_HORDE_Location = "戈瑟奇·邪眼 (燃烧平原; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_HORDE_Note = "只有术士能够完成这个任务！炼金实验室在 [3']."
Inst20Quest9_HORDE_Prequest = "有，莫苏尔·召血者 - > 克索诺斯星尘"
Inst20Quest9_HORDE_Folgequest = "有，克索诺斯恐惧战马"
Inst20Quest9PreQuest_HORDE = "true"

--------------Inst7/BFD(6  quests)------------
Inst7Story = "位于灰谷佐拉姆海岸的黑暗深渊曾经是为供奉暗夜精灵月神艾露尼尔建造的。然而，在大爆炸中，神庙受到极大的冲击然后沉入了海中。它一直保持着原样——直到，其蕴含的古老的力量吸引来了纳迦和萨特。传说，古代怪兽阿库麦尔就居住在神庙遗迹中。作为古代之神最喜欢的宠物之一，阿库麦尔就一直生活在这个地区进行捕食。在阿库麦尔的吸引下，一群被称作幕光之锤的教徒也聚集在这里从事邪恶的勾当。"
Inst7Caption = "黑暗深渊"
Inst7QAA = "6 任务"
Inst7QAH = "5 任务"

--QUEST 1 Allianz

Inst7Quest1 = "1. 深渊中的知识"
Inst7Quest1_Attain = "18"
Inst7Quest1_Level = "23"
Inst7Quest1_Aim = "把洛迦里斯手稿带给铁炉堡的葛利·硬骨。Bring the Lorgalis Manuscript to Gerrig Bonegrip in the Forlorn Cavern in Ironforge."
Inst7Quest1_Location = "葛利·硬骨 (铁炉堡 - 荒弃的洞穴; "..YELLOW.."50,5"..WHITE..")"
Inst7Quest1_Note = "你可以在靠近 [2] 区的水中找到手稿。"
Inst7Quest1_Prequest = "无"
Inst7Quest1_Folgequest = "无"
--
Inst7Quest1name1 = "鼓励之戒"

--QUEST 2 Allianz

Inst7Quest2 = "2. 研究堕落"
Inst7Quest2_Attain = "19"
Inst7Quest2_Level = "24"
Inst7Quest2_Aim = "奥伯丁的戈沙拉·夜语需要8块堕落者的脑干。"
Inst7Quest2_Location = "戈沙拉·夜语 (黑海岸 - 奥伯丁; "..YELLOW.."38,43"..WHITE..")"
Inst7Quest2_Note = "前导任务可以从 阿古斯·夜语 (暴风城; 21,55) 处得到。 黑暗深渊副本里面和门前的所有纳迦都可能掉落脑干。"
Inst7Quest2_Prequest = "有，遥远的旅途"
Inst7Quest2_Folgequest = "无"
Inst7Quest2PreQuest = "true"
--
Inst7Quest2name1 = "虫壳护腕"
Inst7Quest2name2 = "教士斗篷"

--QUEST 3 Allianz

Inst7Quest3 = "3. 寻找塞尔瑞德"
Inst7Quest3_Attain = "19"
Inst7Quest3_Level = "24"
Inst7Quest3_Aim = "到黑色深渊去找到银月守卫塞尔瑞德。"
Inst7Quest3_Location = "哨兵山德拉斯 <银色黎明> (达纳苏斯; "..YELLOW.."55,24"..WHITE..")"
Inst7Quest3_Note = "你可以在 [4] 区找到银月守卫塞尔瑞德。"
Inst7Quest3_Prequest = "无"
Inst7Quest3_Folgequest = "有，黑暗深渊中的恶魔"

--QUEST 4 Alliance

Inst7Quest4 = "4. 黑暗深渊中的恶魔"
Inst7Quest4_Attain = "-"
Inst7Quest4_Level = "27"
Inst7Quest4_Aim = "把梦游者克尔里斯的头颅交给达纳苏斯的哨兵塞尔高姆。"
Inst7Quest4_Location = "哨兵塞尔瑞德 (黑暗深渊; "..YELLOW.."[4]"..WHITE..")"
Inst7Quest4_Note = "你可以从塞尔瑞德 [4] 处得到这个任务。克尔里斯 在 [8]。注意！如果你点燃了克尔里斯旁边的火焰，敌人会出现并攻击你。你可以在达纳苏斯(55,24)找到哨兵塞尔高姆"
Inst7Quest4_Prequest = "有，寻找塞尔瑞德"
Inst7Quest4_Folgequest = "无"
Inst7Quest4FQuest = "true"
--
Inst7Quest4name1 = "墓碑节杖"
Inst7Quest4name2 = "极光圆盾"

--QUEST 5 Alliance

Inst7Quest5 = "5. 暮光之锤的末日"
Inst7Quest5_Attain = "20"
Inst7Quest5_Level = "25"
Inst7Quest5_Aim = "收集10个暮光坠饰，把它们交给达纳苏斯的银月守卫玛纳杜斯。"
Inst7Quest5_Location = "银月守卫玛纳杜斯 (达纳苏斯; "..YELLOW.."55,23"..WHITE..")"
Inst7Quest5_Note = "每个暮光敌人都会掉落坠饰。"
Inst7Quest5_Prequest = "无"
Inst7Quest5_Folgequest = "无"
--
Inst7Quest5name1 = "云光长靴"
Inst7Quest5name2 = "赤木束带"

--QUEST 6 Alliance (hexenmeister)

Inst7Quest6 = "6. 索兰鲁克宝珠 (术士专属任务)"
Inst7Quest6_Attain = "21"
Inst7Quest6_Level = "26"
Inst7Quest6_Aim = "找到3块索兰鲁克宝珠的碎片和1块索兰鲁克宝珠的大碎片，把它们交给贫瘠之地的杜安·卡汉。"
Inst7Quest6_Location = "杜安·卡汉 (贫瘠之地; "..YELLOW.."49,67"..WHITE..")"
Inst7Quest6_Note = "只有术士才能得到这个任务！3块索兰鲁克宝珠的碎片，你可以从暮光侍僧 [黑暗深渊] 那里得到。那块索兰鲁克宝珠的大碎片，你要去 [影牙城堡] 找影牙魔魂狼人。"
Inst7Quest6_Prequest = "无"
Inst7Quest6_Folgequest = "无"
--
Inst7Quest6name1 = "索兰鲁克宝珠"
Inst7Quest6name2 = "索拉鲁克法杖"


--QUEST 1 Horde

Inst7Quest1_HORDE = "1. 阿库麦尔水晶"
Inst7Quest1_HORDE_Attain = "17"
Inst7Quest1_HORDE_Level = "22"
Inst7Quest1_HORDE_Aim = "收集20颗阿库麦尔蓝宝石，把它们交给灰谷的耶努萨克雷。"
Inst7Quest1_HORDE_Location = "耶努萨克雷 (灰谷 - 佐拉姆海岸; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest1_HORDE_Note = "前导任务 《帮助耶努萨克雷》 可以在 苏纳曼 (石爪山脉, 47,64) 接到。蓝宝石多生长在通往黑暗深渊入口的那条通道的洞穴墙壁上。"
Inst7Quest1_HORDE_Prequest = "有，《帮助耶努萨克雷》"
Inst7Quest1_HORDE_Folgequest = "无"
Inst7Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst7Quest2_HORDE = "2. 上古之神的仆从"
Inst7Quest2_HORDE_Attain = "-"
Inst7Quest2_HORDE_Level = "26"
Inst7Quest2_HORDE_Aim = "把潮湿的便笺交给灰谷的耶努萨克雷。 -> 杀掉黑暗深渊里的洛古斯·杰特，然后向灰谷的耶努萨克雷复命。"
Inst7Quest2_HORDE_Location = "潮湿的便笺 (掉落) (黑暗深渊; "..YELLOW..""..WHITE..")"
Inst7Quest2_HORDE_Note = "潮湿的便笺可从黑暗深渊海潮祭司处得到 (5% 掉落几率)。洛古斯·杰特在 [6]。"
Inst7Quest2_HORDE_Prequest = "无"
Inst7Quest2_HORDE_Folgequest = "无"
--
Inst7Quest2name1_HORDE = "巨拳指环 "
Inst7Quest2name2_HORDE = "栗壳衬肩"

--QUEST 3 Horde

Inst7Quest3_HORDE = "3. 废墟之间"
Inst7Quest3_HORDE_Attain = "-"
Inst7Quest3_HORDE_Level = "27"
Inst7Quest3_HORDE_Aim = "把深渊之核交给灰谷佐拉姆加前哨站里的耶努萨克雷。"
Inst7Quest3_HORDE_Location = "耶努萨克雷 (灰谷 - 佐拉姆海岸; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest3_HORDE_Note = "深渊之核在 [7]区 水域里. 当你得到深远之核后，阿奎尼斯男爵会出现并攻击你。他会掉落一件任务物品，你要把它带给佐拉姆前哨站的耶努萨克雷 (灰谷 - 佐拉姆海岸; 11,33)。"
Inst7Quest3_HORDE_Prequest = "无"
Inst7Quest3_HORDE_Folgequest = "无"

--QUEST 4 Horde

Inst7Quest4_HORDE = "4. 黑暗深渊中的恶魔"
Inst7Quest4_HORDE_Attain = "-"
Inst7Quest4_HORDE_Level = "27"
Inst7Quest4_HORDE_Aim = "把梦游者克尔里斯的头颅带回雷霆崖交给巴珊娜·符文图腾 。"
Inst7Quest4_HORDE_Location = "银月守卫塞尔瑞德 (黑暗深渊; "..YELLOW.."[4]"..WHITE..")"
Inst7Quest4_HORDE_Note = "在塞尔瑞德 [4] 处取得这个任务。 克尔里斯在 [8] 。注意！如果你点燃了克尔里斯身旁的火焰，会出现敌人攻击你。巴珊娜·符文图腾可以在雷霆崖 (70, 33) 处被找到。"
Inst7Quest4_HORDE_Prequest = "无"
Inst7Quest4_HORDE_Folgequest = "无"
--
Inst7Quest4name1_HORDE = "墓碑节杖"
Inst7Quest4name2_HORDE = "极光圆盾"

--QUEST 5 Horde (Warlock)

Inst7Quest5_HORDE = "5. 索兰鲁克宝珠(术士专属任务)"
Inst7Quest5_HORDE_Attain = "20"
Inst7Quest5_HORDE_Level = "25"
Inst7Quest5_HORDE_Aim = "找到3块索兰鲁克宝珠的碎片和1块索兰鲁克宝珠的大碎片，把它们交给贫瘠之地的杜安·卡汉。"
Inst7Quest5_HORDE_Location = "杜安·卡汉 (贫瘠之地; "..YELLOW.."49,57"..WHITE..")"
Inst7Quest5_HORDE_Note = "此任务只有术士能够完成！ 3块索兰鲁克宝珠的碎片可以从暮光侍僧[黑暗深渊]那里得到。 而那块索兰鲁克宝珠的大碎片则要找影牙魔魂狼人[影牙城堡]."
Inst7Quest5_HORDE_Prequest = "无"
Inst7Quest5_HORDE_Folgequest = "无"
--
Inst7Quest5name1_HORDE = "索兰鲁克宝珠"
Inst7Quest5name2_HORDE = "索拉鲁克法杖"

--------------Inst25 ( 8 quests)------------
Inst25Story = "在一千年之前，强大的古拉巴什王国被一次大型内部战争所毁灭。一部份被称为阿塔莱的巨魔牧师试图将古代血神哈卡灵魂掠夺者带回这个世界。虽然这些牧师被击败并最终被流放，这个伟大的王国变得四分五裂。流放的牧师逃到了北面，来到了悲伤沼泽。他们为哈卡建立了一座伟大的神庙——在那里他们期望能够把哈卡重新带回世间。伟大的守护神龙伊瑟拉了解了阿塔莱的计划并将神庙摧毁沉入沼泽之中。在今天，神庙沉没的遗迹被绿龙所守卫并阻止任何人进入或者出去。然而，有些阿塔莱巨魔从伊瑟拉的怒火中幸存下来并再此奖自己奉献与复活哈卡的事业中。 "
Inst25Caption = "沉没的神庙"
--classq
Inst25QAA = "8 任务"
Inst25QAH = "8 任务"

--QUEST 1 Allianz

Inst25Quest1 = "1. 进入阿塔哈卡神庙"
Inst25Quest1_Attain = "46"
Inst25Quest1_Level = "50"
Inst25Quest1_Aim = "为暴风城的布罗哈恩·铁桶收集10块阿塔莱石板。"
Inst25Quest1_Location = "布罗哈恩·铁桶 (暴风城; "..YELLOW.."64,20"..WHITE..")"
Inst25Quest1_Note = "石板你在神庙里到处都能见到。"
Inst25Quest1_Prequest = "有，调查神庙(同一 NPC) -> 拉普索迪的故事"
Inst25Quest1_Folgequest = "无"
Inst25Quest1PreQuest = "true"
--
Inst25Quest1name1 = "守护之符"

--QUEST 2 Allianz

Inst25Quest2 = "2. 沉没的神庙"
Inst25Quest2_Attain = "-"
Inst25Quest2_Level = "51"
Inst25Quest2_Aim = "到塔纳利斯找到玛尔冯·瑞文斯克。"
Inst25Quest2_Location = "安吉拉斯·月风 (菲拉斯; "..YELLOW.."31,45"..WHITE..")"
Inst25Quest2_Note = "你可以在 52,45 处找到玛尔冯·瑞文斯克。"
Inst25Quest2_Prequest = "无"
Inst25Quest2_Folgequest = "有，石环"

--QUEST 3 Allianz

Inst25Quest3 = "3. 深入神庙"
Inst25Quest3_Attain = "-"
Inst25Quest3_Level = "51"
Inst25Quest3_Aim = "在悲伤沼泽沉没的神庙中找到哈卡祭坛。"
Inst25Quest3_Location = "玛尔冯·瑞文斯克 (塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_Note = "祭坛 就在图中 [1] 的位置。"
Inst25Quest3_Prequest = "有，石环"
Inst25Quest3_Folgequest = "有，"
Inst25Quest3FQuest = "true"


--QUEST 4 Alliance

Inst25Quest4 = "4. 雕像群的秘密"
Inst25Quest4_Attain = "-"
Inst25Quest4_Level = "51"
Inst25Quest4_Aim = "到沉没的神庙去，揭开雕像群中隐藏的秘密。"
Inst25Quest4_Location = "玛尔冯·瑞文斯克 (塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_Note = "雕像群就在图中 [1] 区所示位置，按照如下：1-6的顺序打开他们。"
Inst25Quest4_Prequest = "有，深入神庙"
Inst25Quest4_Folgequest = "无"
Inst25Quest4FQuest = "true"
--
Inst25Quest4name1 = "哈卡莱骨灰"

--QUEST 5 Alliance

Inst25Quest5 = "5. 邪恶之雾"
Inst25Quest5_Attain = "50"
Inst25Quest5_Level = "52"
Inst25Quest5_Aim = "收集5份阿塔莱之雾的样本，然后向安戈洛环形山的穆尔金复命。"
Inst25Quest5_Location = "格雷甘·山酒 (菲拉斯; "..YELLOW.."45,25"..WHITE..")"
Inst25Quest5_Note = "前导任务《穆尔金和拉瑞安》开始于 穆尔金 (安戈洛环形山; 42,9)。 你可以从阿塔哈卡神庙里的 神庙深渊潜伏者，黑暗虫，或者 融合软泥怪 那里得到阿塔莱之雾。"
Inst25Quest5_Prequest = "有，穆尔金和拉瑞安 -> 造访格雷甘"
Inst25Quest5_Folgequest = "无"
Inst25Quest5PreQuest = "true"



--QUEST 6 Alliance

Inst25Quest6 = "6. 神灵哈卡 (系列任务)"
Inst25Quest6_Attain = "43"
Inst25Quest6_Level = "53"
Inst25Quest6_Aim = "将装满的哈卡之卵交给塔纳利斯的叶基亚。"
Inst25Quest6_Location = "叶基亚 (塔纳利斯; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_Note = "此系列任务始于《尖啸者的灵魂》 (同一 NPC，详见 [祖尔法拉克])。\n你必须在 [3] 使用哈卡之卵，触发事件。一旦事件开始，敌人会像潮水般涌出来攻击你。 其中一些敌人掉落哈卡莱之血。用这些血液熄灭包含哈卡灵魂能量的不灭火焰。当你熄灭所有的火焰时，哈卡的化身就可以进入我们的世界了。"
Inst25Quest6_Prequest = "有，尖啸者的灵魂 -> 远古之卵"
Inst25Quest6_Folgequest = "无"
Inst25Quest6PreQuest = "true"
--
Inst25Quest6name1 = "灰岩头盔"
Inst25Quest6name2 = "生命之力短剑"
Inst25Quest6name3 = "珠光头饰"

--QUEST 7 Alliance

Inst25Quest7 = "7. 预言者迦玛兰"
Inst25Quest7_Attain = "43"
Inst25Quest7_Level = "53"
Inst25Quest7_Aim = "辛特兰的阿塔莱流放者要你给他带回迦玛兰的头。"
Inst25Quest7_Location = "阿塔莱流放者 (辛特兰; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_Note = "你可以在 [4] 找到迦玛兰"
Inst25Quest7_Prequest = "无"
Inst25Quest7_Folgequest = "无"
--
Inst25Quest7name1 = "雨行护腿"
Inst25Quest7name2 = "流放者头盔"

--QUEST 8 Alliance
Inst25Quest8 = "8. 伊兰尼库斯精华"
Inst25Quest8_Attain = "-"
Inst25Quest8_Level = "55"
Inst25Quest8_Aim = "把伊兰尼库斯精华放在精华之泉里，精华之泉就在沉没的神庙中，伊兰尼库斯的巢穴里。"
Inst25Quest8_Location = "伊兰尼库斯精华 (掉落) (沉没的神庙)"
Inst25Quest8_Note = "伊兰尼库斯精华要打伊兰尼库斯才能掉落。你可以在 [6] 区找到他，精华之泉就在他旁边。"
Inst25Quest8_Prequest = "无"
Inst25Quest8_Folgequest = "无"
--
Inst25Quest8name1 = "被禁锢的伊兰尼库斯精华"


--QUEST 1 Horde

Inst25Quest1_HORDE = "1. 阿塔哈卡神庙"
Inst25Quest1_HORDE_Attain = "38"
Inst25Quest1_HORDE_Level = "50"
Inst25Quest1_HORDE_Aim = "收集20个哈卡神像，把它们带给斯通纳德的费泽鲁尔。"
Inst25Quest1_HORDE_Location = "费泽鲁尔 (悲伤沼泽 - 斯通纳德; "..YELLOW.."47,54"..WHITE..")"
Inst25Quest1_HORDE_Note = "神庙里的所有敌人都掉落哈卡神像"
Inst25Quest1_HORDE_Prequest = "有, 恶魔之犬 > 救赎 > 遗忘的记忆 > 失落的荣耀 > 悔恨的战士 > 泪水之池 > 阿塔莱流放者 > 向费泽鲁尔复命"
Inst25Quest1_HORDE_Folgequest = "无"
Inst25Quest1PreQuest_HORDE = "true"
--
Inst25Quest1name1_HORDE = "守护之符"

--QUEST 2 Horde

Inst25Quest2_HORDE = "2. 沉没的神庙"
Inst25Quest2_HORDE_Attain = ""
Inst25Quest2_HORDE_Level = "51"
Inst25Quest2_HORDE_Aim = "到塔纳利斯找到玛尔冯·瑞文斯克。"
Inst25Quest2_HORDE_Location = "巫医尤克里 (菲拉斯; "..YELLOW.."74,43"..WHITE..")"
Inst25Quest2_HORDE_Note = "玛尔冯·瑞文斯克的位置在 52,45"
Inst25Quest2_HORDE_Prequest = "无"
Inst25Quest2_HORDE_Folgequest = "有，石环"

--QUEST 3 Horde

Inst25Quest3_HORDE = "3. 深入神庙"
Inst25Quest3_HORDE_Attain = "-"
Inst25Quest3_HORDE_Level = "51"
Inst25Quest3_HORDE_Aim = "在悲伤沼泽沉没的神庙中找到哈卡祭坛。"
Inst25Quest3_HORDE_Location = "玛尔冯·瑞文斯克 (塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_HORDE_Note = "祭坛的位置在 [1] 区"
Inst25Quest3_HORDE_Prequest = "有，石环"
Inst25Quest3_HORDE_Folgequest = "有，雕像群的秘密"
Inst25Quest3FQuest_HORDE = "true"

--QUEST 4 Horde

Inst25Quest4_HORDE = "4. 雕像群的秘密"
Inst25Quest4_HORDE_Attain = "-"
Inst25Quest4_HORDE_Level = "51"
Inst25Quest4_HORDE_Aim = "到沉没的神庙去，揭开雕像群中隐藏的秘密。"
Inst25Quest4_HORDE_Location = "玛尔冯·瑞文斯克 (塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_HORDE_Note = "雕像群位置在 [1]， 按从1至6的顺序打开他们"
Inst25Quest4_HORDE_Prequest = "有，深入神庙"
Inst25Quest4_HORDE_Folgequest = "无"
Inst25Quest4FQuest_HORDE = "true"
--
Inst25Quest4name1_HORDE = "哈卡莱骨灰"

--QUEST 5 Horde

Inst25Quest5_HORDE = "5. 除草器的燃料"
Inst25Quest5_HORDE_Attain = "50"
Inst25Quest5_HORDE_Level = "52"
Inst25Quest5_HORDE_Aim = "收集5份阿塔莱之雾的样本，然后将它们送到马绍尔营地的拉瑞安那里。"
Inst25Quest5_HORDE_Location = "莉芙·雷兹菲克斯 (贫瘠之地; "..YELLOW.."62,38"..WHITE..")"
Inst25Quest5_HORDE_Note = "前导任务 《拉瑞安和穆尔金》 开始于 拉瑞安 (安戈洛环形山 45,8). 沉没的神庙里的神庙深渊潜伏者、黑暗虫和软泥怪身上都有阿塔莱之雾。"
Inst25Quest5_HORDE_Prequest = "有，拉瑞安和穆尔金 > 玛尔冯的车间"
Inst25Quest5_HORDE_Folgequest = "无"
Inst25Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst25Quest6_HORDE = "6. 神灵哈卡 (系列任务)"
Inst25Quest6_HORDE_Attain = "43"
Inst25Quest6_HORDE_Level = "53"
Inst25Quest6_HORDE_Aim = "将装满的哈卡之卵交给塔纳利斯的叶基亚。"
Inst25Quest6_HORDE_Location = "叶基亚 (塔纳利斯; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_HORDE_Note = "此系列任务开始于 《尖啸者的灵魂》，任务给予人也是这个NPC叶基亚(参见 [祖尔法拉克]).\n你需要在[3]使用哈卡之卵激活一个事件。一旦开始，敌人会像潮水般涌来攻击你。其中一些敌人掉落哈卡莱之血。用这些血液熄灭包含哈卡灵魂能量的不灭火焰。当你熄灭所有的火焰时，哈卡的化身就可以进入我们的世界了。"
Inst25Quest6_HORDE_Prequest = "有，尖啸者的灵魂 -> 远古之卵"
Inst25Quest6_HORDE_Folgequest = "无"
Inst25Quest6PreQuest_HORDE = "true"
--
Inst25Quest6name1_HORDE = "灰岩头盔"
Inst25Quest6name2_HORDE = "生命之力短剑"
Inst25Quest6name3_HORDE = "珠光头饰"

--QUEST 7 Horde

Inst25Quest7_HORDE = "7. 预言者迦玛兰"
Inst25Quest7_HORDE_Attain = "43"
Inst25Quest7_HORDE_Level = "53"
Inst25Quest7_HORDE_Aim = "辛特兰的阿塔莱流放者要你给他带回迦玛兰的头。"
Inst25Quest7_HORDE_Location = "阿塔莱流放者 (辛特兰; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_HORDE_Note = "你会在[4]找到迦玛兰"
Inst25Quest7_HORDE_Prequest = "无"
Inst25Quest7_HORDE_Folgequest = "无"
--
Inst25Quest7name1_HORDE = "雨行护腿"
Inst25Quest7name2_HORDE = "流放者头盔"

--QUEST 8 Horde

Inst25Quest8_HORDE = "8. 伊兰尼库斯精华"
Inst25Quest8_HORDE_Attain = "-"
Inst25Quest8_HORDE_Level = "55"
Inst25Quest8_HORDE_Aim = "把伊兰尼库斯精华放在精华之泉里，精华之泉就在沉没的神庙中，伊兰尼库斯的巢穴里。"
Inst25Quest8_HORDE_Location = "伊兰尼库斯精华 (掉落) (沉没的神庙)"
Inst25Quest8_HORDE_Note = "伊兰尼库斯会掉落伊兰尼库斯精华。你会在[6]找到在伊兰尼库斯旁边的精华之泉。"
Inst25Quest8_HORDE_Prequest = "无"
Inst25Quest8_HORDE_Folgequest = "无"
--
Inst25Quest8name1_HORDE = "被禁锢的伊兰尼库斯精华"

--------------Burg Shadowfang/Inst21/BSF ------------
Inst21Story = "在第三次大战中，奇灵托的法师和亡灵天灾进行了殊死的战斗。当达拉然的法师最终在战斗中战死之后，他们的意志转移到了复苏的亡灵天灾身上，然后重生了。由于对于缓慢的进展感到失望（并且对他的手下的建议不予理会）大法师阿鲁高选择召唤异次沅空间的生物来壮大达拉然日渐消失的力量。阿鲁高的召唤将贪婪的狼人带到了艾泽拉斯大陆。这些狂暴的狼型生物不仅屠杀了亡灵天灾的人，而且迅速将目标转向那些法师。那些狼人开始围攻席瓦莱恩男爵的城堡。这座位于焚木村的城堡不久之后变成了黑暗势力的聚集地并从此荒废。因为对于自己罪过的愧疚，阿鲁高将那些狼人当作自己的孩子并隐居在“影牙城堡”中。据说他还住在那里，被他巨大的宠物芬鲁斯所保护着，另外，在城堡中还徘徊着瓦莱恩男爵的那些复仇的幽灵。"
Inst21Caption = "影牙城堡"
Inst21QAA = "2 任务"
Inst21QAH = "4 任务"

--Quest 1 allianz

Inst21Quest1 = "1. The Test of Righteousness (Paladin)"
Inst21Quest1_Level = "22"
Inst21Quest1_Attain = "20"
Inst21Quest1_Aim = "按照乔丹的武器材料单上的说明去寻找一些白石橡木、精炼矿石、乔丹的铁锤和一块科尔宝石，然后回到铁炉堡去见乔丹·斯迪威尔。"
Inst21Quest1_Location = "乔丹·斯迪威尔 (丹莫罗 - 铁炉堡 "..YELLOW.."52,36 "..WHITE..")"
Inst21Quest1_Note = "要查看材料单请点击  [正义试炼信息]."
Inst21Quest1_Prequest = "有，勇气之书 -> 正义试炼"
Inst21Quest1_Folgequest = "有，正义试炼"
Inst21Quest1PreQuest = "true"
--
Inst21Quest1name1 = "维里甘之拳"
Inst21Quest1_Page = {2, "只有圣骑士能够得到这个任务！\n1. 白石橡木 从 [死亡矿井] 的地精木匠那里得到。\n2. 要得到精炼矿石，你必须与白洛尔·石手交谈 (洛克莫丹; 35,44 )。他给你《白洛尔的矿石》这个任务。你可以在一棵树后面找到乔丹的矿石 （71,21）\n3. 乔丹的铁锤 位置在 [影牙城堡] 靠近 [B] (固定位置)。\n4. 要得到科尔宝石，你必须去找桑迪斯·织风 (黑海岸; 37,40) ，并完成《寻找科尔宝石》任务。要完成这个任务，你必须杀死 [黑暗深渊] 前面的 黑暗深渊智者 或者 黑暗深渊海潮祭司。他们掉落的被污染的科尔宝石，可以让桑迪斯·织风为你净化。", };

--QUEST 2 Alliance (hexenmeister)

Inst21Quest2 = "2. 索兰鲁克宝珠 (术士专属任务)"
Inst21Quest2_Attain = "21"
Inst21Quest2_Level = "26"
Inst21Quest2_Aim = "找到3块索兰鲁克宝珠的碎片和1块索兰鲁克宝珠的大碎片，把它们交给贫瘠之地的杜安·卡汉。"
Inst21Quest2_Location = "杜安·卡汉 (贫瘠之地; "..YELLOW.."49,67"..WHITE..")"
Inst21Quest2_Note = "只有术士能够得到这个任务！ 3块索兰鲁克宝珠的碎片可从暮光侍僧[黑暗深渊]身上得到。那块索兰鲁克宝珠的大碎片可从影牙魔魂狼人[影牙城堡]身上得到。"
Inst21Quest2_Prequest = "无"
Inst21Quest2_Folgequest = "无"
--
Inst21Quest2name1 = "索兰鲁克宝珠"
Inst21Quest2name2 = "索拉鲁克法杖"

--QUEST 1 Horde

Inst21Quest1_HORDE = "1. 影牙城堡里的亡灵哨兵"
Inst21Quest1_HORDE_Attain = "-"
Inst21Quest1_HORDE_Level = "25"
Inst21Quest1_HORDE_Aim = "找到亡灵哨兵阿达曼特和亡灵哨兵文森特。"
Inst21Quest1_HORDE_Location = "高级执行官哈德瑞克 (银松森林; "..YELLOW.."43,40"..WHITE..")"
Inst21Quest1_HORDE_Note = "阿达曼特 位于 [1]，文森特在你一进庭院的右侧。"
Inst21Quest1_HORDE_Prequest = "无"
Inst21Quest1_HORDE_Folgequest = "无"
--
Inst21Quest1name1_HORDE = "鬼魂衬肩"

--QUEST 2 Horde

Inst21Quest2_HORDE = "2. 乌尔之书"
Inst21Quest2_HORDE_Attain = "16"
Inst21Quest2_HORDE_Level = "26"
Inst21Quest2_HORDE_Aim = "把乌尔之书带给幽暗城炼金区里的看守者贝尔杜加。"
Inst21Quest2_HORDE_Location = "看守者贝尔杜加 (幽暗城; "..YELLOW.."53,54"..WHITE..")"
Inst21Quest2_HORDE_Note = "书在 [6](你进门的左边)。"
Inst21Quest2_HORDE_Prequest = "无"
Inst21Quest2_HORDE_Folgequest = "无"
--
Inst21Quest2name1_HORDE = "灰色长靴"
Inst21Quest2name2_HORDE = "钢钉护腕"

--QUEST 3 Horde

Inst21Quest3_HORDE = "3. 除掉阿鲁高"
Inst21Quest3_HORDE_Attain = "?"
Inst21Quest3_HORDE_Level = "27"
Inst21Quest3_HORDE_Aim = "杀死阿鲁高，把他的头带给瑟伯切尔的达拉尔·道恩维沃尔。"
Inst21Quest3_HORDE_Location = "达拉尔·道恩维沃尔 (银松森林 - 瑟伯切尔; "..YELLOW.."44,39"..WHITE..")"
Inst21Quest3_HORDE_Note = "你可以在 [8] 找到阿鲁高。"
Inst21Quest3_HORDE_Prequest = "无"
Inst21Quest3_HORDE_Folgequest = "无"
--
Inst21Quest3name1_HORDE = "希尔瓦娜斯的图章"

--QUEST 4 Horde (hexenmeister)

Inst21Quest4_HORDE = "4. 索兰鲁克宝珠 (术士专属任务)"
Inst21Quest4_HORDE_Attain = "21"
Inst21Quest4_HORDE_Level = "26"
Inst21Quest4_HORDE_Aim = "找到3块索兰鲁克宝珠的碎片和1块索兰鲁克宝珠的大碎片，把它们交给贫瘠之地的杜安·卡汉。"
Inst21Quest4_HORDE_Location = "杜安·卡汉 (贫瘠之地; "..YELLOW.."49,67"..WHITE..")"
Inst21Quest4_HORDE_Note = "只有术士可以领取这个任务！ 3块索兰鲁克宝珠的碎片可从暮光侍僧[黑暗深渊]身上得到。那块索兰鲁克宝珠的大碎片可从影牙魔魂狼人[影牙城堡]身上得到。"
Inst21Quest4_HORDE_Prequest = "无"
Inst21Quest4_HORDE_Folgequest = "无"
--
Inst21Quest4name1_HORDE = "索兰鲁克宝珠"
Inst21Quest4name2_HORDE = "索拉鲁克法杖"

--------------Inst5/Blackrocktiefen/BRD ------------
Inst5Story = "黑石深渊曾经是黑铁矮人的伟大都城，这个火山中的迷宫现在成为拉格纳罗斯火焰领主的王座所在地。拉格纳罗斯找到了使用石头和设计图来创造一支无敌石头人均对来帮助它征服黑石深渊。即使是需要打败奈法利安和他的龙子龙孙，拉格纳罗斯会不惜一切代价来达到最后的胜利。"
Inst5Caption = "黑石深渊"
Inst5QAA = "14 任务"
Inst5QAH = "14 任务"

--QUEST1 Allianz

Inst5Quest1 = "1. 黑铁的遗产"
Inst5Quest1_Attain = "48"
Inst5Quest1_Level = "52"
Inst5Quest1_Aim = "杀掉弗诺斯·达克维尔并拿回战锤铁胆。把铁胆之锤拿到索瑞森神殿去，将其放在弗兰克罗恩·铸铁的雕像上。"
Inst5Quest1_Location = "弗兰克罗恩·铸铁 (黑石)"
Inst5Quest1_Note = "弗兰克罗恩在黑石的中心，在他的墓上方。你必须死亡后才能见到他！和他交谈2次，激活任务。\n弗诺斯·达克维尔 在 [9] 区。你会在 [7] 区找到神殿。"
Inst5Quest1_Prequest = "无"
Inst5Quest1_Folgequest = "无"
--
Inst5Quest1name1 = "暗炉钥匙"

--QUEST2 Allianz

Inst5Quest2 = "2. 雷布里·斯库比格特"
Inst5Quest2_Attain = "50"
Inst5Quest2_Level = "53"
Inst5Quest2_Aim = "把雷布里的头颅交给燃烧平原的尤卡·斯库比格特。"
Inst5Quest2_Location = "尤卡·斯库比格特 (燃烧平原 "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_Note = "前导任务从 尤尔巴·斯库比格特 (塔纳利斯; 67,23)那儿得到。\n雷布里 位于 [15]."
Inst5Quest2_Prequest = "有，尤卡·斯库比格特"
Inst5Quest2_Folgequest = "无"
Inst5Quest2PreQuest = "true"
--
Inst5Quest2name1 = "怨恨之靴"
Inst5Quest2name2 = "忏悔肩铠 "
Inst5Quest2name3 = "钢条护甲"

--QUEST3 Allianz

Inst5Quest3 = "3. 爱情药水"
Inst5Quest3_Attain = "50"
Inst5Quest3_Level = "54"
Inst5Quest3_Aim = "将4份格罗姆之血、10块巨型银矿和装满水的娜玛拉之瓶交给黑石深渊的娜玛拉小姐。"
Inst5Quest3_Location = "娜玛拉小姐 (黑石深渊, 旅店)"
Inst5Quest3_Note = "巨型银矿 可从艾萨拉的巨人们那里得到。格罗姆之血可以请学习了草药学的玩家帮助寻找。 你可以在葛拉卡盆地 (安戈洛环形山; 31,50) 为瓶子装满水。\n完成任务后，你可以使用后门而不必杀死法拉克斯。"
Inst5Quest3_Prequest = "无"
Inst5Quest3_Folgequest = "无"
--
Inst5Quest3name1 = "镣铐护腕 "
Inst5Quest3name2 = "娜玛拉的腰带"

--QUEST4 Allianz

Inst5Quest4 = "4. 霍尔雷·黑须"
Inst5Quest4_Attain = "?"
Inst5Quest4_Level = "55"
Inst5Quest4_Aim = "把遗失的雷酒秘方带给卡拉诺斯的拉格纳·雷酒。"
Inst5Quest4_Location = "拉格纳·雷酒  (丹莫罗 - 卡拉诺斯 "..YELLOW.."46,52"..WHITE..")"
Inst5Quest4_Note = "前导任务从 恩诺哈尔·雷酒 (诅咒之地; 61,18) 处获得。\n如果你在[15]区摧毁装有雷霆啤酒的桶，守卫就会出现。秘方就在这其中一个守卫身上。"
Inst5Quest4_Prequest = "有，拉格纳·雷酒"
Inst5Quest4_Folgequest = "无"
Inst5Quest4PreQuest = "true"
--
Inst5Quest4name1 = "矮人黑啤酒"
Inst5Quest4name2 = "迅捷木槌"
Inst5Quest4name3 = "叉刃巨斧"


--QUEST5 Allianz

Inst5Quest5 = "5. 伊森迪奥斯！"
Inst5Quest5_Attain = "?"
Inst5Quest5_Level = "56"
Inst5Quest5_Aim = "在黑石深渊里找到伊森迪奥斯，然后把他干掉！"
Inst5Quest5_Location = "加琳达 (燃烧平原 "..YELLOW.."85,69"..WHITE..")"
Inst5Quest5_Note = "前导任务也从此NPC加琳达处获得。 征服者派隆，他就守在黑石采矿场的黑石深渊入口处。\n伊森迪奥斯，你可以在[10]区找到他！"
Inst5Quest5_Prequest = "有，征服者派隆"
Inst5Quest5_Folgequest = "无"
Inst5Quest5PreQuest = "true"
--
Inst5Quest5name1 = "阳焰斗篷 "
Inst5Quest5name2 = "夜暮手套"
Inst5Quest5name3 = "地穴恶魔护腕"
Inst5Quest5name4 = "坚定手套"

--QUEST6 Horde

Inst5Quest6 = "6. 山脉之心"
Inst5Quest6_Attain = "50"
Inst5Quest6_Level = "55"
Inst5Quest6_Aim = "把山脉之心交给燃烧平原的麦克斯沃特·尤博格林。"
Inst5Quest6_Location = "麦克斯沃特·尤博格林t (燃烧平原 "..YELLOW.."65,23"..WHITE..")"
Inst5Quest6_Note = "你可以在图上[10]所示位置找到山脉之心。"
Inst5Quest6_Prequest = "无"
Inst5Quest6_Folgequest = "无"

--QUEST6 Allianz

Inst5Quest7 = "7. 好东西"
Inst5Quest7_Attain = "?"
Inst5Quest7_Level = "56"
Inst5Quest7_Aim = "到黑石深渊去找到20个黑铁挎包。当你完成任务之后，回到奥拉留斯那里复命。你认为黑石深渊里的黑铁矮人应该会有这些黑铁挎包。"
Inst5Quest7_Location = "奥拉留斯 (燃烧平原 "..YELLOW.."84,68"..WHITE..")"
Inst5Quest7_Note = "所有矮人都可能掉落挎包。"
Inst5Quest7_Prequest = "无"
Inst5Quest7_Folgequest = "无"
--
Inst5Quest7name1 = "肮脏的背包"

--QUEST7 Allianz

Inst5Quest8 = "8. 温德索尔元帅 (奥妮克希亚-系列任务)"
Inst5Quest8_Attain = "48"
Inst5Quest8_Level = "54"
Inst5Quest8_Aim = "到西北部的黑石山脉去，在黑石深渊中找到温德索尔元帅的下落。\n狼狈不堪的约翰曾告诉你说温德索尔被关进了一个监狱。"
Inst5Quest8_Location = "麦克斯韦尔元帅 (燃烧平原 "..YELLOW.."84,68"..WHITE..")"
Inst5Quest8_Note = "此系列任务始于 赫林迪斯·河角 (燃烧平原 "..YELLOW.."85,68"..WHITE..")。\n温德索尔元帅位于图中 [4] 所示位置。完成这个任务后，你要回到麦克斯韦尔元帅那里。"
Inst5Quest8_Prequest = "有，黑龙的威胁 -> 真正的主人"
Inst5Quest8_Folgequest = "有，被遗弃的希望 -> 弄皱的便笺"
Inst5Quest8PreQuest = "true"
--
Inst5Quest8name1 = "监督官头盔"
Inst5Quest8name2 = "盾甲铁靴"
Inst5Quest8name3 = "风剪护腿"

--QUEST8 Allianz

Inst5Quest9 = "9. 弄皱的便笺 (奥妮克希亚-系列任务)"
Inst5Quest9_Attain = "51"
Inst5Quest9_Level = "54"
Inst5Quest9_Aim = "温德索尔元帅也许会对你手中的东西感兴趣。毕竟，希望还没有被完全扼杀。"
Inst5Quest9_Location = "弄皱的便笺(掉落) (黑石深渊)"
Inst5Quest9_Note = "温德索尔元帅在图上 [4] 所示位置。"
Inst5Quest9_Prequest = "有，温德索尔元帅"
Inst5Quest9_Folgequest = "有，一丝希望"
Inst5Quest9FQuest = "true"

--QUEST9 Allianz

Inst5Quest10 = "10. 一丝希望 (奥妮克希亚-系列任务)"
Inst5Quest10_Attain = "51"
Inst5Quest10_Level = "58"
Inst5Quest10_Aim = "找回温德索尔元帅遗失的情报。\n温德索尔元帅确信那些情报在安格弗将军和傀儡统帅阿格曼奇的手里。"
Inst5Quest10_Location = "温德索尔元帅 (黑石深渊 "..YELLOW.."[4]"..WHITE..")"
Inst5Quest10_Note = "温德索尔元帅 位于图上 [4] 所示位置。\n你可以在 [14] 找到傀儡统帅阿格曼奇, 在 [13] 找到安格弗将军."
Inst5Quest10_Prequest = "有，弄皱的便笺"
Inst5Quest10_Folgequest = "有，冲破牢笼！"
Inst5Quest10FQuest = "true"

--QUEST10 Allianz

Inst5Quest11 = "11. 冲破牢笼！ (奥妮克希亚-系列任务)"
Inst5Quest11_Attain = "54"
Inst5Quest11_Level = "58"
Inst5Quest11_Aim = "帮助温德索尔元帅拿回他的装备并救出他的朋友。当你成功之后就回去向麦克斯韦尔元帅复命。"
Inst5Quest11_Location = "温德索尔元帅 (黑石深渊 "..YELLOW.."[4]"..WHITE..")"
Inst5Quest11_Note = "温德索尔元帅 在 [4]。\n麦克斯韦尔元帅在燃烧平原 ("..YELLOW.."84,68"..WHITE..")"--	^^^^^^	如果在触发事件前，你有译码戒指并清干净了到入口的道路，这个任务就显得比较容易了。	^^^^^^
Inst5Quest11_Prequest = "有，一丝希望"
Inst5Quest11_Folgequest = "有，集合在暴风城"
Inst5Quest11FQuest = "true"
--
Inst5Quest11name1 = "元素屏障"
Inst5Quest11name2 = "清算之刃"
Inst5Quest11name3 = "作战之刃"

--QUEST12 Allianz

Inst5Quest12 = "12. 烈焰精华 (系列任务)"
Inst5Quest12_Attain = "52"
Inst5Quest12_Level = "58"
Inst5Quest12_Aim = "到黑石深渊去杀掉贝尔加。\n你只知道这个巨型怪物住在黑石深渊的最深处。记住你要使用特殊的黑龙皮从贝尔加的尸体上采集烈焰精华。\n将你采集到的烈焰精华交给塞勒斯·萨雷芬图斯。"
Inst5Quest12_Location = "塞勒斯·萨雷芬图斯 (燃烧平原 "..YELLOW.."94,31"..WHITE..")"
Inst5Quest12_Note = "此系列任务始于 卡拉然·温布雷 (Sengende Schlucht; 39,38).\n贝尔加位于 [11]."
Inst5Quest12_Prequest = "有，无瑕之焰 -> 烈焰精华"
Inst5Quest12_Folgequest = "无"
Inst5Quest12PreQuest = "true"
--
Inst5Quest12name1 = "页岩斗篷"
Inst5Quest12name2 = "龙皮肩铠"
Inst5Quest12name3 = "火山腰带"

--QUEST13 Allianz

Inst5Quest13 = "13. 卡兰·巨锤"
Inst5Quest13_Attain = "?"
Inst5Quest13_Level = "59"
Inst5Quest13_Aim = " 去黑石深渊找到卡兰·巨锤。\n国王提到卡兰在那里负责看守囚犯——也许你应该在监狱附近寻找他。"
Inst5Quest13_Location = "国王麦格尼·铜须 (丹莫罗 - 铁炉堡 "..YELLOW.."39,55"..WHITE..")"
Inst5Quest13_Note = "前导任务始于 皇家历史学家阿克瑟努斯 (丹莫罗 - 铁炉堡; 38,55)。卡兰·巨锤位于 [2]。"
Inst5Quest13_Prequest = "有，索瑞森废墟"
Inst5Quest13_Folgequest = "有，卡兰的故事 - > 糟糕的消息 - > 王国的命运 - > 语出惊人的公主"
Inst5Quest13PreQuest = "true"

--QUEST14 Allianz

Inst5Quest14 = "14. 王国的命运"
Inst5Quest14_Attain = "?"
Inst5Quest14_Level = "59"
Inst5Quest14_Aim = "回到黑石深渊，从达格兰·索瑞森大帝的魔掌中救出铁炉堡公主茉艾拉·铜须。"
Inst5Quest14_Location = "国王麦格尼·铜须 (丹莫罗 - 铁炉堡 "..YELLOW.."39,55"..WHITE..")"
Inst5Quest14_Note = "公主茉艾拉·铜须 位于 [21]。战斗中她可能会治疗达格兰。试着尽可能打断她。但是一定不能让她死掉，否则你的任务将会失败！与她交谈过后，你还要回到麦格尼·铜须那儿去。"
Inst5Quest14_Prequest = "有，糟糕的消息"
Inst5Quest14_Folgequest = "有，语出惊人的公主"
Inst5Quest14FQuest = "true"
--
Inst5Quest14name1 = "麦格尼的意志"
Inst5Quest14name2 = "铁炉堡歌唱石"

--QUEST1 Horde

Inst5Quest1_HORDE = "1. 黑铁的遗产"
Inst5Quest1_HORDE_Attain = "48"
Inst5Quest1_HORDE_Level = "52"
Inst5Quest1_HORDE_Aim = "杀掉弗诺斯·达克维尔并拿回战锤铁胆。把铁胆之锤拿到索瑞森神殿去，将其放在弗兰克罗恩·铸铁的雕像上。"
Inst5Quest1_HORDE_Location = "弗兰克罗恩·铸铁 (黑石)"
Inst5Quest1_HORDE_Note = "弗兰克罗恩在黑石深渊中部他的墓上面。你必须死了以后才能见到他！和他交谈两次才能开始这个任务。\n弗诺斯·达克维尔的位置在 [9]。你可以在[7]区旁边找到神殿。"
Inst5Quest1_HORDE_Prequest = "无"
Inst5Quest1_HORDE_Folgequest = "无"
--
Inst5Quest1name1_HORDE = "暗炉钥匙"

--QUEST2 Horde

Inst5Quest2_HORDE = "2. 雷布里·斯库比格特"
Inst5Quest2_HORDE_Attain = "50"
Inst5Quest2_HORDE_Level = "53"
Inst5Quest2_HORDE_Aim = "把雷布里·斯库比格特的头颅交给燃烧平原的尤卡·斯库比格特。"
Inst5Quest2_HORDE_Location = "尤卡·斯库比格特 (燃烧平原 "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_HORDE_Note = "前导任务从尤尔巴·斯库比格特 (塔纳利斯; 67,23)处得到。\n雷布里·斯库比格特的位置在 [15] 区。"
Inst5Quest2_HORDE_Prequest = "有, 尤卡·斯库比格特"
Inst5Quest2_HORDE_Folgequest = "无"
Inst5Quest2PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "怨恨之靴"
Inst5Quest11name2_HORDE = "忏悔肩铠"
Inst5Quest11name3_HORDE = "钢条护甲"

--QUEST3 Horde

Inst5Quest3_HORDE = "3. 爱情药水 "
Inst5Quest3_HORDE_Attain = "50"
Inst5Quest3_HORDE_Level = "54"
Inst5Quest3_HORDE_Aim = "将4份格罗姆之血、10块巨型银矿和装满水的娜玛拉之瓶交给黑石深渊的娜玛拉小姐。"
Inst5Quest3_HORDE_Location = "娜玛拉 (黑石深渊 - 旅店)"
Inst5Quest3_HORDE_Note = "巨型银矿可从艾萨拉的巨人们那里弄到，格罗姆之血可以请精通草药学的朋友帮忙，你可以在葛拉卡盆地 (安戈洛环形山; 31,50) 为瓶子装满水。\n完成任务后，你可以使用后门而不必杀死法拉克斯。"
Inst5Quest3_HORDE_Prequest = "无"
Inst5Quest3_HORDE_Folgequest = "无"
--
Inst5Quest3name1_HORDE = "镣铐护腕"
Inst5Quest3name2_HORDE = "娜玛拉的腰带"

--QUEST 4 Horde

Inst5Quest4_HORDE = "4. 遗失的雷酒秘方"
Inst5Quest4_HORDE_Attain = "50"
Inst5Quest4_HORDE_Level = "55"
Inst5Quest4_HORDE_Aim = "把遗失的雷酒秘方交给卡加斯的薇薇安·拉格雷。"
Inst5Quest4_HORDE_Location = "暗法师薇薇安·拉格雷 <卡加斯远征军> ( 荒芜之地 - 卡加斯; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest4_HORDE_Note = "前导任务由幽暗城(50,68)药剂师金格 <皇家药剂师学会>给予。\n秘方在某个守卫身上，只要你破坏[15]区的酒桶这些守卫就会出现。"
Inst5Quest4_HORDE_Prequest = "有，薇薇安·拉格雷"
Inst5Quest4_HORDE_Folgequest = "无"
Inst5Quest4PreQuest_HORDE = "true"
--
Inst5Quest4name1_HORDE = "超强治疗药水"
Inst5Quest4name2_HORDE = "强效法力药水"
Inst5Quest4name3_HORDE = "迅捷木槌"
Inst5Quest4name4_HORDE = "叉刃巨斧"

--QUEST5 Horde

Inst5Quest5_HORDE = "5. 山脉之心"
Inst5Quest5_HORDE_Attain = "50"
Inst5Quest5_HORDE_Level = "55"
Inst5Quest5_HORDE_Aim = "把山脉之心交给燃烧平原的麦克斯沃特·尤博格林。"
Inst5Quest5_HORDE_Location = "麦克斯沃特·尤博格林 (燃烧平原 "..YELLOW.."65,23"..WHITE..")"
Inst5Quest5_HORDE_Note = "你在[10]区可以安全地找到山脉之心。"
Inst5Quest5_HORDE_Prequest = "无"
Inst5Quest5_HORDE_Folgequest = "无"

--QUEST 6 Horde

Inst5Quest6_HORDE = "6. 格杀勿论：黑铁矮人"
Inst5Quest6_HORDE_Attain = "48"
Inst5Quest6_HORDE_Level = "52"
Inst5Quest6_HORDE_Aim = "到黑石深渊去消灭那些邪恶的侵略者！军官高图斯要你去杀死15个铁怒卫士、10个铁怒狱卒和5个铁怒步兵。完成任务之后回去向他复命。"
Inst5Quest6_HORDE_Location = "通缉 (荒芜之地 - 卡加斯; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest6_HORDE_Note = "矮人可在黑石深渊第一部分找到。\n卡加斯的高图斯在瞭望塔顶(荒芜之地; 5,47)。"
Inst5Quest6_HORDE_Prequest = "无"
Inst5Quest6_HORDE_Folgequest = "有，格杀勿论：高阶黑铁军官"

--QUEST 7 Horde

Inst5Quest7_HORDE = "7. 格杀勿论：高阶黑铁军官"
Inst5Quest7_HORDE_Attain = "50"
Inst5Quest7_HORDE_Level = "54"
Inst5Quest7_HORDE_Aim = "到黑石深渊去消灭那些邪恶的侵略者！高图斯军阀要你杀死10个铁怒医师、10个铁怒士兵和10个铁怒军官。完成任务之后回去向他复命。"
Inst5Quest7_HORDE_Location = "通缉 (荒芜之地 - 卡加斯; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest7_HORDE_Note = "矮人可以在[11]区贝尔加附近被找到。 卡加斯的高图斯在瞭望塔顶(荒芜之地; 5,47)。\n 任务开始于 雷克斯洛特(卡加斯; 5,47)。 格拉克·洛克鲁布位置在燃烧平原(38,35)。 要绑定他并开始护送任务（精英），他的生命需要减少到低于50%。"
Inst5Quest7_HORDE_Prequest = "有，格杀勿论：黑铁矮人"
Inst5Quest7_HORDE_Folgequest = "有，格拉克·洛克鲁布 -> 押送囚徒(护送任务)"
Inst5Quest7FQuest_HORDE = "true"

--QUEST 8 Horde

Inst5Quest8_HORDE = "8. 行动：杀死安格弗将军"
Inst5Quest8_HORDE_Attain = "55"
Inst5Quest8_HORDE_Level = "58"
Inst5Quest8_HORDE_Aim = "到黑石深渊去杀掉安格弗将军！当任务完成之后向军官高图斯复命。"
Inst5Quest8_HORDE_Location = "军官高图斯 (荒芜之地 - 卡加斯; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest8_HORDE_Note = "安格弗将军位置在 [13] 区。注意：当他生命低于30%时，他会召唤帮手！"
Inst5Quest8_HORDE_Prequest = "有, 押送囚徒"
Inst5Quest8_HORDE_Folgequest = "无"
Inst5Quest8FQuest_HORDE = "true"
--
Inst5Quest8name1_HORDE = "征服者勋章"

--QUEST 5 Horde

Inst5Quest9_HORDE = "9. 机器的崛起"
Inst5Quest9_HORDE_Attain = "?"
Inst5Quest9_HORDE_Level = "58"
Inst5Quest9_HORDE_Aim = "找到并杀掉傀儡统帅阿格曼奇，将他的头交给鲁特维尔。你还需要从守卫着阿格曼奇的狂怒傀儡和战斗傀儡身上收集10块完整的元素核心。"
Inst5Quest9_HORDE_Location = "鲁特维尔·沃拉图斯 (荒芜之地; "..YELLOW.."25,44"..WHITE..")"
Inst5Quest9_HORDE_Note = "前导任务来自圣者塞朵拉·穆瓦丹尼(荒芜之地 - 卡加斯; 3,47).\n你可以在[14]区发现阿格曼奇。"
Inst5Quest9_HORDE_Prequest = "有，机器的崛起"
Inst5Quest9_HORDE_Folgequest = "无"
Inst5Quest9PreQuest_HORDE = "true"
--
Inst5Quest9name1_HORDE = "蓝月披肩"
Inst5Quest9name2_HORDE = "雨法师斗篷"
Inst5Quest9name3_HORDE = "黑陶鳞片护甲"
Inst5Quest9name4_HORDE = "熔岩护手"


--QUEST13 Horde

Inst5Quest10_HORDE = "10. 烈焰精华 (系列任务)"
Inst5Quest10_HORDE_Attain = "52"
Inst5Quest10_HORDE_Level = "58"
Inst5Quest10_HORDE_Aim = "到黑石深渊去杀掉贝尔加。 [...] 将包起来的烈焰精华还给塞勒斯·萨雷芬图斯."
Inst5Quest10_HORDE_Location = "塞勒斯·萨雷芬图斯 (燃烧平原 "..YELLOW.."94,31"..WHITE..")"
Inst5Quest10_HORDE_Note = "任务始于 卡拉然·温布雷 (灼热峡谷; 39,38).\n贝尔加在 [11] 区。"
Inst5Quest10_HORDE_Prequest = "有, 无瑕之焰 -> 烈焰精华"
Inst5Quest10_HORDE_Folgequest = "无"
Inst5Quest10PreQuest_HORDE = "true"
--
Inst5Quest10name1_HORDE = "页岩斗篷"
Inst5Quest10name2_HORDE = "龙皮肩铠"
Inst5Quest10name3_HORDE = "火山腰带"

--QUEST 11 Horde

Inst5Quest11_HORDE = "11. 不和谐的火焰"
Inst5Quest11_HORDE_Attain = "?"
Inst5Quest11_HORDE_Level = "56"
Inst5Quest11_HORDE_Aim = "进入黑石深渊并找到伊森迪奥斯。杀掉它，然后把你找到的信息汇报给桑德哈特。"
Inst5Quest11_HORDE_Location = "桑德哈特 (荒芜之地 - 卡加斯; "..YELLOW.."3,48"..WHITE..")"
Inst5Quest11_HORDE_Note = "前导任务也从桑德哈特这里领取。派隆就在副本入口处前。\n你可以在[10]区找到伊森迪奥斯。"
Inst5Quest11_HORDE_Prequest = "有, 不和谐的烈焰"
Inst5Quest11_HORDE_Folgequest = "无"
Inst5Quest11PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "阳焰斗篷"
Inst5Quest11name2_HORDE = "夜暮手套"
Inst5Quest11name3_HORDE = "地穴恶魔护腕"
Inst5Quest11name4_HORDE = "坚定手套"

--QUEST 12 Horde

Inst5Quest12_HORDE = "12. 最后的元素"
Inst5Quest12_HORDE_Attain = "?"
Inst5Quest12_HORDE_Level = "54"
Inst5Quest12_HORDE_Aim = "到黑石深渊去取得10份元素精华。你应该在那些作战傀儡和傀儡制造者身上找找，另外，薇薇安·拉格雷也提到了一些有关元素生物的话题……"
Inst5Quest12_HORDE_Location = "暗法师薇薇安·拉格雷 <卡加斯远征军> (荒芜之地 - 卡加斯; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest12_HORDE_Note = "前导任务来自 桑德哈特 (荒芜之地 - 卡加斯; "..YELLOW.."3,48"..WHITE..")。派隆就在副本入口处前。\n 每个元素生物都可能会掉落精华。"
Inst5Quest12_HORDE_Prequest = "有, 不和谐的烈焰"
Inst5Quest12_HORDE_Folgequest = "无"
Inst5Quest12PreQuest_HORDE = "true"
--
Inst5Quest12name1_HORDE = "拉格雷的徽记之戒"

--QUEST 8 Horde

Inst5Quest13_HORDE = "13. 指挥官哥沙克"
Inst5Quest13_HORDE_Attain = "?"
Inst5Quest13_HORDE_Level = "52"
Inst5Quest13_HORDE_Aim = "在黑石深渊里找到指挥官哥沙克。\n在那幅草图上画着的是一个铁栏后面的兽人，也许你应该到某个类似监狱的地方去找找看。"
Inst5Quest13_HORDE_Location = "神射手贾拉玛弗 (荒芜之地 - 卡加斯; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest13_HORDE_Note = "前导任务来自 桑德哈特 (荒芜之地 - 卡加斯; "..YELLOW.."3,48"..WHITE..")。派隆就在副本入口处前。\n你能在[3]区找到指挥官哥沙克。位于[5]区的审讯官格斯塔恩掉落打开监狱的钥匙。如果你跟他交谈并开始下一个任务，敌人便会出现。"
Inst5Quest13_HORDE_Prequest = "有，不和谐的烈焰"
Inst5Quest13_HORDE_Folgequest = "有，出了什么事？(事件)"
Inst5Quest13PreQuest_HORDE = "true"


--QUEST14 Horde

Inst5Quest14_HORDE = "14. 拯救公主"
Inst5Quest14_HORDE_Attain = "51"
Inst5Quest14_HORDE_Level = "59"
Inst5Quest14_HORDE_Aim = "杀掉达格兰·索瑞森大帝，然后将铁炉堡公主茉艾拉·铜须从他的邪恶诅咒中拯救出来。"
Inst5Quest14_HORDE_Location = "萨尔 <酋长> (奥格瑞玛; "..YELLOW.."31,37"..WHITE..")"
Inst5Quest14_HORDE_Note = "与卡兰·巨锤和萨尔交谈后，你将得到这个任务。\n达格兰·索瑞森大帝在 [21] 区。虽然公主会治疗达格兰，但是如果想完成任务，就一定不要杀死公主。切记，切记！！！尝试打断公主的治疗施法。 (Rewards are for The Princess Saved?)"
Inst5Quest14_HORDE_Prequest = "有，指挥官哥沙克"
Inst5Quest14_HORDE_Folgequest = "有，拯救公主？"
Inst5Quest14FQuest_HORDE = "true"
--
Inst5Quest14name1_HORDE = "萨尔的决心"
Inst5Quest14name2_HORDE = "奥格瑞玛之眼"



--------------Inst8 / lower blackrock spier ------------
Inst8Story = "黑石深渊深处的巨大堡垒是由矮人建筑大师弗兰克罗恩·铸铁所设计的。这个堡垒是矮人力量的象征并被邪恶的黑铁矮人占据了数个世纪。然而，奈法利安——死亡之翼狡猾的儿子——对这个巨大的堡垒别有意图。他和他的黑龙军团占据了上层黑石塔并向占据着黑石深渊的黑铁矮人宣战。奈法利安知道矮人是由强大的火元素拉格纳罗斯所领导的，所以他立志要摧毁他的敌人并将黑石深渊全被占为己有。"
Inst8Caption = "黑石塔"

--------------Inst9 / lower blackrock spier ------------
Inst9Story = "黑石深渊深处的巨大堡垒是由矮人建筑大师弗兰克罗恩·铸铁所设计的。这个堡垒是矮人力量的象征并被邪恶的黑铁矮人占据了数个世纪。然而，奈法利安——死亡之翼狡猾的儿子——对这个巨大的堡垒别有意图。他和他的黑龙军团占据了上层黑石塔并向占据着黑石深渊的黑铁矮人宣战。奈法利安知道矮人是由强大的火元素拉格纳罗斯所领导的，所以他立志要摧毁他的敌人并将黑石深渊全被占为己有。"
Inst9Caption = "黑石塔"

--------------Dire Maul East/ Inst10------------
Inst10Story = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。"
Inst10Caption = "厄运之锤（东）"

--------------Dire Maul North/ Inst11------------
Inst11Story = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。"
Inst11Caption = "厄运之锤（北）"

--------------Dire Maul West/ Inst12------------
Inst12Story = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。"
Inst12Caption = "厄运之锤（西）"

--------------Inst13/Maraudon------------
Inst13Story = "玛拉顿被狂暴的玛拉顿半人马所保护，那是凄凉之地最神圣的地方。玛拉顿是扎尔塔的伟大神庙，扎尔塔使半神塞纳留斯不朽的儿子之一。传说说扎尔塔和瑟莱德丝大地元素公主的私生子成为了半人马种族。据说半人马这个野蛮的种族在其出生了之后就开始转向他们的父亲并将其杀死。有些人则相信瑟莱德丝在悲伤中将扎尔塔的灵魂困了起来，并将其藏在洞中——利用它的能量来达到一些不可告人的目的。在玛拉顿错综复杂的地下通道中到处都是邪恶的半人马可汗灵魂和瑟莱德丝的元素爪牙。"
Inst13Caption = "玛拉顿"
Inst13QAA = "8 Quests"
Inst13QAH = "8 Quests"

--Quest1 Allianz

Inst13Quest1 = "1. 暗影残片"
Inst13Quest1_Attain = "?"
Inst13Quest1_Level = "42"
Inst13Quest1_Aim = "从玛拉顿收集10块暗影残片，然后把它们交给尘泥沼泽塞拉摩岛上的大法师特沃什。"
Inst13Quest1_Location = "大法师特沃什 (尘泥沼泽; "..YELLOW.."66,49"..WHITE..")"
Inst13Quest1_Note = "暗影残片可以从 '暗影碎片巡游者' 或者 '暗影碎片击碎者' 身上找到。"
Inst13Quest1_Prequest = "无"
Inst13Quest1_Folgequest = "无"
--
Inst13Quest1name1 = "热情暗影残片坠饰"
Inst13Quest1name2 = "巨型暗影碎片坠饰"

--Quest2 Allianz

Inst13Quest2 = "2. 维利塔恩的污染"
Inst13Quest2_Attain = "41"
Inst13Quest2_Level = "47"
Inst13Quest2_Aim = "在玛拉顿里用天蓝水瓶在橙色水晶池中装满水。\n在维利斯塔姆藤蔓上使用装满水的天蓝水瓶，使堕落的诺克赛恩幼体出现。\n治疗8株植物并杀死那些诺克赛恩幼体，然后向尼耶尔前哨站的塔琳德莉亚复命。"
Inst13Quest2_Location = "塔琳德莉亚 (凄凉之地 - 尼耶尔前哨站; "..YELLOW.."68,8"..WHITE..")"
Inst13Quest2_Note = "你可以在玛拉顿里任何一个橙色的水池装水。藤蔓生长在橙色或紫色区域。"
Inst13Quest2_Prequest = "无"
Inst13Quest2_Folgequest = "无"
--
Inst13Quest2name1 = "树种之环"
Inst13Quest2name2 = "山艾束腰"
Inst13Quest2name3 = "枝爪护手"

--Quest3 Allianz

Inst13Quest3 = "3. 扭曲的邪恶"
Inst13Quest3_Attain = "41"
Inst13Quest3_Level = "47"
Inst13Quest3_Aim = "为凄凉之地的维洛收集25个瑟莱德丝水晶雕像。"
Inst13Quest3_Location = "维洛 (凄凉之地; "..YELLOW.."62,39"..WHITE..")"
Inst13Quest3_Note = "大多数玛拉顿里的敌人都掉落雕像。（高掉率）"
Inst13Quest3_Prequest = "无"
Inst13Quest3_Folgequest = "无"
--
Inst13Quest3name1 = "聪颖长袍"
Inst13Quest3name2 = "轻环头盔"
Inst13Quest3name3 = "无情链甲"
Inst13Quest3name4 = "巨石肩铠"

--Quest4 Horde

Inst13Quest4 = "4. 贱民的指引"
Inst13Quest4_Attain = "?"
Inst13Quest4_Level = "48"
Inst13Quest4_Aim = "阅读贱民的指引，然后从玛拉顿得到联合坠饰，将其交给凄凉之地南部的半人马贱民。"
Inst13Quest4_Location = "半人马贱民 (凄凉之地; "..YELLOW.."45,86"..WHITE..")"
Inst13Quest4_Note = "5个可汗(《贱民的指引》的描述)"
Inst13Quest4_Prequest = "无"
Inst13Quest4_Folgequest = "无"
--
Inst13Quest4name1 = "天选者印记"
Inst13Quest4_Page = {2, "你会在凄凉之地的南部找到半人马贱民。他在 44,85 和 50,87 之间来回走动。\n首先，你必须杀死 '无名预言者'。你可以在进入副本之前找到它，就在你选择进紫色入口还是橙色入口那里。杀了它后，你还要杀死5个可汗。如果你选择中间的路（既不是紫色入口也不是橙色入口），你会找到第一可汗。第二可汗在玛拉顿进入副本之前的紫色部分里。第三可汗在进入副本之前的橙色部分里(在去副本更远的路上)。 第四可汗在 "..YELLOW.."[4]"..WHITE.." 附近。第五可汗在 "..YELLOW.."[1]"..WHITE.."附近。", };

--Quest5 Allianz

Inst13Quest5 = "5. 玛拉顿的传说"
Inst13Quest5_Attain = "?"
Inst13Quest5_Level = "48"
Inst13Quest5_Aim = "找回塞雷布拉斯节杖的两个部分：塞雷布拉斯魔棒和塞雷布拉斯钻石。\n然后设法和塞雷布拉斯对话。"
Inst13Quest5_Location = "凯雯德拉 (凄凉之地 - 玛拉顿 "..YELLOW..""..WHITE..")"
Inst13Quest5_Note = "凯雯德拉就在进入副本之前的橙色部分的开始处。\n你可以从诺克塞恩那里得到塞雷布拉斯魔棒 "..YELLOW.."[2]"..WHITE.."，从维利塔恩那里得到塞雷布拉斯钻石  "..YELLOW.."[5]"..WHITE.."。 塞雷布拉斯在 "..YELLOW.."[7]"..WHITE.."。你需要打败他才能和他说话。"
Inst13Quest5_Prequest = "无"
Inst13Quest5_Folgequest = "有，塞雷布拉斯节杖"

--Quest6 Allianz

Inst13Quest6 = "6. 塞雷布拉斯节杖"
Inst13Quest6_Attain = "?"
Inst13Quest6_Level = "49"
Inst13Quest6_Aim = "帮助赎罪的塞雷布拉斯制作塞雷布拉斯节杖。\n当仪式完成之后再和他谈谈。"
Inst13Quest6_Location = "赎罪的塞雷布拉斯 (玛拉顿 "..YELLOW..""..WHITE..")"
Inst13Quest6_Note = "塞雷布拉斯制造节杖。当仪式完成之后，和他对话。"
Inst13Quest6_Prequest = "有，玛拉顿的传说"
Inst13Quest6_Folgequest = "无"
Inst13Quest6FQuest = "true"
--
Inst13Quest6name1 = "塞雷布拉斯节杖"

--Quest7 Horde

Inst13Quest7 = "7. 大地的污染"
Inst13Quest7_Attain = "?"
Inst13Quest7_Level = "51"
Inst13Quest7_Aim = "杀死瑟莱德丝公主，然后回到凄凉之地尼耶尔前哨站的守护者玛兰迪斯那里复命。"
Inst13Quest7_Location = "守护者玛兰迪斯 (凄凉之地 - 尼耶尔前哨站; "..YELLOW.."26,77"..WHITE..")"
Inst13Quest7_Note = "瑟莱德丝公主 在 "..YELLOW.."[11]"..WHITE.."。"
Inst13Quest7_Prequest = "无"
Inst13Quest7_Folgequest = "有，生命之种"
--
Inst13Quest7name1 = "痛击之刃"
Inst13Quest7name2 = "苏醒之杖"
Inst13Quest7name3 = "绿色守护者之弓"

--Quest8 Horde

Inst13Quest8 = "8. 生命之种"
Inst13Quest8_Attain = "?"
Inst13Quest8_Level = "51"
Inst13Quest8_Aim = "到月光林地去找到雷姆洛斯，将生命之种交给他。"
Inst13Quest8_Location = "扎尔塔 (玛拉顿 "..YELLOW..""..WHITE..")"
Inst13Quest8_Note = "杀死公主后，扎尔塔的灵魂就会出现("..YELLOW.."[11]"..WHITE..")。\n守护者雷姆洛斯 在 月光林地 "..YELLOW.."(36,41)"..WHITE.."."
Inst13Quest8_Prequest = "有，大地的污染"
Inst13Quest8_Folgequest = "无"



--Quest1 Horde

Inst13Quest1_HORDE = "1. 暗影残片"
Inst13Quest1_HORDE_Attain = "?"
Inst13Quest1_HORDE_Level = "42"
Inst13Quest1_HORDE_Aim = "从玛拉顿收集10块暗影残片，然后把它们交给奥格瑞玛的尤塞尔奈。"
Inst13Quest1_HORDE_Location = "尤塞尔奈 (奥格瑞玛; "..YELLOW.."38,68"..WHITE..")"
Inst13Quest1_HORDE_Note = "暗影残片可以从 '暗影碎片巡游者' 或者 '暗影碎片击碎者' 身上找到。"
Inst13Quest1_HORDE_Prequest = "无"
Inst13Quest1_HORDE_Folgequest = "无"
--
Inst13Quest1name1_HORDE = "热情暗影残片坠饰"
Inst13Quest1name2_HORDE = "巨型暗影碎片坠饰"

--Quest2 Horde

Inst13Quest2_HORDE = "2. 维利塔恩的污染"
Inst13Quest2_HORDE_Attain = "41"
Inst13Quest2_HORDE_Level = "47"
Inst13Quest2_HORDE_Aim = "在玛拉顿里用天蓝水瓶在橙色水晶池中装满水。\n在维利斯塔姆藤蔓上使用装满水的天蓝水瓶，使堕落的诺克赛恩幼体出现。\n治疗8株植物并杀死那些诺克赛恩幼体，然后向葬影村的瓦克·战痕复命。"
Inst13Quest2_HORDE_Location = "瓦克·战痕 (凄凉之地 - 葬影村; "..YELLOW.."23,70"..WHITE..")"
Inst13Quest2_HORDE_Note = "你可以在玛拉顿里任何一个橙色的水池装水。藤蔓生长在橙色或紫色区域。"
Inst13Quest2_HORDE_Prequest = "无"
Inst13Quest2_HORDE_Folgequest = "无"
--
Inst13Quest2name1_HORDE = "树种之环"
Inst13Quest2name2_HORDE = "山艾束腰 "
Inst13Quest2name3_HORDE = "枝爪护手"

--Quest3 Horde

Inst13Quest3_HORDE = "3. 扭曲的邪恶"
Inst13Quest3_HORDE_Attain = "41"
Inst13Quest3_HORDE_Level = "47"
Inst13Quest3_HORDE_Aim = "为凄凉之地的维洛收集25个瑟莱德丝水晶雕像。"
Inst13Quest3_HORDE_Location = "维洛 (凄凉之地; "..YELLOW.."62,39"..WHITE..")"
Inst13Quest3_HORDE_Note = "大多数玛拉顿里的敌人都掉落雕像。（高掉率）"
Inst13Quest3_HORDE_Prequest = "无"
Inst13Quest3_HORDE_Folgequest = "无"
--
Inst13Quest3name1_HORDE = "聪颖长袍"
Inst13Quest3name2_HORDE = "轻环头盔"
Inst13Quest3name3_HORDE = "无情链甲"
Inst13Quest3name4_HORDE = "巨石肩铠"

--Quest4 Horde

Inst13Quest4_HORDE = "4. 贱民的指引"
Inst13Quest4_HORDE_Attain = "?"
Inst13Quest4_HORDE_Level = "48"
Inst13Quest4_HORDE_Aim = "阅读贱民的指引，然后从玛拉顿得到联合坠饰，将其交给凄凉之地南部的半人马贱民。"
Inst13Quest4_HORDE_Location = "半人马贱民 (凄凉之地; "..YELLOW.."45,86"..WHITE..")"
Inst13Quest4_HORDE_Note = "5个可汗(《贱民的指引》的描述)"
Inst13Quest4_HORDE_Prequest = "无"
Inst13Quest4_HORDE_Folgequest = "无"
--
Inst13Quest4name1_HORDE = "天选者印记"
Inst13Quest4_HORDE_Page = {2, "你会在凄凉之地的南部找到半人马贱民。他在 44,85 和 50,87 之间来回走动。\n首先，你必须杀死 '无名预言者'。你可以在进入副本之前找到它，就在你选择进紫色入口还是橙色入口那里。杀了它后，你还要杀死5个可汗。其中1、2、3可汗在副本外面，4、5可汗在副本里面。每个可汗掉一个宝石，得到5个宝石之后随便右键点一个宝石就可以合成任务用具了。可汗是要被激活才可以攻击，在副本里可以打到这个物品。如果你选择中间的路（既不是紫色入口也不是橙色入口），你会找到第一可汗。第二可汗在玛拉顿进入副本之前的紫色部分里。第三可汗在进入副本之前的橙色部分里(在去副本更远的路上)。 第四可汗在 "..YELLOW.."[4]"..WHITE.." 附近。第五可汗在 "..YELLOW.."[1]"..WHITE.."附近。", };

--Quest5 Horde

Inst13Quest5_HORDE = "5. 玛拉顿的传说"
Inst13Quest5_HORDE_Attain = "?"
Inst13Quest5_HORDE_Level = "48"
Inst13Quest5_HORDE_Aim = "找回塞雷布拉斯节杖的两个部分：塞雷布拉斯魔棒和塞雷布拉斯钻石。\n然后设法和塞雷布拉斯对话。"
Inst13Quest5_HORDE_Location = "凯雯德拉 (凄凉之地 - 玛拉顿 "..YELLOW..""..WHITE..")"
Inst13Quest5_HORDE_Note = "凯雯德拉就在进入副本之前的橙色部分的开始处。\n你可以从诺克塞恩那里得到塞雷布拉斯魔棒 "..YELLOW.."[2]"..WHITE.."，从维利塔恩那里得到塞雷布拉斯钻石  "..YELLOW.."[5]"..WHITE.."。 塞雷布拉斯在 "..YELLOW.."[7]"..WHITE.."。你需要打败他才能和他说话。"
Inst13Quest5_HORDE_Prequest = "无"
Inst13Quest5_HORDE_Folgequest = "有，塞雷布拉斯节杖"

--Quest6 Horde

Inst13Quest6_HORDE = "6. 塞雷布拉斯节杖"
Inst13Quest6_HORDE_Attain = "?"
Inst13Quest6_HORDE_Level = "49"
Inst13Quest6_HORDE_Aim = "帮助赎罪的塞雷布拉斯制作塞雷布拉斯节杖。\n当仪式完成之后再和他谈谈。"
Inst13Quest6_HORDE_Location = "赎罪的塞雷布拉斯 (玛拉顿 "..YELLOW..""..WHITE..")"
Inst13Quest6_HORDE_Note = "塞雷布拉斯制造节杖。当仪式完成之后，和他对话。"
Inst13Quest6_HORDE_Prequest = "有，玛拉顿的传说"
Inst13Quest6_HORDE_Folgequest = "无"
Inst13Quest6FQuest_HORDE = "true"
--
Inst13Quest6name1_HORDE = "塞雷布拉斯节杖"

--Quest7 Horde

Inst13Quest7_HORDE = "7. 大地的污染"
Inst13Quest7_HORDE_Attain = "?"
Inst13Quest7_HORDE_Level = "51"
Inst13Quest7_HORDE_Aim = "杀死瑟莱德丝公主，然后回到凄凉之地葬影村附近的瑟琳德拉那里复命。"
Inst13Quest7_HORDE_Location = "瑟琳德拉 (凄凉之地 - 葬影村; "..YELLOW.."26,77"..WHITE..")"
Inst13Quest7_HORDE_Note = "瑟莱德丝公主 在 "..YELLOW.."[11]"..WHITE.."。"
Inst13Quest7_HORDE_Prequest = "无"
Inst13Quest7_HORDE_Folgequest = "生命之种"
--
Inst13Quest7name1_HORDE = "痛击之刃"
Inst13Quest7name2_HORDE = "苏醒之杖"
Inst13Quest7name3_HORDE = "绿色守护者之弓"

--Quest8 Horde

Inst13Quest8_HORDE = "8. 生命之种"
Inst13Quest8_HORDE_Attain = "?"
Inst13Quest8_HORDE_Level = "51"
Inst13Quest8_HORDE_Aim = "到月光林地去找到雷姆洛斯，将生命之种交给他。"
Inst13Quest8_HORDE_Location = "扎尔塔 (玛拉顿 "..YELLOW..""..WHITE..")"
Inst13Quest8_HORDE_Note = "杀死公主后，扎尔塔的灵魂就会出现("..YELLOW.."[11]"..WHITE..")。\n守护者雷姆洛斯 在 月光林地 "..YELLOW.."(36,41)"..WHITE.."。"
Inst13Quest8_HORDE_Prequest = "有，大地的污染"
Inst13Quest8_HORDE_Folgequest = "无"


--------------Inst22/Stratholme------------
Inst22Story = "斯坦索姆曾经是洛丹伦北部一颗璀璨的明珠，但是就是在这座城市阿尔萨斯王子背叛了他的导师乌瑟，并屠杀了数百个被认为感染了可怕瘟疫的臣民。阿尔萨斯不久之后就向巫妖王臣服。这个破碎的城市也被巫妖克尔苏拉德领导的亡灵天灾所占据。而一直由大十字军战士达索汉领导的血色十字军分遣队也占据了这个城市的一部分。这两方力量在城市中进行着激烈的战斗。而那些勇敢（亦或是愚蠢的）的冒险者在进入斯坦索姆之后将不得不面对两方的力量。据说整座城市由三座大型的通灵塔以及无数强大的亡灵巫师，女妖和憎恶所守卫着。据报告，邪恶的死亡骑士乘坐在一匹骷髅战马——他会将怒火倾泻在任何胆敢进入亡灵天灾领域的人。"
Inst22Caption = "斯坦索姆"
Inst22QAA = "11 任务"
Inst22QAH = "12 任务"

--Quest1 Alliance

Inst22Quest1 = "1. 血肉不会撒谎"
Inst22Quest1_Attain = "?"
Inst22Quest1_Level = "60"
Inst22Quest1_Aim = "从斯坦索姆找回20个瘟疫肉块，并把它们交给贝蒂娜·比格辛克。你觉得斯坦索姆中的生灵都不大可能长着肉……"
Inst22Quest1_Location = "贝蒂娜·比格辛克 (东瘟疫之地; "..YELLOW.."81,59"..WHITE..")"
Inst22Quest1_Note = "斯坦索姆里多数敌人都会掉落瘟疫肉块。"
Inst22Quest1_Prequest = "无"
Inst22Quest1_Folgequest = "有，活跃的探子"

--Quest2 Alliance

Inst22Quest2 = "2. 活跃的探子"
Inst22Quest2_Attain = "58"
Inst22Quest2_Level = "60"
Inst22Quest2_Aim = "到斯坦索姆去探索那里的通灵塔。找到新的天灾军团档案，把它交给贝蒂娜·比格辛克。"
Inst22Quest2_Location = "贝蒂娜·比格辛克 (东瘟疫之地; "..YELLOW.."81,59"..WHITE..")"
Inst22Quest2_Note = "天灾军团档案在三个塔中的一个里，这三个塔在"..YELLOW.."[10]"..WHITE.."，"..YELLOW.."[11]"..WHITE.."和"..YELLOW.."[12]"..WHITE.."附近。"
Inst22Quest2_Prequest = "有，血肉不会撒谎"
Inst22Quest2_Folgequest = "无"
--
Inst22Quest2name1 = "黎明之印"
Inst22Quest2name2 = "黎明符文"
Inst22Quest2FQuest = "true"

--Quest3 Alliance

Inst22Quest3 = "3. 神圣之屋"
Inst22Quest3_Attain = "?"
Inst22Quest3_Level = "60"
Inst22Quest3_Aim = "到北方的斯坦索姆去，寻找散落在城市中的补给箱，并收集5瓶斯坦索姆圣水。当你找到足够的圣水之后就回去向莱尼德·巴萨罗梅复命。"
Inst22Quest3_Location = "莱尼德·巴萨罗梅 (东瘟疫之地; "..YELLOW.."80,58"..WHITE..")"
Inst22Quest3_Note = "在斯坦索姆各处的箱子里你可以找到圣水。但是，如果你打开箱子，虫子可能会出现并攻击你。"
Inst22Quest3_Prequest = "无"
Inst22Quest3_Folgequest = "无"
--
Inst22Quest3name1 = "超强治疗药水"
Inst22Quest3name2 = "强效法力药水"
Inst22Quest3name3 = "忏悔之冠"
Inst22Quest3name4 = "忏悔者指环"

--Quest4 Alliance

Inst22Quest4 = "4. 弗拉斯·希亚比"
Inst22Quest4_Attain = "?"
Inst22Quest4_Level = "60"
Inst22Quest4_Aim = "找到弗拉斯·希亚比在斯坦索姆的烟草店，并从中找回一盒希亚比的烟草，把它交给烟鬼拉鲁恩。"
Inst22Quest4_Location = "烟鬼拉鲁恩 (东瘟疫之地; "..YELLOW.."80,58"..WHITE..")"
Inst22Quest4_Note = "烟草店在"..YELLOW.."[1]"..WHITE.."附近。当你打开盒子，弗拉斯·希亚比会突然出现。"
Inst22Quest4_Prequest = "无"
Inst22Quest4_Folgequest = "无"
--
Inst22Quest4name1 = "烟鬼的打火器"

--Quest5 Alliance

Inst22Quest5 = "5. 永不安息的灵魂"
Inst22Quest5_Attain = "55"
Inst22Quest5_Level = "60"
Inst22Quest5_Aim = "对斯坦索姆里已成为鬼魂的居民们使用埃根的冲击器。当永不安息的灵魂从他们的鬼魂外壳解放出来后，再次使用冲击器 - 他们就会彻底自由了！\n释放15个永不安息的灵魂，然后回到埃根那里。"
Inst22Quest5_Location = "埃根 (东瘟疫之地(NW); "..YELLOW.."14,33"..WHITE..")"
Inst22Quest5_Note = "前导任务从护理者奥林处获得(东瘟疫之地; "..YELLOW.."79,63"..WHITE..")\n鬼魂居民在斯坦索姆到处走动。"
Inst22Quest5_Prequest = "有，永不安息的灵魂"
Inst22Quest5_Folgequest = "无"
--
Inst22Quest5name1 = "希望的证明"
Inst22Quest5PreQuest = "true"

--Quest6 Alliance

Inst22Quest6 = "6. 爱与家庭 (系列任务)"
Inst22Quest6_Attain = "53"
Inst22Quest6_Level = "60"
Inst22Quest6_Aim = "到瘟疫之地北部的斯坦索姆去。你可以在血色十字军堡垒中找到“爱与家庭”这幅画，它被隐藏在另一幅描绘两个月亮的画之后。\n把这幅画还给提里奥·弗丁。"
Inst22Quest6_Location = "画家瑞弗蕾 (西瘟疫之地; "..YELLOW.."65,75"..WHITE..")"
Inst22Quest6_Note = "前导任务从提里奥·弗丁处获得(西瘟疫之地; "..YELLOW.."7,43"..WHITE..")。\n画在"..YELLOW.."[7]"..WHITE.."。"
Inst22Quest6_Prequest = "有，救赎 - > 遗忘的记忆 - > 失落的荣耀 - > 爱与家庭"
Inst22Quest6_Folgequest = "有，寻找麦兰达"
Inst22Quest6PreQuest = "true"

--Quest7 Alliance

Inst22Quest7 = "7. 米奈希尔的礼物 (系列任务)"
Inst22Quest7_Attain = "53"
Inst22Quest7_Level = "60"
Inst22Quest7_Aim = "到斯坦索姆城里去找到米奈希尔的礼物，把巫妖生前的遗物放在那块邪恶的土地上。"
Inst22Quest7_Location = "莱尼德·巴萨罗梅 (东瘟疫之地; "..YELLOW.."80,58"..WHITE..")"
Inst22Quest7_Note = "前导任务从马杜克镇长处获得。(西瘟疫之地; "..YELLOW.."70,73"..WHITE..")。\n你可以在"..YELLOW.."[15]"..WHITE.."附近找到标志。也可以参见：通灵学院里的"..YELLOW.."[巫妖莱斯·霜语]"..WHITE.."。"
Inst22Quest7_Prequest = "有，莱斯·霜语 - > 亡灵莱斯·霜语"
Inst22Quest7_Folgequest = "有，米奈希尔的礼物"
Inst22Quest7PreQuest = "true"

--Quest8 Alliance

Inst22Quest8 = "8. 奥里克斯的清算"
Inst22Quest8_Attain = "?"
Inst22Quest8_Level = "60"
Inst22Quest8_Aim = "???"
Inst22Quest8_Location = "奥里克斯 (斯坦索姆; "..YELLOW.."[8]"..WHITE..")"
Inst22Quest8_Note = "要开始这个任务你需要给奥里克斯 [信仰奖章]。 你可以从一个箱子里(玛洛尔的保险箱)拿到这个奖章，箱子就在"..YELLOW.."[6]"..WHITE.."附近。将奖章给了奥里克斯之后，他会在对抗男爵("..YELLOW.."[15]"..WHITE..")的战斗中支持你的小组。杀死男爵后，你需要再次和奥里克斯谈话以取得任务回报奖励。"
Inst22Quest8_Prequest = "无"
Inst22Quest8_Folgequest = "无"
--
Inst22Quest8name1 = "殉难者的意志"
Inst22Quest8name2 = "殉难者之血"

--Quest9 Alliance

Inst22Quest9 = "9. 档案管理员"
Inst22Quest9_Attain = "55"
Inst22Quest9_Level = "60"
Inst22Quest9_Aim = "在斯坦索姆城中找到血色十字军的档案管理员加尔福特，杀掉他，然后烧毁血色十字军档案。"
Inst22Quest9_Location = "尼古拉斯·瑟伦霍夫公爵 (东瘟疫之地; "..YELLOW.."81, 59"..WHITE..")"
Inst22Quest9_Note = "档案和档案管理员在"..YELLOW.."[6]"..WHITE.."。"
Inst22Quest9_Prequest = "无"
Inst22Quest9_Folgequest = "有，可怕的真相"

--Quest10 Alliance

Inst22Quest10 = "10. 可怕的真相"
Inst22Quest10_Attain = "58"
Inst22Quest10_Level = "60"
Inst22Quest10_Aim = "将巴纳扎尔的头颅交给东瘟疫之地的尼古拉斯·瑟伦霍夫公爵。"
Inst22Quest10_Location = "巴纳扎尔 (斯坦索姆; "..YELLOW.."[7]"..WHITE..")"
Inst22Quest10_Note = "尼古拉斯·瑟伦霍夫公爵在东瘟疫之地("..YELLOW.."81, 59"..WHITE..")。"
Inst22Quest10_Prequest = "有，档案管理员"
Inst22Quest10_Folgequest = "有，超越"
Inst22Quest10FQuest = "true"

--Quest11 Alliance

Inst22Quest11 = "11. 超越"
Inst22Quest11_Attain = "58"
Inst22Quest11_Level = "60"
Inst22Quest11_Aim = "到斯坦索姆去杀掉瑞文戴尔男爵，把他的头颅交给尼古拉斯·瑟伦霍夫公爵。"
Inst22Quest11_Location = "尼古拉斯·瑟伦霍夫公爵 (东瘟疫之地; "..YELLOW.."81, 59"..WHITE..")"
Inst22Quest11_Note = "男爵在"..YELLOW.."[15]"..WHITE.."。"
Inst22Quest11_Prequest = "有，可怕的真相"
Inst22Quest11_Folgequest = "无"
--
Inst22Quest11name1 = "黎明守护者"
Inst22Quest11name2 = "银色十字军"
Inst22Quest11name3 = "银色复仇者"
Inst22Quest11FQuest = "true"

--Quest1 Horde

Inst22Quest1_HORDE = "1. 血肉不会撒谎"
Inst22Quest1_HORDE_Attain = "?"
Inst22Quest1_HORDE_Level = "60"
Inst22Quest1_HORDE_Aim = "从斯坦索姆找回20个瘟疫肉块，并把它们交给贝蒂娜·比格辛克。你觉得斯坦索姆中的生灵都不大可能长着肉……"
Inst22Quest1_HORDE_Location = "贝蒂娜·比格辛克 (东瘟疫之地; "..YELLOW.."81,59"..WHITE..")"
Inst22Quest1_HORDE_Note = "斯坦索姆里多数敌人都会掉落瘟疫肉块。"
Inst22Quest1_HORDE_Prequest = "无"
Inst22Quest1_HORDE_Folgequest = "有，活跃的探子"

--Quest2 Horde

Inst22Quest2_HORDE = "2. 活跃的探子"
Inst22Quest2_HORDE_Attain = "58"
Inst22Quest2_HORDE_Level = "60"
Inst22Quest2_HORDE_Aim = "到斯坦索姆去探索那里的通灵塔。找到新的天灾军团档案，把它交给贝蒂娜·比格辛克。"
Inst22Quest2_HORDE_Location = "贝蒂娜·比格辛克 (东瘟疫之地; "..YELLOW.."81,59"..WHITE..")"
Inst22Quest2_HORDE_Note = "天灾军团档案在三个塔中的一个里，这三个塔在"..YELLOW.."[10]"..WHITE.."，"..YELLOW.."[11]"..WHITE.."和"..YELLOW.."[12]"..WHITE.."附近。"
Inst22Quest2_HORDE_Prequest = "有，血肉不会撒谎"
Inst22Quest2_HORDE_Folgequest = "无"
--
Inst22Quest2name1_HORDE = "黎明之印"
Inst22Quest2name2_HORDE = "黎明符文"
Inst22Quest2FQuest_HORDE = "true"

--Quest3 Horde

Inst22Quest3_HORDE = "3. 神圣之屋"
Inst22Quest3_HORDE_Attain = "?"
Inst22Quest3_HORDE_Level = "60"
Inst22Quest3_HORDE_Aim = "到北方的斯坦索姆去，寻找散落在城市中的补给箱，并收集5瓶斯坦索姆圣水。当你找到足够的圣水之后就回去向莱尼德·巴萨罗梅复命。"
Inst22Quest3_HORDE_Location = "莱尼德·巴萨罗梅 (东瘟疫之地; "..YELLOW.."80,58"..WHITE..")"
Inst22Quest3_HORDE_Note = "在斯坦索姆各处的箱子里你可以找到圣水。但是，如果你打开箱子，虫子可能会出现并攻击你。"
Inst22Quest3_HORDE_Prequest = "无"
Inst22Quest3_HORDE_Folgequest = "无"
--
Inst22Quest3name1_HORDE = "超强治疗药水"
Inst22Quest3name2_HORDE = "强效法力药水"
Inst22Quest3name3_HORDE = "忏悔之冠"
Inst22Quest3name4_HORDE = "忏悔者指环"

--Quest4 Horde

Inst22Quest4_HORDE = "4. 弗拉斯·希亚比"
Inst22Quest4_HORDE_Attain = "?"
Inst22Quest4_HORDE_Level = "60"
Inst22Quest4_HORDE_Aim = "找到弗拉斯·希亚比在斯坦索姆的烟草店，并从中找回一盒希亚比的烟草，把它交给烟鬼拉鲁恩。"
Inst22Quest4_HORDE_Location = "烟鬼拉鲁恩 (东瘟疫之地; "..YELLOW.."80,58"..WHITE..")"
Inst22Quest4_HORDE_Note = "烟草店在"..YELLOW.."[1]"..WHITE.."附近。当你打开盒子，弗拉斯·希亚比会突然出现。"
Inst22Quest4_HORDE_Prequest = "无"
Inst22Quest4_HORDE_Folgequest = "无"
--
Inst22Quest4name1_HORDE = "烟鬼的打火器"

--Quest5 Horde

Inst22Quest5_HORDE = "5. 永不安息的灵魂"
Inst22Quest5_HORDE_Attain = "55"
Inst22Quest5_HORDE_Level = "60"
Inst22Quest5_HORDE_Aim = "对斯坦索姆里已成为鬼魂的居民们使用埃根的冲击器。当永不安息的灵魂从他们的鬼魂外壳解放出来后，再次使用冲击器 - 他们就会彻底自由了！\n释放15个永不安息的灵魂，然后回到埃根那里。"
Inst22Quest5_HORDE_Location = "埃根 (东瘟疫之地(NW); "..YELLOW.."14,33"..WHITE..")"
Inst22Quest5_HORDE_Note = "前导任务从护理者奥林处获得(东瘟疫之地; "..YELLOW.."79,63"..WHITE..")\n鬼魂居民在斯坦索姆到处走动。"
Inst22Quest5_HORDE_Prequest = "有，永不安息的灵魂"
Inst22Quest5_HORDE_Folgequest = "无"
--
Inst22Quest5name1_HORDE = "希望的证明"
Inst22Quest5PreQuest_HORDE = "true"

--Quest6 Horde

Inst22Quest6_HORDE = "6. 爱与家庭 (系列任务)"
Inst22Quest6_HORDE_Attain = "53"
Inst22Quest6_HORDE_Level = "60"
Inst22Quest6_HORDE_Aim = "到瘟疫之地北部的斯坦索姆去。你可以在血色十字军堡垒中找到“爱与家庭”这幅画，它被隐藏在另一幅描绘两个月亮的画之后。\n把这幅画还给提里奥·弗丁。"
Inst22Quest6_HORDE_Location = "画家瑞弗蕾 (西瘟疫之地; "..YELLOW.."65,75"..WHITE..")"
Inst22Quest6_HORDE_Note = "前导任务从提里奥·弗丁处获得(西瘟疫之地; "..YELLOW.."7,43"..WHITE..").\n画在"..YELLOW.."[7]"..WHITE.."。"
Inst22Quest6_HORDE_Prequest = "有，救赎 - > 遗忘的记忆 - > 失落的荣耀 - > 爱与家庭"
Inst22Quest6_HORDE_Folgequest = "有，寻找麦兰达"
Inst22Quest6PreQuest_HORDE = "true"

--Quest7 Horde

Inst22Quest7_HORDE = "7. 米奈希尔的礼物 (系列任务)"
Inst22Quest7_HORDE_Attain = "53"
Inst22Quest7_HORDE_Level = "60"
Inst22Quest7_HORDE_Aim = "到斯坦索姆城里去找到米奈希尔的礼物，把巫妖生前的遗物放在那块邪恶的土地上。"
Inst22Quest7_HORDE_Location = "莱尼德·巴萨罗梅 (东瘟疫之地; "..YELLOW.."80,58"..WHITE..")"
Inst22Quest7_HORDE_Note = "前导任务从马杜克镇长处获得。(西瘟疫之地; "..YELLOW.."70,73"..WHITE..").\n你可以在"..YELLOW.."[15]"..WHITE.."附近找到标志。也可以参见：通灵学院里的"..YELLOW.."[巫妖莱斯·霜语]"..WHITE.."。"
Inst22Quest7_HORDE_Prequest = "有，莱斯·霜语 - > 亡灵莱斯·霜语"
Inst22Quest7_HORDE_Folgequest = "有，米奈希尔的礼物"
Inst22Quest7PreQuest_HORDE = "true"

--Quest8 Horde

Inst22Quest8_HORDE = "8. 奥里克斯的清算"
Inst22Quest8_HORDE_Attain = "?"
Inst22Quest8_HORDE_Level = "60"
Inst22Quest8_HORDE_Aim = "???"
Inst22Quest8_HORDE_Location = "奥里克斯 (斯坦索姆; "..YELLOW.."[8]"..WHITE..")"
Inst22Quest8_HORDE_Note = "要开始这个任务你需要给奥里克斯 [信仰奖章]。 你可以从一个箱子里(玛洛尔的保险箱)拿到这个奖章，箱子就在"..YELLOW.."[6]"..WHITE.."附近。将奖章给了奥里克斯之后，他会在对抗男爵("..YELLOW.."[15]"..WHITE..")的战斗中支持你的小组。杀死男爵后，你需要再次和奥里克斯谈话以取得任务回报奖励。"
Inst22Quest8_HORDE_Prequest = "无"
Inst22Quest8_HORDE_Folgequest = "无"
--
Inst22Quest8name1_HORDE = "殉难者的意志"
Inst22Quest8name2_HORDE = "殉难者之血"

--Quest9 Horde

Inst22Quest9_HORDE = "9. 档案管理员"
Inst22Quest9_HORDE_Attain = "55"
Inst22Quest9_HORDE_Level = "60"
Inst22Quest9_HORDE_Aim = "在斯坦索姆城中找到血色十字军的档案管理员加尔福特，杀掉他，然后烧毁血色十字军档案。"
Inst22Quest9_HORDE_Location = "尼古拉斯·瑟伦霍夫公爵 (东瘟疫之地; "..YELLOW.."81, 59"..WHITE..")"
Inst22Quest9_HORDE_Note = "档案和档案管理员在"..YELLOW.."[6]"..WHITE.."。"
Inst22Quest9_HORDE_Prequest = "无"
Inst22Quest9_HORDE_Folgequest = "有，可怕的真相"

--Quest10 Horde

Inst22Quest10_HORDE = "10. 可怕的真相"
Inst22Quest10_HORDE_Attain = "58"
Inst22Quest10_HORDE_Level = "60"
Inst22Quest10_HORDE_Aim = "将巴纳扎尔的头颅交给东瘟疫之地的尼古拉斯·瑟伦霍夫公爵。"
Inst22Quest10_HORDE_Location = "巴纳扎尔 (斯坦索姆; "..YELLOW.."[7]"..WHITE..")"
Inst22Quest10_HORDE_Note = "尼古拉斯·瑟伦霍夫公爵在东瘟疫之地("..YELLOW.."81, 59"..WHITE..")。"
Inst22Quest10_HORDE_Prequest = "有，档案管理员"
Inst22Quest10_HORDE_Folgequest = "有，超越"
Inst22Quest10FQuest_HORDE = "true"

--Quest11 Horde

Inst22Quest11_HORDE = "11. 超越"
Inst22Quest11_HORDE_Attain = "58"
Inst22Quest11_HORDE_Level = "60"
Inst22Quest11_HORDE_Aim = "到斯坦索姆去杀掉瑞文戴尔男爵，把他的头颅交给尼古拉斯·瑟伦霍夫公爵。"
Inst22Quest11_HORDE_Location = "尼古拉斯·瑟伦霍夫公爵 (东瘟疫之地; "..YELLOW.."81, 59"..WHITE..")"
Inst22Quest11_HORDE_Note = "男爵在"..YELLOW.."[15]"..WHITE.."。"
Inst22Quest11_HORDE_Prequest = "有，可怕的真相"
Inst22Quest11_HORDE_Folgequest = "无"
--
Inst22Quest11name1_HORDE = "黎明守护者"
Inst22Quest11name2_HORDE = "银色十字军"
Inst22Quest11name3_HORDE = "银色复仇者"
Inst22Quest11FQuest_HORDE = "true"

--Quest12 Horde

Inst22Quest12_HORDE = "12. 吞咽者拉姆斯登"
Inst22Quest12_HORDE_Attain = "?"
Inst22Quest12_HORDE_Level = "60"
Inst22Quest12_HORDE_Aim = "到斯坦索姆去，杀掉吞咽者拉姆斯登。把他的头颅交给纳萨诺斯。"
Inst22Quest12_HORDE_Location = "纳萨诺斯·凋零者 (东瘟疫之地; "..YELLOW.."26, 74"..WHITE..")"
Inst22Quest12_HORDE_Note = "前导任务也是从纳萨诺斯·凋零者处获得。\n拉姆斯登在"..YELLOW.."[14]"..WHITE.."。"
Inst22Quest12_HORDE_Prequest = "有，游侠之王的命令 - > 暗翼蝠"
Inst22Quest12_HORDE_Folgequest = "无"
--
Inst22Quest12name1_HORDE = "阿莱克希斯皇家戒指"
Inst22Quest12name2_HORDE = "元素之环"
Inst22Quest12PreQuest_HORDE = "true"

--------------Inst29/Gnomeregan------------
Inst29Story = "位于丹莫洛的科技奇迹城市诺莫瑞根世代以来都是侏儒的主城。最近，一群邪恶的变异食鄂怪侵入了包括侏儒主城在内的多处丹莫洛地区。为了做出殊死一搏来干掉入侵的食腭怪，大工匠梅卡托克命令打开城市中的紧急辐射水箱。侏儒在等待那些食腭怪死亡或者逃跑的同时也在寻找躲避辐射的方法。不幸的是，虽然食腭怪在经过辐射之后感染了毒性——但是它们的攻击没有停止，也没有丝毫的减弱。那些没有被辐射杀死的注入被迫逃离，他们在附近的矮人城市铁炉堡找到了安身之处。大工匠梅卡托克组建了一个智囊团来商议重新夺回他们挚爱的城市的计划。传说大工匠梅卡托克曾经最信任的顾问，麦克尼尔·瑟玛普拉格被判了他的人民并纵容了这次入侵的发生。现在，他的心智，麦克尼尔·瑟玛普拉格还留在诺莫瑞根中——他在继续筹划着自己黑暗的计划并成为这座城市新的科技领主。"
Inst29Caption = "诺莫瑞根"
Inst29QAA = "8 任务"
Inst29QAH = "3 任务"

--QUEST1 Allianz

Inst29Quest1 = "1. 拯救尖端机器人！"
Inst29Quest1_Attain = "?"
Inst29Quest1_Level = "26"
Inst29Quest1_Aim = "将尖端机器人的存储器核心交给铁炉堡的工匠大师欧沃斯巴克。"
Inst29Quest1_Location = "工匠大师欧沃斯巴克 (铁炉堡; "..YELLOW.."69,50 "..WHITE..")"
Inst29Quest1_Note = "你可以在萨尔努修士那儿接到此任务的前导任务"..YELLOW.."(暴风城; 40,30)"..WHITE..".\n在你进入副本之前，后门附近，可以找到尖端机器人。"
Inst29Quest1_Prequest = "有，工匠大师欧沃斯巴克"
Inst29Quest1_Folgequest = "无"
Inst29Quest1PreQuest = "true"

--Quest2 Allianz

Inst29Quest2 = "2. 诺恩"
Inst29Quest2_Attain = "?"
Inst29Quest2_Level = "27"
Inst29Quest2_Aim = "用空铅瓶对着辐射入侵者或者辐射抢劫者，从它们身上收集放射尘。瓶子装满之后，把它交给卡拉诺斯的奥齐·电环。"
Inst29Quest2_Location = "奥齐·电环 (丹莫罗 - 卡拉诺斯; "..YELLOW.."45,49 "..WHITE..")"
Inst29Quest2_Note = "你可以在诺恩那儿得到此任务的前导任务 "..YELLOW.."(Ironforge; 69,50)"..WHITE.."。\n要得到辐射尘，你必须对 "..RED.."活的"..WHITE.." 辐射入侵者 或者 辐射抢劫者 使用瓶子。"
Inst29Quest2_Prequest = "有，灾难之后"
Inst29Quest2_Folgequest = "有，更多的辐射尘"
Inst29Quest2PreQuest = "true"

--Quest3 Allianz

Inst29Quest3 = "3. 更多的辐射尘！"
Inst29Quest3_Attain = "27"
Inst29Quest3_Level = "30"
Inst29Quest3_Aim = "到诺莫瑞根去收集高强度辐射尘。要多加小心，这种辐射尘非常不稳定，很快就会分解。奥齐要求你把沉重的铅瓶也交给他。"
Inst29Quest3_Location = "奥齐·电环 (丹莫罗 - 卡拉诺斯; "..YELLOW.."45,49 "..WHITE..")"
Inst29Quest3_Note = "要得到辐射尘，你必须对 "..RED.."活着的"..WHITE.." 辐射泥浆怪，辐射潜伏者，辐射水元素 使用你的那个沉重的铅瓶"
Inst29Quest3_Prequest = "有，诺恩"
Inst29Quest3_Folgequest = "无"
Inst29Quest3FQuest = "true"

--Quest4 Allianz

Inst29Quest4 = "4. 陀螺式挖掘机"
Inst29Quest4_Attain = "?"
Inst29Quest4_Level = "30"
Inst29Quest4_Aim = "收集24副机械内胆，把它们交给暴风城的舒尼。"
Inst29Quest4_Location = "沉默的舒尼 (暴风城; "..YELLOW.."55,12 "..WHITE..")"
Inst29Quest4_Note = "每个机器人都掉落内胆。"
Inst29Quest4_Prequest = "无"
Inst29Quest4_Folgequest = "无"
--
Inst29Quest4name1 = "舒尼的扳手"
Inst29Quest4name2 = "欺诈手套"

--Quest5 Allianz

Inst29Quest5 = "5. 基础模组"
Inst29Quest5_Attain = "?"
Inst29Quest5_Level = "30"
Inst29Quest5_Aim = "收集12个基础模组，把它们交给铁炉堡的科劳莫特·钢尺。"
Inst29Quest5_Location = "科劳莫特·钢尺 (铁炉堡; "..YELLOW.."68,46 "..WHITE..")"
Inst29Quest5_Note = "你可以在玛希尔那儿得到此任务的前导任务 "..YELLOW.."(达纳苏斯; 59,45)"..WHITE..".\n每个诺莫瑞根的敌人都可能掉落基础模组。"
Inst29Quest5_Prequest = "有，帮助科劳莫特"
Inst29Quest5_Folgequest = "无"
Inst29Quest5PreQuest = "true"

--Quest6 Allianz

Inst29Quest6 = "6. 抢救数据"
Inst29Quest6_Attain = "25"
Inst29Quest6_Level = "30"
Inst29Quest6_Aim = "将彩色穿孔卡片交给铁炉堡的大机械师卡斯派普。"
Inst29Quest6_Location = "大机械师卡斯派普 (铁炉堡; "..YELLOW.."69,48 "..WHITE..")"
Inst29Quest6_Note = "你可以在 加克希姆·尘链 那儿得到此任务的前导任务"..YELLOW.."(石爪山脉; 59,67)"..WHITE..".\n白色卡片随机掉落。你可以在进入副本之前紧靠后门入口处找到第一终端。第二个在 [3]，第三个在 [5]，而第四个在 [8]。"
Inst29Quest6_Prequest = "有，卡斯派普的任务"
Inst29Quest6_Folgequest = "无"
--
Inst29Quest6name1 = "修理工的斗篷"
Inst29Quest6name2 = "蒸汽锤"
Inst29Quest6PreQuest = "true"

--Quest7 Allianz

Inst29Quest7 = "7. 一团混乱"
Inst29Quest7_Attain = "22"
Inst29Quest7_Level = "30"
Inst29Quest7_Aim = "将克努比护送到出口，然后向藏宝海湾的斯库提汇报。"
Inst29Quest7_Location = "克努比 (诺莫瑞根 "..YELLOW.."[]"..WHITE..")"
Inst29Quest7_Note = "护送任务！你可以在"..YELLOW.."(荆棘谷 - 藏宝海湾; 27,77)"..WHITE.."找到斯库提。"
Inst29Quest7_Prequest = "无"
Inst29Quest7_Folgequest = "无"
--
Inst29Quest7name1 = "焊接护腕"
Inst29Quest7name2 = "精灵之翼"

--Quest8 Allianz

Inst29Quest8 = "8. 大叛徒"
Inst29Quest8_Attain = "?"
Inst29Quest8_Level = "35"
Inst29Quest8_Aim = "到诺莫瑞根去杀掉麦克尼尔·瑟玛普拉格。完成任务之后向大工匠梅卡托克报告。"
Inst29Quest8_Location = "大工匠梅卡托克 (铁炉堡 "..YELLOW.."68,48"..WHITE..")"
Inst29Quest8_Note = "你可以在 [6] 找到麦克尼尔·瑟玛普拉格。他是诺莫瑞根最后一个Boss。"--\nDuring the fight you have to disable the columns through pushing the button on the side."
Inst29Quest8_Prequest = "无"
Inst29Quest8_Folgequest = "无"
--
Inst29Quest8name1 = "公民长袍"
Inst29Quest8name2 = "旅行皮裤"
Inst29Quest8name3 = "双链护腿 "

--QUEST1 Horde

Inst29Quest1_HORDE = "1. 出发！诺莫瑞根！"
Inst29Quest1_HORDE_Attain = "23"
Inst29Quest1_HORDE_Level = "35"
Inst29Quest1_HORDE_Aim = "等斯库提调整好地精传送器。"
Inst29Quest1_HORDE_Location = "斯库提 (荆棘谷 - 藏宝海湾; "..YELLOW.."27,77 "..WHITE..")"
Inst29Quest1_HORDE_Note = "你可以在索维克那儿得到此任务的前导任务 "..YELLOW.."(奥格瑞玛; 75,25)"..WHITE.."。\n当你完成这个任务，你可以使用藏宝海湾的传送器。"
Inst29Quest1_HORDE_Prequest = "有，主工程师斯库提"
Inst29Quest1_HORDE_Folgequest = "无"
Inst29Quest1PreQuest_HORDE = "true"

--Quest2 Horde

Inst29Quest2_HORDE = "2. 一团混乱"
Inst29Quest2_HORDE_Attain = "22"
Inst29Quest2_HORDE_Level = "30"
Inst29Quest2_HORDE_Aim = "将克努比护送到出口，然后向藏宝海湾的斯库提汇报。"
Inst29Quest2_HORDE_Location = "克努比 (诺莫瑞根 "..YELLOW.."near the clean zone"..WHITE..")"
Inst29Quest2_HORDE_Note = "护送任务！你可以在 "..YELLOW.."(荆棘谷 - 藏宝海湾; 27,77)"..WHITE.."找到斯库提。"
Inst29Quest2_HORDE_Prequest = "无"
Inst29Quest2_HORDE_Folgequest = "无"
--
Inst29Quest2name1_HORDE = "焊接护腕 "
Inst29Quest2name2_HORDE = "精灵之翼"

--Quest3 Horde

Inst29Quest3_HORDE = "3. 设备之战"
Inst29Quest3_HORDE_Attain = "?"
Inst29Quest3_HORDE_Level = "35"
Inst29Quest3_HORDE_Aim = "从诺莫瑞根拿到钻探设备蓝图和麦克尼尔的保险箱密码，把它们交给奥格瑞玛的诺格。"
Inst29Quest3_HORDE_Location = "诺格 (奥格瑞玛; "..YELLOW.."75,25 "..WHITE..")"
Inst29Quest3_HORDE_Note = "你可以在 [6] 发现麦克尼尔·瑟玛普拉格。他是诺莫瑞根最后一个Boss。"
--	^^^^^^	\nDuring the fight you have to disable the columns through pushing the button on the side.	^^^^^^
Inst29Quest3_HORDE_Prequest = "无"
Inst29Quest3_HORDE_Folgequest = "无"
--
Inst29Quest3name1_HORDE = "公民长袍"
Inst29Quest3name2_HORDE = "旅行皮裤"
Inst29Quest3name3_HORDE = "双链护腿"

------------------------------------------------------------------------------------------------------
------------------------------------------------- RAID -----------------------------------------------
------------------------------------------------------------------------------------------------------

--------------Inst30/Alptraumdrachen------------
Inst30Story = {
  ["Page1"] = "世界之树陷入了一场骚乱。僻静的灰谷、暮色森林、菲拉斯以及辛特兰面临着新的威胁。绿龙军团的四条守护巨龙从翡翠梦境来到了艾泽拉斯世界，这些曾经忠心耿耿的守护者，现在却为世界带来了毁灭和死亡的气息。拿起武器，跟你的伙伴一同进入那些神秘的森林——只有你能从巨龙手中拯救艾泽拉斯",
  ["Page2"] = "翡翠梦境的守护巨龙伊瑟拉统治着神秘的绿龙军团。她居住在翡翠梦境中，支配着世界万物的演化方向。她是自然和梦幻的守护者，她统治的绿龙军团负责保护世界之树，只有德鲁伊才能通过世界之树进入翡翠梦境。\n近来，在翡翠梦境中的某种新的黑暗力量的驱使下，伊瑟拉最忠诚的守护者们穿越世界之树，来到了艾泽拉斯世界，妄图使世界再度陷入疯狂和恐慌。即使是最强大的冒险者也应该对这些巨龙退避三舍，否则他就将为此付出惨重的代价。",
  ["Page3"] = "受翡翠梦境黑暗力量的影响，莱索恩的龙鳞失去了光泽，他拥有了汲取敌人幻象的力量。这些幻象可以赋予巨龙治疗的能力。毫无疑问，莱索恩被认为是伊瑟拉手下最强大的守护者。",
  ["Page4"] = "在翡翠梦境的某种神秘的黑暗力量诱惑下，高贵的艾莫莉丝成为了一头腐烂、患病的怪物。少数侥幸生还者称，他们死去的伙伴的尸体上长出了腐烂的蘑菇，那情形异常恐怖。艾莫莉丝是伊瑟拉统治的绿龙军团中最可怕的巨龙。",
  ["Page5"] = "泰拉尔或许是伊瑟拉的守护者中受黑暗力量影响最深的巨龙。翡翠梦境的黑暗力量彻底摧毁了泰拉尔的心智和肉体。他成为拥有分身术的巨龙幽灵，各个分身都具备强大的魔法破坏力。泰拉尔是个狡猾无情的敌人，他妄图使艾泽拉斯世界的所有生物都陷入疯狂。",
  ["Page6"] = "伊瑟拉最忠诚的守护者伊森德雷如今已面目全非，她在艾泽拉斯大陆上散播着恐慌和混乱。她先前拥有的治疗能力被黑暗魔法所取代，她能释放烟状的闪电波并召唤恶魔德鲁伊。伊森德雷和她的龙族拥有催眠技能，可以使敌人陷入最可怕的噩梦。",
  ["MaxPages"] = "6",
};
Inst30Caption = "梦魇之龙"
Inst30Caption2 = "伊瑟拉和绿龙军团"
Inst30Caption3 = "莱索恩"
Inst30Caption4 = "艾莫莉丝"
Inst30Caption5 = "泰拉尔"
Inst30Caption6 = "伊森德雷"

--------------Azuregos------------
Inst31Story = "在世界大分裂之前，暗夜精灵之城埃达拉斯在如今被称作艾萨拉的土地上可说是非常繁盛。据说很多古老和强大的高等精灵神器，可能就藏在强极一时的堡垒里。经历了无数世代，蓝龙军团全力保护神器与魔法传说，确保它们不落入凡人手中。蓝龙，艾索雷葛斯的出现，似乎暗示着那些具有极重要意义的物品，像是预言中的永恒之瓶，或许就能在艾萨拉的荒野里找到。无论艾索雷葛斯在寻找什么，可以肯定的是：他会誓死保卫艾萨拉的魔法宝藏。"
Inst31Caption = "艾索雷葛斯"

--------------Kazzak------------
Inst32Story = "在燃烧军团于第三次大战获胜之后，由恶魔卡扎克所领导的剩余敌军，退回了诅咒之地。到现在为止他们都还住在那里，一个叫腐烂之痕的地方，等待黑暗之门再度敞开。谣传黑暗之门再度敞开之时，卡扎克将带着他剩下的军队前往外域。曾经是兽人家园的德拉诺，外域被兽人萨满耐奥祖所建造的数个传送门同时开启而分割开来，现在更成为被暗夜精灵背叛者伊利丹统帅的恶魔军队所占领的破碎世界。"
Inst32Caption = "卡扎克"

--------------Inst14/geschmolzener Kern------------
Inst14Story = "熔火之心就在黑石深渊的底层。这是黑石山的中心，也是很久以前扭转矮人内战情势的地方，索瑞森大帝将元素火焰之王，拉格纳罗斯召唤到世界来。尽管火焰之王无法远离熔火之心，但人们相信他的元素爪牙控制着黑铁矮人，在遗迹之外组建军队。拉格纳罗斯休眠的燃烧之湖有一道裂缝连接火平面，让邪恶的元素可以通过。拉格纳罗斯的首要代理人是管理者埃克索图斯——因为这是唯一能唤醒火焰之王的狡猾元素。"
Inst14Caption = "熔火之心"

--------------Inst16/Onyxia------------
Inst16Story = "奥妮克希亚是强大之龙死亡之翼的女儿，也是黑石塔擅长阴谋的奈法利安大王的妹妹。据说奥妮克希亚喜欢借由干涉人类种族的政治来腐化他们。为达此目的他会变成各种人型生物形态，使用魔法和力量干预不同种族间的所有事情。有些人更认为奥妮克希亚使用父亲曾用过的化名——皇室普瑞斯托。若不插手凡人事务的时候，奥妮克希亚就在黑龙谷下的一处火焰洞穴居住，那是尘泥沼泽里的一个阴暗沼泽。阴险的黑龙军团剩余成员在此守护着她。"
Inst16Caption = "奥妮克希亚的巢穴"

--------------Inst6------------
Inst6Story = {
  ["Page1"] = "黑翼之巢，它位于黑石塔的最顶端。奈法利安就在那里进行着他的秘密计划的最后步骤，并准备摧毁拉格纳罗斯的势力，最终统治整个艾泽拉斯。",
  ["Page2"] = "座落在黑石山脉中的巨型要塞是由矮人建筑大师弗兰克罗恩·铸铁设计的，作为力量和实力的象征，这座要塞被邪恶的黑铁矮人占据了数个世纪之久。但是，黑龙死亡之翼的儿子奈法利安对这座要塞有着别的打算。他和他的黑龙军团占据了黑石塔的上层区域，并与黑石深渊中的那些侍奉火焰之王拉格纳罗斯的黑铁矮人不断交战。拉格纳罗斯找到了为岩石赋予生命的方法，并准备制造一支无坚不摧的傀儡大军，以此来帮助他实施征服整个黑石山的计划。",
  ["Page3"] = "而奈法利安则发誓要毁灭拉格纳罗斯，因此他近期以来加速了扩张军队的步伐，就像他的父亲死亡之翼曾经尝试过的那样。虽然死亡之翼最终失败了，但看起来奈法利安很有希望获得成功。他对于权力的疯狂渴求甚至引起了红龙军团的警觉——他们一直是黑龙最强大的敌人。不过，即便奈法利安的目标非常明显，他所采用的手段却不为人知。但是据信他正在尝试杂交各种颜色的龙以制造出最强大的战士。\n \n奈法利安的藏身之所被称为黑翼之巢，它位于黑石塔的最顶端。奈法利安就在那里进行着他的秘密计划的最后步骤，并准备摧毁拉格纳罗斯的势力，最终统治整个艾泽拉斯。",
    ["MaxPages"] = "3",
};
Inst6Caption = "黑翼之巢"
Inst6Caption2 = "黑翼之巢 (故事背景 第 1 部分)"
Inst6Caption3 = "黑翼之巢 (故事背景 第 2 部分)"

--------------Inst23------------
Inst23Story = "在流沙之战最后几个小时里，四巨龙军团和暗夜精灵的联军将战场逼至其拉帝国的最中心，希利苏斯的异种虫群退败至最终堡垒安其拉城。但在安其拉之门内，等待着的却是大规模的其拉异种虫，数量是卡利姆多联军所无法想象的。经过漫长的战役，卡利姆多联军仍然无法击败其拉帝王以及他的异种虫群，只能以一个强大的魔法结界将它们困禁在内，而安其拉城也因为战火而成了一个被诅咒的废墟。经过了数千年，其拉的侵略心却没有因为结界而消退。新一代的异种虫群从巢穴中慢慢的破茧而出，安其拉废墟又再度充满了其拉异种虫。这股威胁一定要被消灭，否则艾泽拉斯将可能会被这股恐怖的新世代其拉势力给毁灭。"
Inst23Caption = "安其拉废墟"

--------------Inst26------------
Inst26Story = "在安其拉中心矗立着一座古老神庙综合体。它在史前时代就被建造，用以纪念伟大的神与提供其拉大军繁衍的场地。自数千年前的流沙之战结束后，其拉帝国的双子皇帝就被青铜龙阿纳克洛斯和暗夜精灵们以强大的魔法结界困在了神庙里。随着时间流逝，流沙权杖已被重组，魔法结界上的封印也逐渐消失，通往安其拉神庙深处的道路也再度敞开。那些被困在神庙地下蠢蠢欲动的其拉军团开始准备入侵。为了避免第二次流沙之战再度爆发、贪婪的虫群再次于卡利姆多大陆倾巢而出，无论如何一定要阻止它们！"
Inst26Caption = "安其拉神庙"

--------------Inst28------------
Inst28Story = {
  ["Page1"] = "早在几千年前，强大的古拉巴什帝国陷入了一场规模浩大的内战，一群极具影响力的被称作阿塔莱的巨魔祭司，信奉着一个名叫夺灵者·哈卡的嗜血的邪神。这些阿塔莱祭司虽然已被击败并被处以永久的流放，但伟大的巨魔帝国就这样崩塌了。被流放的祭司们来到了北方的悲伤沼泽。在这里，他们为哈卡神建造了一座大神庙——阿塔哈卡神庙，并继续在那里为他们的主人重返物质世界而作准备……",
  ["Page2"] = "终于，阿塔莱祭司发现，哈卡的物质形态只有在古老的古拉巴什帝国的首都——祖尔格拉布，才能召唤出来。不幸的是，这些祭司们最近真的成功召唤出哈卡——传闻证实可怕的夺灵者真的出现在古拉巴什废墟的中心。\n \n为了镇压血神，所有的巨魔都联合起来，派出了一支由高阶牧师组成的小队深入这座古老的城市。队中的每个牧师都是一位远古之神的强大战士，他们分别代表着蝙蝠、豹、老虎、蜘蛛和蛇的力量，但是尽管如此，强大的哈卡仍然轻易地击败了他们。现在这些勇士和他们的远古之神全都臣服于夺灵者的力量。如果有任何冒险者想进入废墟禁地挑战强大的血神哈卡，他们就必须先击败这些高阶牧师。",
  ["MaxPages"] = "2",
};
Inst28Caption = "祖尔格拉布"
Inst28Caption2 = "祖尔格拉布 (故事背景)"

--------------Inst15 /Naxxramas------------
Inst15Story = "飘浮在瘟疫之地上空的浮空要塞纳克萨玛斯是巫妖王最强大的副官——克尔苏加德的旗舰。巫妖王的仆从们在这座要塞中筹划着新的攻势，要给整个艾泽拉斯世界带来恐慌和灾难。天灾军团再一次开始了他们的征程……"
Inst15Caption = "纳克萨玛斯"

--------------Inst33 / Alterac Vally------------
Inst33Story = "很久以前，早在兽人入侵艾泽拉斯之前，兽人术士古尔丹将一只被称作“霜狼”的兽人氏族流放到了奥特兰克山脉深处的峡谷中。霜狼氏族艰难地在这座峡谷的南部生存，直到萨尔找到他们。\n在萨尔成功地将兽人氏族重新联合起来之后，由萨满祭祀德雷克塔尔领导的霜狼氏族决定继续在这个他们很久以来一直称之为家的地方生活。但是最近，这里的平静被矮人的雷矛远征军打破了。\n雷矛部族在奥特兰克山谷中建立了基地，意图寻找这里的自然资源和上古遗物。不管他们的意图如何，雷矛部族和南部的霜狼氏族发生了激烈的冲突，后者发誓要将入侵者赶出自己的家园。"
Inst33Caption = "奥特兰克山谷"

--------------Inst34 / Arathi Basin------------
Inst34Story = "位于阿拉希高地的阿拉希盆地，是一个快速而刺激的战场。这个盆地里充满了资源，因此联盟和部落都觊觎这块宝地。被遗忘的污染者和阿拉索联军已到达阿拉希盆地，要为这些天然资源开战并为各自的阵营占为己有。"
Inst34Caption = "阿拉希盆地"

--------------Inst35 / Warsong Gulch------------
Inst35Story = "位于灰谷南方区域的战歌峡谷，是靠近第三次大战中格罗姆·地狱咆哮和他的兽人们大量砍伐森林的地方。有些兽人仍在邻近地区，继续砍伐森林以扩大部落的版图。他们自称为战歌侦查骑兵。\n而展开大规模攻势要夺回灰谷的暗夜精灵们，正致力于将侦查骑兵永远逐出他们的土地。因此，银翼哨兵回应了请求，并发誓他们非击败所有兽人并将它们赶出战歌峡谷不可。"
Inst35Caption = "战歌峡谷"

--------------Inst37 / Hellfire Citadel / BloodFurnaces------------
Inst37Story = {
  ["Page1"] = "On the blasted world of Outland, within the heart of Hellfire Peninsula stands Hellfire Citadel, a nearly impenetrable bastion that served as the Horde's base of operations throughout the First and Second Wars. For years this gargantuan fortress was thought to be abandoned...\n \nUntil recently.\n \nThough much of Draenor was shattered by the reckless Ner'zhul, the Hellfire Citadel remains intact?inhabited now by marauding bands of red, furious fel orcs. Though the presence of this new, savage breed presents something of a mystery, what's far more disconcerting is that the numbers of these fel orcs seem to be growing.\n \nDespite Thrall and Grom Hellscream's successful bid to end the Horde's corruption by slaying Mannoroth, reports indicate that the barbaric orcs of Hellfire Citadel have somehow managed to find a new source of corruption to fuel their primitive bloodlust.",
  ["Page2"] = "Whatever authority these orcs answer to is unknown, although it is a strongly held belief that they are not working for the Burning Legion.\n \nPerhaps the most unsettling news to come from Outland are the accounts of thunderous, savage cries issuing from somewhere deep beneath the citadel. Many have begun to wonder if these unearthly outbursts are somehow connected to the corrupted fel orcs and their growing numbers. Unfortunately those questions will have to remain unanswered.\n \nAt least for now.",
  ["MaxPages"] = "2",
};
Inst37Caption = "地狱火堡垒:热血熔炉"

--------------Inst38 / Hellfire Citadel / ShatteredHalls------------
Inst38Story = {
  ["Page1"] = "On the blasted world of Outland, within the heart of Hellfire Peninsula stands Hellfire Citadel, a nearly impenetrable bastion that served as the Horde's base of operations throughout the First and Second Wars. For years this gargantuan fortress was thought to be abandoned...\n \nUntil recently.\n \nThough much of Draenor was shattered by the reckless Ner'zhul, the Hellfire Citadel remains intact?inhabited now by marauding bands of red, furious fel orcs. Though the presence of this new, savage breed presents something of a mystery, what's far more disconcerting is that the numbers of these fel orcs seem to be growing.\n \nDespite Thrall and Grom Hellscream's successful bid to end the Horde's corruption by slaying Mannoroth, reports indicate that the barbaric orcs of Hellfire Citadel have somehow managed to find a new source of corruption to fuel their primitive bloodlust.",
  ["Page2"] = "Whatever authority these orcs answer to is unknown, although it is a strongly held belief that they are not working for the Burning Legion.\n \nPerhaps the most unsettling news to come from Outland are the accounts of thunderous, savage cries issuing from somewhere deep beneath the citadel. Many have begun to wonder if these unearthly outbursts are somehow connected to the corrupted fel orcs and their growing numbers. Unfortunately those questions will have to remain unanswered.\n \nAt least for now.",
  ["MaxPages"] = "2",
};
Inst38Caption = "地狱火堡垒:碎裂大厅"

-----
end
-----

--    AQINSTANZ :
-- 1  = VC     21 = BSF
-- 2  = WC     22 = STRAT
-- 3  = RFA    23 = AQ20
-- 4  = ULD    24 = STOCKADE
-- 5  = BRD    25 = TEMPLE
-- 6  = BWl    26 = AQ40
-- 7  = BFD    27 = ZUL
-- 8  = LBRS   28 = ZG
-- 9  = UBRS   29 = GNOMERE
-- 10 = DME    30 = DRAGONS
-- 11 = DMN    31 = AZUREGOS
-- 12 = DMW    32 = KAZZAK
-- 13 = MARA   33 = AV
-- 14 = MC     34 = AB
-- 15 = NAXX   35 = WS
-- 16 = ONY    36 = REST
-- 17 = HUEGEL 37 = HCBloodFurnaces
-- 18 = KRAL   38 = HCShatteredHalls
-- 19 = KLOSTER
-- 20 = SCHOLO