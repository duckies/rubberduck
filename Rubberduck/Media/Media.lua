local LSM = LibStub:GetLibrary("LibSharedMedia-3.0")

-- Fonts
do
  local path = [[Interface\AddOns\Rubberduck\Media\Fonts\]];

  LSM:Register("font", "Gilroy Bold", path .. "Gilroy-Bold.ttf");
  LSM:Register("font", "Gilroy Medium", path .. "Gilroy-Medium.ttf");
  LSM:Register("font", "Gilroy Regular", path .. "Gilroy-Regular.ttf");

  _G.UNIT_NAME_FONT = LSM:Fetch("font", "Gilroy Medium");
end

-- KMT Statusbars
do
  local path = [[Interface\AddOns\Rubberduck\Media\Textures\Statusbars\KMT\]];

  LSM:Register("statusbar", "KMT01", path .. "KMT01.tga");
  LSM:Register("statusbar", "KMT04", path .. "KMT04.tga");
  LSM:Register("statusbar", "KMT07", path .. "KMT07.tga");
  LSM:Register("statusbar", "KMT12", path .. "KMT12.tga");
  LSM:Register("statusbar", "KMT15", path .. "KMT15.tga");
  LSM:Register("statusbar", "KMT22", path .. "KMT22.tga");
  LSM:Register("statusbar", "KMT25", path .. "KMT25.tga");
  LSM:Register("statusbar", "KMT27", path .. "KMT27.tga");
  LSM:Register("statusbar", "KMT28", path .. "KMT28.tga");
  LSM:Register("statusbar", "KMT30", path .. "KMT30.tga");
  LSM:Register("statusbar", "KMT31", path .. "KMT31.tga");
  LSM:Register("statusbar", "KMT31 Border", path .. "KMT31-Border.tga");
  LSM:Register("statusbar", "KMT31 Checkered", path .. "KMT31_checkered.tga");
  LSM:Register("statusbar", "KMT32", path .. "KMT32.tga");
  LSM:Register("statusbar", "KMT38", path .. "KMT38.tga");
  LSM:Register("statusbar", "KMT40", path .. "KMT40.tga");
  LSM:Register("statusbar", "KMT41", path .. "KMT41.tga");
  LSM:Register("statusbar", "KMT43", path .. "KMT43.tga");
  LSM:Register("statusbar", "KMT44", path .. "KMT44.tga");
  LSM:Register("statusbar", "KMT44 Checkered", path .. "KMT44_checkered.tga");
  LSM:Register("statusbar", "KMT44 Dark", path .. "KMT44_dark.tga");
  LSM:Register("statusbar", "KMT44 Striped", path .. "KMT44_striped.tga");
  LSM:Register("statusbar", "KMT45", path .. "KMT45.tga");
  LSM:Register("statusbar", "KMT47", path .. "KMT47.tga");
  LSM:Register("statusbar", "KMT48", path .. "KMT48.tga");
  LSM:Register("statusbar", "KMT48 Dark", path .. "KMT48_dark.tga");
  LSM:Register("statusbar", "KMT48 Striped", path .. "KMT48_striped.tga");
  LSM:Register("statusbar", "KMT49", path .. "KMT49.tga");
  LSM:Register("statusbar", "KMT51", path .. "KMT51.tga");
  LSM:Register("statusbar", "KMT52", path .. "KMT52.tga");
  LSM:Register("statusbar", "KMT53", path .. "KMT53.tga");
  LSM:Register("statusbar", "KMT54", path .. "KMT54.tga");
  LSM:Register("statusbar", "KMT55", path .. "KMT55.tga");
  LSM:Register("statusbar", "KMT56", path .. "KMT56.tga");
  LSM:Register("statusbar", "KMT57", path .. "KMT57.tga");
  LSM:Register("statusbar", "KMT58", path .. "KMT58.tga");
  LSM:Register("statusbar", "KMT61", path .. "KMT61.tga");
  LSM:Register("statusbar", "KMT62", path .. "KMT62.tga");
  LSM:Register("statusbar", "KMT63", path .. "KMT63.tga");
  LSM:Register("statusbar", "KMT64", path .. "KMT64.tga");
  LSM:Register("statusbar", "KMT65", path .. "KMT65.tga");
  LSM:Register("statusbar", "KMT65 Dark", path .. "KMT65_dark.tga");
  LSM:Register("statusbar", "KMT65 Striped", path .. "KMT65_striped.tga");
  LSM:Register("statusbar", "KMT67", path .. "KMT67.tga");
end

-- MaUI Statusbars
do
  local path = [[Interface\AddOns\Rubberduck\Media\Textures\Statusbars\MaUI\]];

  LSM:Register("statusbar", "MaUI1", path .. "MaUI1.tga");
  LSM:Register("statusbar", "MaUI2", path .. "MaUI2.tga");
  LSM:Register("statusbar", "MaUI3", path .. "MaUI3.tga");
  LSM:Register("statusbar", "MaUI4", path .. "MaUI4.tga");
  LSM:Register("statusbar", "MaUI4.1", path .. "MaUI4.1.tga");
  LSM:Register("statusbar", "MaUI5", path .. "MaUI5.tga");
  LSM:Register("statusbar", "MaUI6", path .. "MaUI6.tga");
  LSM:Register("statusbar", "MaUI7", path .. "MaUI7.tga");
  LSM:Register("statusbar", "MaUI8", path .. "MaUI8.tga");
  LSM:Register("statusbar", "MaUI9", path .. "MaUI9.tga");
  LSM:Register("statusbar", "MaUI10", path .. "MaUI10.tga");
  LSM:Register("statusbar", "MaUI11", path .. "MaUI11.tga");
  LSM:Register("statusbar", "MaUI12", path .. "MaUI12.tga");
  LSM:Register("statusbar", "MaUI13", path .. "MaUI13.tga");
  LSM:Register("statusbar", "MaUI14", path .. "MaUI14.tga");
end

-- Melli Statusbars
do
  local path = [[Interface\AddOns\Rubberduck\Media\Textures\Statusbars\Melli\]];

  LSM:Register("statusbar", "Melli", path .. "Melli.tga");
  LSM:Register("statusbar", "Melli Dark", path .. "MelliDark.tga");
end
