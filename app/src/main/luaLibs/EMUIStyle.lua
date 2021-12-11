pcall(function()androidhwext={R=luajava.bindClass("androidhwext.R")} end)
--使用方法：
--[[
import "EMUIStyle"
if androidhwext then
  activity.setTheme(androidhwext.R.style.Theme_Emui)
end
]]
