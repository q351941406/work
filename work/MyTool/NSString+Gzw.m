//
//  NSString+Gzw.m
//  跑腿
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 paotui. All rights reserved.
//

#import "NSString+Gzw.h"

@implementation NSString (Gzw)
-(NSString *)digitUppercaseWithMoney:(NSString *)money
{
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    NSArray *MyScale=@[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    
    NSArray *integerArray = @[@"拾", @"佰", @"仟", @"万", @"拾万", @"佰万", @"仟万", @"亿", @"拾亿", @"佰亿", @"仟亿", @"兆", @"拾兆", @"佰兆", @"仟兆"];
    
    
    NSMutableString * M = [[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(NSInteger i=moneyStr.length;i>0;i--)
    {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [M appendString:MyBase[MyData]];
        
        //判断是否是整数金额
        if (i == moneyStr.length) {
            NSInteger l = [[moneyStr substringFromIndex:1] integerValue];
            if (MyData > 0 &&
                l == 0 ) {
                NSString *integerString = @"";
                if (moneyStr.length > 3) {
                    integerString = integerArray[moneyStr.length-4];
                }
                [M appendString:[NSString stringWithFormat:@"%@%@",integerString,@"元整"]];
                break;
            }
        }
        
        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0
           && i != 1
           && i != 2)
        {
            [M appendString:@"元整"];
            break;
        }
        [M appendString:MyScale[i-1]];
    }
    return M;
}
+(NSString *)gzw_getNumber:(NSString *)str
{
    NSString *originalString = str;
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:originalString.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
}
static NSDictionary * gzw_s_unicodeToCheatCodes = nil;
static NSDictionary * gzw_s_cheatCodesToUnicode = nil;

+ (void)gzw_initializeEmojiCheatCodes
{
    NSDictionary *forwardMap = @{
                                 @"😄": @":smile:",
                                 @"😆": @[@":laughing:", @":D"],
                                 @"😊": @":blush:",
                                 @"😃": @[@":smiley:", @":)", @":-)"],
                                 @"☺": @":relaxed:",
                                 @"😏": @":smirk:",
                                 @"😞": @[@":disappointed:", @":("],
                                 @"😍": @":heart_eyes:",
                                 @"😘": @":kissing_heart:",
                                 @"😚": @":kissing_closed_eyes:",
                                 @"😳": @":flushed:",
                                 @"😥": @":relieved:",
                                 @"😌": @":satisfied:",
                                 @"😁": @":grin:",
                                 @"😉": @[@":wink:", @";)", @";-)"],
                                 @"😜": @[@":wink2:", @":P"],
                                 @"😝": @":stuck_out_tongue_closed_eyes:",
                                 @"😀": @":grinning:",
                                 @"😗": @":kissing:",
                                 @"😙": @":kissing_smiling_eyes:",
                                 @"😛": @":stuck_out_tongue:",
                                 @"😴": @":sleeping:",
                                 @"😟": @":worried:",
                                 @"😦": @":frowning:",
                                 @"😧": @":anguished:",
                                 @"😮": @[@":open_mouth:", @":o"],
                                 @"😬": @":grimacing:",
                                 @"😕": @":confused:",
                                 @"😯": @":hushed:",
                                 @"😑": @":expressionless:",
                                 @"😒": @":unamused:",
                                 @"😅": @":sweat_smile:",
                                 @"😓": @":sweat:",
                                 @"😩": @":weary:",
                                 @"😔": @":pensive:",
                                 @"😞": @":dissapointed:",
                                 @"😖": @":confounded:",
                                 @"😨": @":fearful:",
                                 @"😰": @":cold_sweat:",
                                 @"😣": @":persevere:",
                                 @"😢": @":cry:",
                                 @"😭": @":sob:",
                                 @"😂": @":joy:",
                                 @"😲": @":astonished:",
                                 @"😱": @":scream:",
                                 @"😫": @":tired_face:",
                                 @"😠": @":angry:",
                                 @"😡": @":rage:",
                                 @"😤": @":triumph:",
                                 @"😪": @":sleepy:",
                                 @"😋": @":yum:",
                                 @"😷": @":mask:",
                                 @"😎": @":sunglasses:",
                                 @"😵": @":dizzy_face:",
                                 @"👿": @":imp:",
                                 @"😈": @":smiling_imp:",
                                 @"😐": @":neutral_face:",
                                 @"😶": @":no_mouth:",
                                 @"😇": @":innocent:",
                                 @"👽": @":alien:",
                                 @"💛": @":yellow_heart:",
                                 @"💙": @":blue_heart:",
                                 @"💜": @":purple_heart:",
                                 @"❤": @":heart:",
                                 @"💚": @":green_heart:",
                                 @"💔": @":broken_heart:",
                                 @"💓": @":heartbeat:",
                                 @"💗": @":heartpulse:",
                                 @"💕": @":two_hearts:",
                                 @"💞": @":revolving_hearts:",
                                 @"💘": @":cupid:",
                                 @"💖": @":sparkling_heart:",
                                 @"✨": @":sparkles:",
                                 @"⭐️": @":star:",
                                 @"🌟": @":star2:",
                                 @"💫": @":dizzy:",
                                 @"💥": @":boom:",
                                 @"💢": @":anger:",
                                 @"❗": @":exclamation:",
                                 @"❓": @":question:",
                                 @"❕": @":grey_exclamation:",
                                 @"❔": @":grey_question:",
                                 @"💤": @":zzz:",
                                 @"💨": @":dash:",
                                 @"💦": @":sweat_drops:",
                                 @"🎶": @":notes:",
                                 @"🎵": @":musical_note:",
                                 @"🔥": @":fire:",
                                 @"💩": @[@":poop:", @":hankey:", @":shit:"],
                                 @"👍": @[@":+1:", @":thumbsup:"],
                                 @"👎": @[@":-1:", @":thumbsdown:"],
                                 @"👌": @":ok_hand:",
                                 @"👊": @":punch:",
                                 @"✊": @":fist:",
                                 @"✌": @":v:",
                                 @"👋": @":wave:",
                                 @"✋": @":hand:",
                                 @"👐": @":open_hands:",
                                 @"☝": @":point_up:",
                                 @"👇": @":point_down:",
                                 @"👈": @":point_left:",
                                 @"👉": @":point_right:",
                                 @"🙌": @":raised_hands:",
                                 @"🙏": @":pray:",
                                 @"👆": @":point_up_2:",
                                 @"👏": @":clap:",
                                 @"💪": @":muscle:",
                                 @"🚶": @":walking:",
                                 @"🏃": @":runner:",
                                 @"👫": @":couple:",
                                 @"👪": @":family:",
                                 @"👬": @":two_men_holding_hands:",
                                 @"👭": @":two_women_holding_hands:",
                                 @"💃": @":dancer:",
                                 @"👯": @":dancers:",
                                 @"🙆": @":ok_woman:",
                                 @"🙅": @":no_good:",
                                 @"💁": @":information_desk_person:",
                                 @"🙋": @":raised_hand:",
                                 @"👰": @":bride_with_veil:",
                                 @"🙎": @":person_with_pouting_face:",
                                 @"🙍": @":person_frowning:",
                                 @"🙇": @":bow:",
                                 @"💏": @":couplekiss:",
                                 @"💑": @":couple_with_heart:",
                                 @"💆": @":massage:",
                                 @"💇": @":haircut:",
                                 @"💅": @":nail_care:",
                                 @"👦": @":boy:",
                                 @"👧": @":girl:",
                                 @"👩": @":woman:",
                                 @"👨": @":man:",
                                 @"👶": @":baby:",
                                 @"👵": @":older_woman:",
                                 @"👴": @":older_man:",
                                 @"👱": @":person_with_blond_hair:",
                                 @"👲": @":man_with_gua_pi_mao:",
                                 @"👳": @":man_with_turban:",
                                 @"👷": @":construction_worker:",
                                 @"👮": @":cop:",
                                 @"👼": @":angel:",
                                 @"👸": @":princess:",
                                 @"😺": @":smiley_cat:",
                                 @"😸": @":smile_cat:",
                                 @"😻": @":heart_eyes_cat:",
                                 @"😽": @":kissing_cat:",
                                 @"😼": @":smirk_cat:",
                                 @"🙀": @":scream_cat:",
                                 @"😿": @":crying_cat_face:",
                                 @"😹": @":joy_cat:",
                                 @"😾": @":pouting_cat:",
                                 @"👹": @":japanese_ogre:",
                                 @"👺": @":japanese_goblin:",
                                 @"🙈": @":see_no_evil:",
                                 @"🙉": @":hear_no_evil:",
                                 @"🙊": @":speak_no_evil:",
                                 @"💂": @":guardsman:",
                                 @"💀": @":skull:",
                                 @"👣": @":feet:",
                                 @"👄": @":lips:",
                                 @"💋": @":kiss:",
                                 @"💧": @":droplet:",
                                 @"👂": @":ear:",
                                 @"👀": @":eyes:",
                                 @"👃": @":nose:",
                                 @"👅": @":tongue:",
                                 @"💌": @":love_letter:",
                                 @"👤": @":bust_in_silhouette:",
                                 @"👥": @":busts_in_silhouette:",
                                 @"💬": @":speech_balloon:",
                                 @"💭": @":thought_balloon:",
                                 @"☀": @":sunny:",
                                 @"☔": @":umbrella:",
                                 @"☁": @":cloud:",
                                 @"❄": @":snowflake:",
                                 @"⛄": @":snowman:",
                                 @"⚡": @":zap:",
                                 @"🌀": @":cyclone:",
                                 @"🌁": @":foggy:",
                                 @"🌊": @":ocean:",
                                 @"🐱": @":cat:",
                                 @"🐶": @":dog:",
                                 @"🐭": @":mouse:",
                                 @"🐹": @":hamster:",
                                 @"🐰": @":rabbit:",
                                 @"🐺": @":wolf:",
                                 @"🐸": @":frog:",
                                 @"🐯": @":tiger:",
                                 @"🐨": @":koala:",
                                 @"🐻": @":bear:",
                                 @"🐷": @":pig:",
                                 @"🐽": @":pig_nose:",
                                 @"🐮": @":cow:",
                                 @"🐗": @":boar:",
                                 @"🐵": @":monkey_face:",
                                 @"🐒": @":monkey:",
                                 @"🐴": @":horse:",
                                 @"🐎": @":racehorse:",
                                 @"🐫": @":camel:",
                                 @"🐑": @":sheep:",
                                 @"🐘": @":elephant:",
                                 @"🐼": @":panda_face:",
                                 @"🐍": @":snake:",
                                 @"🐦": @":bird:",
                                 @"🐤": @":baby_chick:",
                                 @"🐥": @":hatched_chick:",
                                 @"🐣": @":hatching_chick:",
                                 @"🐔": @":chicken:",
                                 @"🐧": @":penguin:",
                                 @"🐢": @":turtle:",
                                 @"🐛": @":bug:",
                                 @"🐝": @":honeybee:",
                                 @"🐜": @":ant:",
                                 @"🐞": @":beetle:",
                                 @"🐌": @":snail:",
                                 @"🐙": @":octopus:",
                                 @"🐠": @":tropical_fish:",
                                 @"🐟": @":fish:",
                                 @"🐳": @":whale:",
                                 @"🐋": @":whale2:",
                                 @"🐬": @":dolphin:",
                                 @"🐄": @":cow2:",
                                 @"🐏": @":ram:",
                                 @"🐀": @":rat:",
                                 @"🐃": @":water_buffalo:",
                                 @"🐅": @":tiger2:",
                                 @"🐇": @":rabbit2:",
                                 @"🐉": @":dragon:",
                                 @"🐐": @":goat:",
                                 @"🐓": @":rooster:",
                                 @"🐕": @":dog2:",
                                 @"🐖": @":pig2:",
                                 @"🐁": @":mouse2:",
                                 @"🐂": @":ox:",
                                 @"🐲": @":dragon_face:",
                                 @"🐡": @":blowfish:",
                                 @"🐊": @":crocodile:",
                                 @"🐪": @":dromedary_camel:",
                                 @"🐆": @":leopard:",
                                 @"🐈": @":cat2:",
                                 @"🐩": @":poodle:",
                                 @"🐾": @":paw_prints:",
                                 @"💐": @":bouquet:",
                                 @"🌸": @":cherry_blossom:",
                                 @"🌷": @":tulip:",
                                 @"🍀": @":four_leaf_clover:",
                                 @"🌹": @":rose:",
                                 @"🌻": @":sunflower:",
                                 @"🌺": @":hibiscus:",
                                 @"🍁": @":maple_leaf:",
                                 @"🍃": @":leaves:",
                                 @"🍂": @":fallen_leaf:",
                                 @"🌿": @":herb:",
                                 @"🍄": @":mushroom:",
                                 @"🌵": @":cactus:",
                                 @"🌴": @":palm_tree:",
                                 @"🌲": @":evergreen_tree:",
                                 @"🌳": @":deciduous_tree:",
                                 @"🌰": @":chestnut:",
                                 @"🌱": @":seedling:",
                                 @"🌼": @":blossum:",
                                 @"🌾": @":ear_of_rice:",
                                 @"🐚": @":shell:",
                                 @"🌐": @":globe_with_meridians:",
                                 @"🌞": @":sun_with_face:",
                                 @"🌝": @":full_moon_with_face:",
                                 @"🌚": @":new_moon_with_face:",
                                 @"🌑": @":new_moon:",
                                 @"🌒": @":waxing_crescent_moon:",
                                 @"🌓": @":first_quarter_moon:",
                                 @"🌔": @":waxing_gibbous_moon:",
                                 @"🌕": @":full_moon:",
                                 @"🌖": @":waning_gibbous_moon:",
                                 @"🌗": @":last_quarter_moon:",
                                 @"🌘": @":waning_crescent_moon:",
                                 @"🌜": @":last_quarter_moon_with_face:",
                                 @"🌛": @":first_quarter_moon_with_face:",
                                 @"🌙": @":moon:",
                                 @"🌍": @":earth_africa:",
                                 @"🌎": @":earth_americas:",
                                 @"🌏": @":earth_asia:",
                                 @"🌋": @":volcano:",
                                 @"🌌": @":milky_way:",
                                 @"⛅": @":partly_sunny:",
                                 @"🎍": @":bamboo:",
                                 @"💝": @":gift_heart:",
                                 @"🎎": @":dolls:",
                                 @"🎒": @":school_satchel:",
                                 @"🎓": @":mortar_board:",
                                 @"🎏": @":flags:",
                                 @"🎆": @":fireworks:",
                                 @"🎇": @":sparkler:",
                                 @"🎐": @":wind_chime:",
                                 @"🎑": @":rice_scene:",
                                 @"🎃": @":jack_o_lantern:",
                                 @"👻": @":ghost:",
                                 @"🎅": @":santa:",
                                 @"🎱": @":8ball:",
                                 @"⏰": @":alarm_clock:",
                                 @"🍎": @":apple:",
                                 @"🎨": @":art:",
                                 @"🍼": @":baby_bottle:",
                                 @"🎈": @":balloon:",
                                 @"🍌": @":banana:",
                                 @"📊": @":bar_chart:",
                                 @"⚾": @":baseball:",
                                 @"🏀": @":basketball:",
                                 @"🛀": @":bath:",
                                 @"🛁": @":bathtub:",
                                 @"🔋": @":battery:",
                                 @"🍺": @":beer:",
                                 @"🍻": @":beers:",
                                 @"🔔": @":bell:",
                                 @"🍱": @":bento:",
                                 @"🚴": @":bicyclist:",
                                 @"👙": @":bikini:",
                                 @"🎂": @":birthday:",
                                 @"🃏": @":black_joker:",
                                 @"✒": @":black_nib:",
                                 @"📘": @":blue_book:",
                                 @"💣": @":bomb:",
                                 @"🔖": @":bookmark:",
                                 @"📑": @":bookmark_tabs:",
                                 @"📚": @":books:",
                                 @"👢": @":boot:",
                                 @"🎳": @":bowling:",
                                 @"🍞": @":bread:",
                                 @"💼": @":briefcase:",
                                 @"💡": @":bulb:",
                                 @"🍰": @":cake:",
                                 @"📆": @":calendar:",
                                 @"📲": @":calling:",
                                 @"📷": @":camera:",
                                 @"🍬": @":candy:",
                                 @"📇": @":card_index:",
                                 @"💿": @":cd:",
                                 @"📉": @":chart_with_downwards_trend:",
                                 @"📈": @":chart_with_upwards_trend:",
                                 @"🍒": @":cherries:",
                                 @"🍫": @":chocolate_bar:",
                                 @"🎄": @":christmas_tree:",
                                 @"🎬": @":clapper:",
                                 @"📋": @":clipboard:",
                                 @"📕": @":closed_book:",
                                 @"🔐": @":closed_lock_with_key:",
                                 @"🌂": @":closed_umbrella:",
                                 @"♣": @":clubs:",
                                 @"🍸": @":cocktail:",
                                 @"☕": @":coffee:",
                                 @"💻": @":computer:",
                                 @"🎊": @":confetti_ball:",
                                 @"🍪": @":cookie:",
                                 @"🌽": @":corn:",
                                 @"💳": @":credit_card:",
                                 @"👑": @":crown:",
                                 @"🔮": @":crystal_ball:",
                                 @"🍛": @":curry:",
                                 @"🍮": @":custard:",
                                 @"🍡": @":dango:",
                                 @"🎯": @":dart:",
                                 @"📅": @":date:",
                                 @"♦": @":diamonds:",
                                 @"💵": @":dollar:",
                                 @"🚪": @":door:",
                                 @"🍩": @":doughnut:",
                                 @"👗": @":dress:",
                                 @"📀": @":dvd:",
                                 @"📧": @":e-mail:",
                                 @"🍳": @":egg:",
                                 @"🍆": @":eggplant:",
                                 @"🔌": @":electric_plug:",
                                 @"✉": @":email:",
                                 @"💶": @":euro:",
                                 @"👓": @":eyeglasses:",
                                 @"📠": @":fax:",
                                 @"📁": @":file_folder:",
                                 @"🍥": @":fish_cake:",
                                 @"🎣": @":fishing_pole_and_fish:",
                                 @"🔦": @":flashlight:",
                                 @"💾": @":floppy_disk:",
                                 @"🎴": @":flower_playing_cards:",
                                 @"🏈": @":football:",
                                 @"🍴": @":fork_and_knife:",
                                 @"🍤": @":fried_shrimp:",
                                 @"🍟": @":fries:",
                                 @"🎲": @":game_die:",
                                 @"💎": @":gem:",
                                 @"🎁": @":gift:",
                                 @"⛳": @":golf:",
                                 @"🍇": @":grapes:",
                                 @"🍏": @":green_apple:",
                                 @"📗": @":green_book:",
                                 @"🎸": @":guitar:",
                                 @"🔫": @":gun:",
                                 @"🍔": @":hamburger:",
                                 @"🔨": @":hammer:",
                                 @"👜": @":handbag:",
                                 @"🎧": @":headphones:",
                                 @"♥": @":hearts:",
                                 @"🔆": @":high_brightness:",
                                 @"👠": @":high_heel:",
                                 @"🔪": @":hocho:",
                                 @"🍯": @":honey_pot:",
                                 @"🏇": @":horse_racing:",
                                 @"⌛": @":hourglass:",
                                 @"⏳": @":hourglass_flowing_sand:",
                                 @"🍨": @":ice_cream:",
                                 @"🍦": @":icecream:",
                                 @"📥": @":inbox_tray:",
                                 @"📨": @":incoming_envelope:",
                                 @"📱": @":iphone:",
                                 @"🏮": @":izakaya_lantern:",
                                 @"👖": @":jeans:",
                                 @"🔑": @":key:",
                                 @"👘": @":kimono:",
                                 @"📒": @":ledger:",
                                 @"🍋": @":lemon:",
                                 @"💄": @":lipstick:",
                                 @"🔒": @":lock:",
                                 @"🔏": @":lock_with_ink_pen:",
                                 @"🍭": @":lollipop:",
                                 @"➿": @":loop:",
                                 @"📢": @":loudspeaker:",
                                 @"🔅": @":low_brightness:",
                                 @"🔍": @":mag:",
                                 @"🔎": @":mag_right:",
                                 @"🀄": @":mahjong:",
                                 @"📫": @":mailbox:",
                                 @"📪": @":mailbox_closed:",
                                 @"📬": @":mailbox_with_mail:",
                                 @"📭": @":mailbox_with_no_mail:",
                                 @"👞": @":mans_shoe:",
                                 @"🍖": @":meat_on_bone:",
                                 @"📣": @":mega:",
                                 @"🍈": @":melon:",
                                 @"📝": @":memo:",
                                 @"🎤": @":microphone:",
                                 @"🔬": @":microscope:",
                                 @"💽": @":minidisc:",
                                 @"💸": @":money_with_wings:",
                                 @"💰": @":moneybag:",
                                 @"🚵": @":mountain_bicyclist:",
                                 @"🎥": @":movie_camera:",
                                 @"🎹": @":musical_keyboard:",
                                 @"🎼": @":musical_score:",
                                 @"🔇": @":mute:",
                                 @"📛": @":name_badge:",
                                 @"👔": @":necktie:",
                                 @"📰": @":newspaper:",
                                 @"🔕": @":no_bell:",
                                 @"📓": @":notebook:",
                                 @"📔": @":notebook_with_decorative_cover:",
                                 @"🔩": @":nut_and_bolt:",
                                 @"🍢": @":oden:",
                                 @"📂": @":open_file_folder:",
                                 @"📙": @":orange_book:",
                                 @"📤": @":outbox_tray:",
                                 @"📄": @":page_facing_up:",
                                 @"📃": @":page_with_curl:",
                                 @"📟": @":pager:",
                                 @"📎": @":paperclip:",
                                 @"🍑": @":peach:",
                                 @"🍐": @":pear:",
                                 @"✏": @":pencil2:",
                                 @"☎": @":phone:",
                                 @"💊": @":pill:",
                                 @"🍍": @":pineapple:",
                                 @"🍕": @":pizza:",
                                 @"📯": @":postal_horn:",
                                 @"📮": @":postbox:",
                                 @"👝": @":pouch:",
                                 @"🍗": @":poultry_leg:",
                                 @"💷": @":pound:",
                                 @"👛": @":purse:",
                                 @"📌": @":pushpin:",
                                 @"📻": @":radio:",
                                 @"🍜": @":ramen:",
                                 @"🎀": @":ribbon:",
                                 @"🍚": @":rice:",
                                 @"🍙": @":rice_ball:",
                                 @"🍘": @":rice_cracker:",
                                 @"💍": @":ring:",
                                 @"🏉": @":rugby_football:",
                                 @"🎽": @":running_shirt_with_sash:",
                                 @"🍶": @":sake:",
                                 @"👡": @":sandal:",
                                 @"📡": @":satellite:",
                                 @"🎷": @":saxophone:",
                                 @"✂": @":scissors:",
                                 @"📜": @":scroll:",
                                 @"💺": @":seat:",
                                 @"🍧": @":shaved_ice:",
                                 @"👕": @":shirt:",
                                 @"🚿": @":shower:",
                                 @"🎿": @":ski:",
                                 @"🚬": @":smoking:",
                                 @"🏂": @":snowboarder:",
                                 @"⚽": @":soccer:",
                                 @"🔉": @":sound:",
                                 @"👾": @":space_invader:",
                                 @"♠": @":spades:",
                                 @"🍝": @":spaghetti:",
                                 @"🔊": @":speaker:",
                                 @"🍲": @":stew:",
                                 @"📏": @":straight_ruler:",
                                 @"🍓": @":strawberry:",
                                 @"🏄": @":surfer:",
                                 @"🍣": @":sushi:",
                                 @"🍠": @":sweet_potato:",
                                 @"🏊": @":swimmer:",
                                 @"💉": @":syringe:",
                                 @"🎉": @":tada:",
                                 @"🎋": @":tanabata_tree:",
                                 @"🍊": @":tangerine:",
                                 @"🍵": @":tea:",
                                 @"📞": @":telephone_receiver:",
                                 @"🔭": @":telescope:",
                                 @"🎾": @":tennis:",
                                 @"🚽": @":toilet:",
                                 @"🍅": @":tomato:",
                                 @"🎩": @":tophat:",
                                 @"📐": @":triangular_ruler:",
                                 @"🏆": @":trophy:",
                                 @"🍹": @":tropical_drink:",
                                 @"🎺": @":trumpet:",
                                 @"📺": @":tv:",
                                 @"🔓": @":unlock:",
                                 @"📼": @":vhs:",
                                 @"📹": @":video_camera:",
                                 @"🎮": @":video_game:",
                                 @"🎻": @":violin:",
                                 @"⌚": @":watch:",
                                 @"🍉": @":watermelon:",
                                 @"🍷": @":wine_glass:",
                                 @"👚": @":womans_clothes:",
                                 @"👒": @":womans_hat:",
                                 @"🔧": @":wrench:",
                                 @"💴": @":yen:",
                                 @"🚡": @":aerial_tramway:",
                                 @"✈": @":airplane:",
                                 @"🚑": @":ambulance:",
                                 @"⚓": @":anchor:",
                                 @"🚛": @":articulated_lorry:",
                                 @"🏧": @":atm:",
                                 @"🏦": @":bank:",
                                 @"💈": @":barber:",
                                 @"🔰": @":beginner:",
                                 @"🚲": @":bike:",
                                 @"🚙": @":blue_car:",
                                 @"⛵": @":boat:",
                                 @"🌉": @":bridge_at_night:",
                                 @"🚅": @":bullettrain_front:",
                                 @"🚄": @":bullettrain_side:",
                                 @"🚌": @":bus:",
                                 @"🚏": @":busstop:",
                                 @"🚗": @":car:",
                                 @"🎠": @":carousel_horse:",
                                 @"🏁": @":checkered_flag:",
                                 @"⛪": @":church:",
                                 @"🎪": @":circus_tent:",
                                 @"🌇": @":city_sunrise:",
                                 @"🌆": @":city_sunset:",
                                 @"🚧": @":construction:",
                                 @"🏪": @":convenience_store:",
                                 @"🎌": @":crossed_flags:",
                                 @"🏬": @":department_store:",
                                 @"🏰": @":european_castle:",
                                 @"🏤": @":european_post_office:",
                                 @"🏭": @":factory:",
                                 @"🎡": @":ferris_wheel:",
                                 @"🚒": @":fire_engine:",
                                 @"⛲": @":fountain:",
                                 @"⛽": @":fuelpump:",
                                 @"🚁": @":helicopter:",
                                 @"🏥": @":hospital:",
                                 @"🏨": @":hotel:",
                                 @"♨": @":hotsprings:",
                                 @"🏠": @":house:",
                                 @"🏡": @":house_with_garden:",
                                 @"🗾": @":japan:",
                                 @"🏯": @":japanese_castle:",
                                 @"🚈": @":light_rail:",
                                 @"🏩": @":love_hotel:",
                                 @"🚐": @":minibus:",
                                 @"🚝": @":monorail:",
                                 @"🗻": @":mount_fuji:",
                                 @"🚠": @":mountain_cableway:",
                                 @"🚞": @":mountain_railway:",
                                 @"🗿": @":moyai:",
                                 @"🏢": @":office:",
                                 @"🚘": @":oncoming_automobile:",
                                 @"🚍": @":oncoming_bus:",
                                 @"🚔": @":oncoming_police_car:",
                                 @"🚖": @":oncoming_taxi:",
                                 @"🎭": @":performing_arts:",
                                 @"🚓": @":police_car:",
                                 @"🏣": @":post_office:",
                                 @"🚃": @":railway_car:",
                                 @"🌈": @":rainbow:",
                                 @"🚀": @":rocket:",
                                 @"🎢": @":roller_coaster:",
                                 @"🚨": @":rotating_light:",
                                 @"📍": @":round_pushpin:",
                                 @"🚣": @":rowboat:",
                                 @"🏫": @":school:",
                                 @"🚢": @":ship:",
                                 @"🎰": @":slot_machine:",
                                 @"🚤": @":speedboat:",
                                 @"🌠": @":stars:",
                                 @"🌃": @":city-night:",
                                 @"🚉": @":station:",
                                 @"🗽": @":statue_of_liberty:",
                                 @"🚂": @":steam_locomotive:",
                                 @"🌅": @":sunrise:",
                                 @"🌄": @":sunrise_over_mountains:",
                                 @"🚟": @":suspension_railway:",
                                 @"🚕": @":taxi:",
                                 @"⛺": @":tent:",
                                 @"🎫": @":ticket:",
                                 @"🗼": @":tokyo_tower:",
                                 @"🚜": @":tractor:",
                                 @"🚥": @":traffic_light:",
                                 @"🚆": @":train2:",
                                 @"🚊": @":tram:",
                                 @"🚩": @":triangular_flag_on_post:",
                                 @"🚎": @":trolleybus:",
                                 @"🚚": @":truck:",
                                 @"🚦": @":vertical_traffic_light:",
                                 @"⚠": @":warning:",
                                 @"💒": @":wedding:",
                                 @"🇯🇵": @":jp:",
                                 @"🇰🇷": @":kr:",
                                 @"🇨🇳": @":cn:",
                                 @"🇺🇸": @":us:",
                                 @"🇫🇷": @":fr:",
                                 @"🇪🇸": @":es:",
                                 @"🇮🇹": @":it:",
                                 @"🇷🇺": @":ru:",
                                 @"🇬🇧": @":gb:",
                                 @"🇩🇪": @":de:",
                                 @"💯": @":100:",
                                 @"🔢": @":1234:",
                                 @"🅰": @":a:",
                                 @"🆎": @":ab:",
                                 @"🔤": @":abc:",
                                 @"🔡": @":abcd:",
                                 @"🉑": @":accept:",
                                 @"♒": @":aquarius:",
                                 @"♈": @":aries:",
                                 @"◀": @":arrow_backward:",
                                 @"⏬": @":arrow_double_down:",
                                 @"⏫": @":arrow_double_up:",
                                 @"⬇": @":arrow_down:",
                                 @"🔽": @":arrow_down_small:",
                                 @"▶": @":arrow_forward:",
                                 @"⤵": @":arrow_heading_down:",
                                 @"⤴": @":arrow_heading_up:",
                                 @"⬅": @":arrow_left:",
                                 @"↙": @":arrow_lower_left:",
                                 @"↘": @":arrow_lower_right:",
                                 @"➡": @":arrow_right:",
                                 @"↪": @":arrow_right_hook:",
                                 @"⬆": @":arrow_up:",
                                 @"↕": @":arrow_up_down:",
                                 @"🔼": @":arrow_up_small:",
                                 @"↖": @":arrow_upper_left:",
                                 @"↗": @":arrow_upper_right:",
                                 @"🔃": @":arrows_clockwise:",
                                 @"🔄": @":arrows_counterclockwise:",
                                 @"🅱": @":b:",
                                 @"🚼": @":baby_symbol:",
                                 @"🛄": @":baggage_claim:",
                                 @"☑": @":ballot_box_with_check:",
                                 @"‼": @":bangbang:",
                                 @"⚫": @":black_circle:",
                                 @"🔲": @":black_square_button:",
                                 @"♋": @":cancer:",
                                 @"🔠": @":capital_abcd:",
                                 @"♑": @":capricorn:",
                                 @"💹": @":chart:",
                                 @"🚸": @":children_crossing:",
                                 @"🎦": @":cinema:",
                                 @"🆑": @":cl:",
                                 @"🕐": @":clock1:",
                                 @"🕙": @":clock10:",
                                 @"🕥": @":clock1030:",
                                 @"🕚": @":clock11:",
                                 @"🕦": @":clock1130:",
                                 @"🕛": @":clock12:",
                                 @"🕧": @":clock1230:",
                                 @"🕜": @":clock130:",
                                 @"🕑": @":clock2:",
                                 @"🕝": @":clock230:",
                                 @"🕒": @":clock3:",
                                 @"🕞": @":clock330:",
                                 @"🕓": @":clock4:",
                                 @"🕟": @":clock430:",
                                 @"🕔": @":clock5:",
                                 @"🕠": @":clock530:",
                                 @"🕕": @":clock6:",
                                 @"🕡": @":clock630:",
                                 @"🕖": @":clock7:",
                                 @"🕢": @":clock730:",
                                 @"🕗": @":clock8:",
                                 @"🕣": @":clock830:",
                                 @"🕘": @":clock9:",
                                 @"🕤": @":clock930:",
                                 @"㊗": @":congratulations:",
                                 @"🆒": @":cool:",
                                 @"©": @":copyright:",
                                 @"➰": @":curly_loop:",
                                 @"💱": @":currency_exchange:",
                                 @"🛃": @":customs:",
                                 @"💠": @":diamond_shape_with_a_dot_inside:",
                                 @"🚯": @":do_not_litter:",
                                 @"8⃣": @":eight:",
                                 @"✴": @":eight_pointed_black_star:",
                                 @"✳": @":eight_spoked_asterisk:",
                                 @"🔚": @":end:",
                                 @"⏩": @":fast_forward:",
                                 @"5⃣": @":five:",
                                 @"4⃣": @":four:",
                                 @"🆓": @":free:",
                                 @"♊": @":gemini:",
                                 @"#⃣": @":hash:",
                                 @"💟": @":heart_decoration:",
                                 @"✔": @":heavy_check_mark:",
                                 @"➗": @":heavy_division_sign:",
                                 @"💲": @":heavy_dollar_sign:",
                                 @"➖": @":heavy_minus_sign:",
                                 @"✖": @":heavy_multiplication_x:",
                                 @"➕": @":heavy_plus_sign:",
                                 @"🆔": @":id:",
                                 @"🉐": @":ideograph_advantage:",
                                 @"ℹ": @":information_source:",
                                 @"⁉": @":interrobang:",
                                 @"🔟": @":keycap_ten:",
                                 @"🈁": @":koko:",
                                 @"🔵": @":large_blue_circle:",
                                 @"🔷": @":large_blue_diamond:",
                                 @"🔶": @":large_orange_diamond:",
                                 @"🛅": @":left_luggage:",
                                 @"↔": @":left_right_arrow:",
                                 @"↩": @":leftwards_arrow_with_hook:",
                                 @"♌": @":leo:",
                                 @"♎": @":libra:",
                                 @"🔗": @":link:",
                                 @"Ⓜ": @":m:",
                                 @"🚹": @":mens:",
                                 @"🚇": @":metro:",
                                 @"📴": @":mobile_phone_off:",
                                 @"❎": @":negative_squared_cross_mark:",
                                 @"🆕": @":new:",
                                 @"🆖": @":ng:",
                                 @"9⃣": @":nine:",
                                 @"🚳": @":no_bicycles:",
                                 @"⛔": @":no_entry:",
                                 @"🚫": @":no_entry_sign:",
                                 @"📵": @":no_mobile_phones:",
                                 @"🚷": @":no_pedestrians:",
                                 @"🚭": @":no_smoking:",
                                 @"🚱": @":non-potable_water:",
                                 @"⭕": @":o:",
                                 @"🅾": @":o2:",
                                 @"🆗": @":ok:",
                                 @"🔛": @":on:",
                                 @"1⃣": @":one:",
                                 @"⛎": @":ophiuchus:",
                                 @"🅿": @":parking:",
                                 @"〽": @":part_alternation_mark:",
                                 @"🛂": @":passport_control:",
                                 @"♓": @":pisces:",
                                 @"🚰": @":potable_water:",
                                 @"🚮": @":put_litter_in_its_place:",
                                 @"🔘": @":radio_button:",
                                 @"♻": @":recycle:",
                                 @"🔴": @":red_circle:",
                                 @"®": @":registered:",
                                 @"🔁": @":repeat:",
                                 @"🔂": @":repeat_one:",
                                 @"🚻": @":restroom:",
                                 @"⏪": @":rewind:",
                                 @"🈂": @":sa:",
                                 @"♐": @":sagittarius:",
                                 @"♏": @":scorpius:",
                                 @"㊙": @":secret:",
                                 @"7⃣": @":seven:",
                                 @"📶": @":signal_strength:",
                                 @"6⃣": @":six:",
                                 @"🔯": @":six_pointed_star:",
                                 @"🔹": @":small_blue_diamond:",
                                 @"🔸": @":small_orange_diamond:",
                                 @"🔺": @":small_red_triangle:",
                                 @"🔻": @":small_red_triangle_down:",
                                 @"🔜": @":soon:",
                                 @"🆘": @":sos:",
                                 @"🔣": @":symbols:",
                                 @"♉": @":taurus:",
                                 @"3⃣": @":three:",
                                 @"™": @":tm:",
                                 @"🔝": @":top:",
                                 @"🔱": @":trident:",
                                 @"🔀": @":twisted_rightwards_arrows:",
                                 @"2⃣": @":two:",
                                 @"🈹": @":u5272:",
                                 @"🈴": @":u5408:",
                                 @"🈺": @":u55b6:",
                                 @"🈯": @":u6307:",
                                 @"🈷": @":u6708:",
                                 @"🈶": @":u6709:",
                                 @"🈵": @":u6e80:",
                                 @"🈚": @":u7121:",
                                 @"🈸": @":u7533:",
                                 @"🈲": @":u7981:",
                                 @"🈳": @":u7a7a:",
                                 @"🔞": @":underage:",
                                 @"🆙": @":up:",
                                 @"📳": @":vibration_mode:",
                                 @"♍": @":virgo:",
                                 @"🆚": @":vs:",
                                 @"〰": @":wavy_dash:",
                                 @"🚾": @":wc:",
                                 @"♿": @":wheelchair:",
                                 @"✅": @":white_check_mark:",
                                 @"⚪": @":white_circle:",
                                 @"💮": @":white_flower:",
                                 @"🔳": @":white_square_button:",
                                 @"🚺": @":womens:",
                                 @"❌": @":x:",
                                 @"0⃣": @":zero:"
                                 };
    
    NSMutableDictionary *reversedMap = [NSMutableDictionary dictionaryWithCapacity:[forwardMap count]];
    [forwardMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            for (NSString *object in obj) {
                [reversedMap setObject:key forKey:object];
            }
        } else {
            [reversedMap setObject:key forKey:obj];
        }
    }];
    
    @synchronized(self) {
        gzw_s_unicodeToCheatCodes = forwardMap;
        gzw_s_cheatCodesToUnicode = [reversedMap copy];
    }
}

