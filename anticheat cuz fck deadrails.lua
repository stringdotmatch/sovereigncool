-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-04-22 03:17:00
-- Luau version 6, Types version 3
-- Time taken: 0.001699 seconds

local bit32 = bit32
if not bit32 then
	bit32 = bit
end
local bxor_upvr = bit32.bxor
local sub_upvr = string.sub
local byte_upvr = string.byte
local char_upvr = string.char
local insert_upvr = table.insert
local concat_upvr = table.concat
local function v7_upvr(arg1, arg2)
	local module = {}
	for i = 1, #arg1 do
		insert_upvr(module, char_upvr(bxor_upvr(byte_upvr(sub_upvr(arg1, i, i + 1)), byte_upvr(sub_upvr(arg2, 1 + i % #arg2, 1 + i % #arg2 + 1))) % 256))
	end
	return concat_upvr(module)
end
local tbl_upvr = {
    "Orion Library";
    "?";
    "Check docs.sirius.menu for help with Rayfield";
    "Rayfield | Not seeing your actions in notification specific development.";-- idkwhyitslikethis
    "Executor : Krnl";
    "Executor : Delta";
    "Executor : Xeno";
    "Executor : Codex";
    "Executor : JJSploit x Xeno";
    "Executor : Arceus X";
    "Executor : Fluxus";
    "Executor : VegaX";
    "Executor : AppleWare";
}

local service_upvr = game:GetService("ReplicatedStorage")
local v7_upvr_result1_upvr = "FireBondsSound"

--half of it got cut off, but it checks all the table values. shit idfk
