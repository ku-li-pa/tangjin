require "import"
import "android.widget.*"
import "android.view.*"


layout={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",
  gravity="center",
  {
    Button,
    text="文件界面",
  },
}
activity.setContentView(loadlayout(layout))