- (NSString *)gzw_stringByReplacingEmojiCheatCodesWithUnicode
{
    if (!gzw_s_cheatCodesToUnicode) {
        [NSString gzw_initializeEmojiCheatCodes];
    }
    
    if ([self rangeOfString:@":"].location != NSNotFound) {
        __block NSMutableString *newText = [NSMutableString stringWithString:self];
        [gzw_s_cheatCodesToUnicode enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            [newText replaceOccurrencesOfString:key withString:obj options:NSLiteralSearch range:NSMakeRange(0, newText.length)];
        }];
        return newText;
    }
    
    return self;
}

- (NSString *)gzw_stringByReplacingEmojiUnicodeWithCheatCodes
{
    if (!gzw_s_cheatCodesToUnicode) {
        [NSString gzw_initializeEmojiCheatCodes];
    }
    
    if (self.length) {
        __block NSMutableString *newText = [NSMutableString stringWithString:self];
        [gzw_s_unicodeToCheatCodes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *string = ([obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj);
            [newText replaceOccurrencesOfString:key withString:string options:NSLiteralSearch range:NSMakeRange(0, newText.length)];
        }];
        return newText;
    }
    return self;
}
- (BOOL)gzw_isEmoji {
    
    if ([self gzw_isFuckEmoji]) {
        return YES;
    }
    const unichar high = [self characterAtIndex:0];
    
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
    //
}
-(BOOL)gzw_isFuckEmoji{
    NSArray *fuckArray =@[@"⭐",@"㊙️",@"㊗️",@"⬅️",@"⬆️",@"⬇️",@"⤴️",@"⤵️",@"#️⃣",@"0️⃣",@"1️⃣",@"2️⃣",@"3️⃣",@"4️⃣",@"5️⃣",@"6️⃣",@"7️⃣",@"8️⃣",@"9️⃣",@"〰",@"©®",@"〽️",@"‼️",@"⁉️",@"⭕️",@"⬛️",@"⬜️",@"⭕",@"",@"⬆",@"⬇",@"⬅",@"㊙",@"㊗",@"⭕",@"©®",@"⤴",@"⤵",@"〰",@"†",@"⟹",@"ツ",@"ღ",@"©",@"®"];
    //    NSString *test = @"⭐㊙️㊗️⬅️⬆️⬇️⤴️⤵️#️⃣0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣〰©®〽️‼️⁉️⭕️⬛️⬜️⭕⬆⬇⬅㊙㊗⭕©®⤴⤵〰†⟹ツღ";
    //    NSMutableArray *array = [NSMutableArray array];
    //    for (int i = 0;i < [test length]; i++)
    //    {
    //        [array addObject:[test substringWithRange:NSMakeRange(i,1)]];
    //    }
    BOOL result = NO;
    for(NSString *string in fuckArray){
        if ([self isEqualToString:string]) {
            return YES;
        }
    }
    if ([@"\u2b50\ufe0f" isEqualToString:self]) {
        result = YES;
        
    }
    return result;
}

