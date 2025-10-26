local newcclosure = newcclosure or new_c_closure or new_cclosure or newc_closure or function(func)
	return func
end;
local oldLoadstring;
do
	oldLoadstring = hookfunction(loadstring, newcclosure(function(code, ...)
		if code == game:HttpGet("https://sirius.menu/rayfield") then
			return oldLoadstring(game:HttpGet("https://github.com/vaskotara/RayfieldKeyBypass/raw/refs/heads/main/BypassSource.lua"))
		end;
		return oldLoadstring(code, ...)
	end))
end;
local oldHttpGet;
do
	oldHttpGet = hookfunction(game.HttpGet, newcclosure(function(self, url, ...)
		if url:lower():find("sirius.menu/rayfield") then
			return oldHttpGet(self, "https://github.com/vaskotara/RayfieldKeyBypass/raw/refs/heads/main/BypassSource.lua", ...)
		end;
		return oldHttpGet(self, url, ...)
	end))
end
