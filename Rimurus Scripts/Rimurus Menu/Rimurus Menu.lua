require("Rimuru\\Dependancies\\keyHook")

if loadedVer then 
	menu.notify(""..os.getenv("USERNAME").." dont be a dummy", "Rimuru's Menu is already loaded", 5, 200) 
	return
end
loadedVer = "1.0"

if(not menu.is_trusted_mode_enabled()) then
	menu.notify(""..os.getenv("USERNAME").." dont be a dummy", "Trusted mode is disabled", 5, 200) 
    return
end

LuaUI.Options.menuPos.x = 0.5
LuaUI.Options.menuPos.y = 0.4
LuaUI.Options.menuWH.x = 0.2
LuaUI.Options.menuWH.y = 0

LuaUI.Options.currentMenu = LuaUI.Options.menus[1]

loaded()
LoadFaves()

local function scrollBar(x, y)
    LuaUI.drawRect(x, y, LuaUI.Options.menuWH.x - 0.005, 0.02, customColour)
end

function UI()
    LuaUI.drawOutline(
        "Rimurus Menu 1.0",
        0.5,
        LuaUI.Options.menuPos.x,
        LuaUI.Options.menuPos.y,
        LuaUI.Options.menuWH.x,
        LuaUI.Options.menuWH.y + 0.06 + (0.042 * LuaUI.Options.maxScroll),
        customColour,
        Colour.black,
        true,
        true
    )
    if toggles.banner_t then
        LuaUI.drawBanner(LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y - 0.05, customColour) --1521x485
    end
    scrollBar(LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.05 + (0.34 * LuaUI.Options.scroll / 10))

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[1]) then
        LuaUI.Options.maxScroll = 4
        LuaUI.drawSubmenu("Local Options", 0, sliders.fontSliderValue)
        LuaUI.drawSubmenu("Vehicle Options", 1, sliders.fontSliderValue)
        LuaUI.drawSubmenu("Spawner", 2, sliders.fontSliderValue)
        LuaUI.drawSubmenu("Online", 3, sliders.fontSliderValue)
        LuaUI.drawSubmenu("Settings", 4, sliders.fontSliderValue)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[2]) then
        LuaUI.Options.maxScroll = 3
        LuaUI.drawStringSlider("Gun Types", 0, gunTypes, sliders.gunSliderValue, sliders.fontSliderValue)
        LuaUI.drawOptionToggle("Black Parade", 1, toggles.blackParade_t, sliders.fontSliderValue)
        LuaUI.drawOptionToggle("Block Admin Spectate", 2, toggles.AdminSpec_t, sliders.fontSliderValue)
        LuaUI.drawOption("Give Wings", 3, sliders.fontSliderValue)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[3]) then
        LuaUI.Options.maxScroll = 4
        LuaUI.drawOption("Gta4 Style Neons", 0, sliders.fontSliderValue)
        LuaUI.drawOption("Remove Neons", 1, sliders.fontSliderValue)
        LuaUI.drawOption("Teleport Personal Vehicle", 2, sliders.fontSliderValue)
        LuaUI.drawSubmenu("Garage Vehicles", 3, sliders.fontSliderValue)
        LuaUI.drawSubmenu("Ini Vehicles", 4, sliders.fontSliderValue)
        --LuaUI.drawOption("Save Vehicle", 4)
        --LuaUI.drawStringSlider("Load Vehicle", 5, gunTypes, 1)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[4]) then
        LuaUI.Options.maxScroll = 5
        LuaUI.drawStringSlider("SpawnPed", 0, pedList, sliders.pedSliderValue, sliders.fontSliderValue)
        LuaUI.drawStringSlider("SpawnAnimal", 1, pedList, 1, sliders.fontSliderValue)
        LuaUI.drawStringSlider("SpawnObject", 2, Objs, sliders.objectSliderValue, sliders.fontSliderValue)
        LuaUI.drawStringSlider("SpawnWorld", 3, Objs, sliders.worldSliderValue, sliders.fontSliderValue)
        LuaUI.drawStringSlider("SpawnProp", 4, Objs, sliders.propSliderValue, sliders.fontSliderValue)
        LuaUI.drawOption("SpawnObjectByName", 5, sliders.fontSliderValue)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[5]) then
        for i = 0, 10 do
            playerInfo.names = player.get_player_name(i)
            if (playerInfo.names == nil) then
                LuaUI.drawOption("nil", i, sliders.fontSliderValue)
            else
                LuaUI.Options.maxScroll = i+1
                LuaUI.drawSubmenu(playerInfo.names, i)
                LuaUI.drawOption("Next Page", 11, sliders.fontSliderValue)
            end
        end
    end
    
    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
        LuaUI.Options.maxScroll = 6
        LuaUI.drawIntSlider("Colour Red", 0, channels.redChannel, sliders.fontSliderValue)
        LuaUI.drawIntSlider("Colour Green", 1, channels.greenChannel, sliders.fontSliderValue)
        LuaUI.drawIntSlider("Colour Blue", 2, channels.blueChannel, sliders.fontSliderValue)
        LuaUI.drawOptionToggle("Toggle Banner", 3, toggles.banner_t, sliders.fontSliderValue)
        LuaUI.drawIntSlider("Font", 4, sliders.fontSliderValue, sliders.fontSliderValue)
        LuaUI.drawFloatSlider("Menu X", 5, LuaUI.Options.menuPos.x, sliders.fontSliderValue)
        LuaUI.drawFloatSlider("Menu Y", 6, LuaUI.Options.menuPos.y, sliders.fontSliderValue)
        --LuaUI.drawStringSlider("Banners:", 4, bannerList, sliders.bannerSliderValue)
        --LuaUI.drawOption("Save UI", 5)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[7]) then
        LuaUI.Options.maxScroll = 0
        LuaUI.drawOption("Spawn Random Object", 0, sliders.fontSliderValue)
    end
    
    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[8]) then
        for k,v in pairs(garageSlots) do
            LuaUI.Options.maxScroll = k-1
            if(not v[2]) then
                LuaUI.drawOption("nil", k-1, sliders.fontSliderValue)
            else
                LuaUI.drawOption(v[2], k-1, sliders.fontSliderValue)
            end
        end
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[9]) then
        for i = 10, 20 do
            playerInfo.names = player.get_player_name(i)
            if (playerInfo.names == nil) then
                LuaUI.drawOption("nil", i, sliders.fontSliderValue)
            else
                LuaUI.Options.maxScroll = i+1
                LuaUI.drawSubmenu(playerInfo.names, i, sliders.fontSliderValue)
                LuaUI.drawOption("Next Page", 11, sliders.fontSliderValue)
            end
        end
    end
    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[10]) then
        for i = 20, 30 do
            playerInfo.names = player.get_player_name(i)
            if (playerInfo.names == nil) then
                LuaUI.drawOption("nil", i-10)
            else
                LuaUI.Options.maxScroll = i+1
                LuaUI.drawSubmenu(playerInfo.names, i, sliders.fontSliderValue)
                LuaUI.drawOption("Next Page", 11, sliders.fontSliderValue)
            end
        end
    end
    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[11]) then
        for i=1, #IniVehicle do
            LuaUI.Options.maxScroll = i-1
            LuaUI.drawOption(IniVehicle[i], i-1, sliders.fontSliderValue)
        end
    end
end

local menuTog = false
menu.add_feature(
    "Rimurus Menu",
    "toggle",
    0,
    function(tog)

        while tog do
            if (controls.is_control_pressed(2, 166)) then --f5
                menuTog = not menuTog
            end

            if menuTog then
                UI()
                keyHook()
            end
            
            functions()
            system.wait(0)
        end
end)