- (BOOL)gzw_isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring gzw_isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}
- (instancetype)gzw_removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring gzw_isEmoji])? @"": substring];
                          }];
    
    return buffer;
}
- (CGFloat)gzw_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.height);
}
- (CGFloat)gzw_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.width);
}
- (CGSize)gzw_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}
- (CGSize)gzw_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}
+ (NSString *)gzw_reverseString:(NSString *)strSrc
{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [strSrc length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}
- (NSString *)gzw_stringByStrippingHTML {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}
- (NSString *)gzw_stringByRemovingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString gzw_stringByStrippingHTML];
}
- (NSString *)gzw_trimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
- (NSString *)gzw_trimmingWhitespaceAndNewlines
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(NSString *)getMPSize:(unsigned long long int )working
{
    NSString*sizeTypeW = @"bytes";
    
    if(working<1){
        return @"0 KB";
    }else{
        if (working > 1024)
        {
            //Kilobytes
            working = working / 1024;
            
            sizeTypeW = @" KB";
        }
        
        if (working > 1024)
        {
            //Megabytes
            working = working / 1024;
            
            sizeTypeW = @" MB";
        }
        
        if (working > 1024)
        {
            //Gigabytes
            working = working / 1024;
            
            sizeTypeW = @" GB";
        }
        return [NSString stringWithFormat:@"%llu%@", working,sizeTypeW];
    }
}
@end
