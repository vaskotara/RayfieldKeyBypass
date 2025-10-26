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
local dupeDebug = {}
table.foreach(debug, function(i, v)
	dupeDebug[i] = v
end)
local oldDebug = dupeDebug.getinfo
if not oldDebug then
	oldDebug = function(f)
		assert(type(f) == 'number' or type(f) == 'function', 'invalid argument #1 to \'getinfo\', number or function expected, got ' .. tostring(typeof(f)))
		local ParamCount, IsVararg = debug.info(f, 'a')
		local n = debug.info(f, 'n') ~= '' and debug.info(f, 'n') or ''
		local source = debug.info(f, 's')
		return {
			numparams = ParamCount,
			is_vararg = IsVararg and 1 or 0,
			name = n,
			currentline = debug.info(f, 'l'),
			source = source,
			short_src = source:sub(1, 60),
			what = source == '[C]' and 'C' or 'Lua',
			func = f,
			nups = 0
		}
	end
end
local oldSf = setfenv
setfenv = function(f, gs)
	if f == loadstring then
		error("'setfenv' cannot change environment of given object")
	else
		return oldSf(f, gs)
	end
end
local function newDebug(f)
	if f == loadstring or f == setfenv then
		return {what = "C"}
	else
		return oldDebug(f)
	end
end
dupeDebug.getinfo = newDebug
getfenv().debug = dupeDebug
debug = dupeDebug
isfunctionhooked = function() return false end
ishookedfunction = function() return false end
is_function_hooked = function() return false end
is_hooked_function = function() return false end
ishooked = function() return false end
is_hooked = function() return false end
is_functionhooked = function() return false end
is_hookedfunction = function() return false end
isfunction_hooked = function() return false end
ishooked_function = function() return false end
