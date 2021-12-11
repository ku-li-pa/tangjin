require "import"
initApp=true
import "Jesse205"
import "agreements"
import "com.google.android.material.chip.*"
import "com.google.android.material.chipGroup.*"
import "com.google.android.material.appbar.CollapsingToolbarLayout"
import "com.google.android.material.appbar.AppBarLayout"
import "androidx.appcompat.widget.Toolbar"
import "android.widget.*"
import "androidx.appcompat.widget.Toolbar"
import "androidx.recyclerview.widget.RecyclerView"
import "androidx.recyclerview.widget.LinearLayoutManager"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.appbar.CollapsingToolbarLayout"
import "com.google.android.material.appbar.AppBarLayout"
import "com.google.android.material.chip.*"
import "androidx.core.widget.NestedScrollView"
import "AppFunctions"






import "android.net.Uri"
import "android.content.ComponentName"
import "android.content.Intent"
import "android.content.pm.ShortcutInfo"
import "java.util.ArrayList"
import "android.graphics.drawable.Icon"



if Build.VERSION.SDK_INT >= 25 then

  --创建Intent对象
  intent1 = Intent(Intent.ACTION_MAIN);
  --ComponentName设置应用之间跳转      包名(这里直接获取程序包名),   包名+类名(AndroLua打包后还是这个)
  intent1.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent1.setData(Uri.parse("num1"));
  --intent1.setData(Uri.parse('tel://10086'));
  --当快捷方式创建完成之后,点击图标跳转到拨打拨打电话的页面
  --既可以不需要在onNewIntent回调设置点击事件

  intent2 = Intent(Intent.ACTION_MAIN);
  intent2.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent2.setData(Uri.parse("num2"));

  intent3 = Intent(Intent.ACTION_MAIN);
  intent3.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent3.setData(Uri.parse("num3"));

  intent4 = Intent(Intent.ACTION_MAIN);
  intent4.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent4.setData(Uri.parse("num4"));

  --id,快捷方式名字,快捷方式被点击后执行的intent,快捷方式的图标地址
  SHORTCUT_TABLE={
    {"ID1","文件",intent1,activity.getLuaDir().."/imgs/file.png"},
    {"ID2","文件夹",intent2,activity.getLuaDir().."/imgs/folder.png"},
    {"ID3","播放",intent3,activity.getLuaDir().."/imgs/play.png"},
    {"ID4","搜索",intent4,activity.getLuaDir().."/imgs/magnify.png"},
  }

  --动态的Shortcut,获取ShortcutManager,快捷方式管理器
  --提供了添加,移除,更新,禁用,启动,获取静态快捷方式,获取动态快捷方式,获取固定在桌面的快捷方式等方法
  scm = activity.getSystemService(activity.SHORTCUT_SERVICE);

  --循环添加到对象ArrayList
  infos = ArrayList();
  for k,v in pairs(SHORTCUT_TABLE) do
    si = ShortcutInfo.Builder(this,v[1])
    --设置图标
    .setIcon(Icon.createWithBitmap(loadbitmap(v[4])))
    --快捷方式添加到桌面显示的标签文本
    .setShortLabel(v[2])
    --长按图标快捷方式显示的标签文本(既快捷方式名字)
    .setLongLabel(v[2])
    .setIntent(v[3])
    .build();
    infos.add(si);
  end

  --添加快捷方式
  scm.setDynamicShortcuts(infos);

  --移除快捷方式
  --scm.removeDynamicShortcuts(infos);

  --print("快捷方式已创建,不信去长按图标")

  --Intent回调设置点击事件
  function onNewIntent(intent)

    --获得传递过来的数据并转化为字符串
    local uriString = tostring(intent.getData())

    --给每个Intent项目对应Data赋予点击事件
    if "num1"==uriString then
      --跳转至指定页面
      activity.newActivity("activitys/activity_1")

     elseif "num2"==uriString then
      activity.newActivity("activitys/activity_2")

     elseif "num3"==uriString then
      activity.newActivity("activitys/activity_3")

     elseif "num4"==uriString then
      activity.newActivity("activitys/activity_4")

    end
  end
end









oldTheme=ThemeUtil.getAppTheme()
oldDarkActionBar=getSharedData("theme_darkactionbar")

lastBackTime=0

function dp2px(n)
  return n*activity.resources.displayMetrics.scaledDensity+.5
end

activity.setTitle(R.string.app_name)
activity.setContentView(loadlayout("layout"))

actionBar=activity.getSupportActionBar()

actionBar.setTitle("塘锦.")
--actionBar.setDisplayHomeAsUpEnabled(true)
actionBar.setElevation(0)




--appBar.targetElevation=0--取消AppBarLayout阴影

tab={"刻度尺","画板","水平仪","量角器","翻译","网页获源","短网址生成","简易画板","打字板","LED滚动字幕","时间屏幕","垃圾分类查询","亲戚称呼计算","随机一文","历史上的今天"}
for k,v in pairs(tab) do
  a=
  {
      Chip;
      textColor="0xFF000000";
           layout_width="wrap";
      gravity="center";
      layout_height="wrap";
      Text=v;
      onClick=function(p)
      switch v
        case "刻度尺"
         newSubActivity("Ruler")
         case "画板"
         newSubActivity("Canvas")
         end
        end;
    };
 


  f1.addView(loadlayout(a))

end





      







function onCreateOptionsMenu(menu)
  local inflater=activity.getMenuInflater()
  inflater.inflate(R.menu.menu_main,menu)
end

function onOptionsItemSelected(item)
  local id=item.getItemId()
  local Rid=R.id
  local aRid=android.R.id
  if id==aRid.home then
    activity.finish()
   elseif id==Rid.menu_more_settings then--设置
    newSubActivity("Settings")
   elseif id==Rid.menu_more_about then--关于
    newSubActivity("About")
  end
end

function onResume()
  if oldTheme~=ThemeUtil.getAppTheme()
    or oldDarkActionBar~=getSharedData("theme_darkactionbar")
    then
    local aRanim=android.R.anim
    newActivity("main",aRanim.fade_in,aRanim.fade_out)
    activity.finish()
    return
  end
end

function onKeyDown(KeyCode,event)
  TouchingKey=true
end

function onKeyUp(KeyCode,event)
  if TouchingKey then
    TouchingKey=false
    if KeyCode==KeyEvent.KEYCODE_BACK then
      if (System.currentTimeMillis()-lastBackTime)> 2000 then
        MyToast(R.string.exit_toast)
        lastBackTime=System.currentTimeMillis()
        return true
      end
    end
  end
end

function onConfigurationChanged(config)
  screenConfigDecoder:decodeConfiguration(config)
end


screenConfigDecoder=ScreenFixUtil.ScreenConfigDecoder({
  
})

onConfigurationChanged(activity.getResources().getConfiguration())
