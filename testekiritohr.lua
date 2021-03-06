while(true) do
if gg.isVisible(true) then
menuk = 1
gg.setVisible(false)
end

--[LIB]
  local memFrom, memTo, lib, num, lim, results, src, ok = 0, -1, nil, 0, 32, {}, nil, false
  function name(n)
    if lib ~= n then
      lib = n
      local ranges = _ENV.gg.getRangesList(lib)
      if #ranges == 0 then
        _ENV.print("⚠ERROR: " .. lib .. " are not found!⚠")
        _ENV.gg.toast("⚠ERROR: " .. lib .. " are not found!⚠")
        _ENV.os.exit()
      else
        memFrom = ranges[1].start
        memTo = ranges[#ranges]["end"]
      end
    end
  end
  function hex2tbl(hex)
    local ret = {}
    hex:gsub("%S%S", function(ch)
      ret[#ret + 1] = ch
      return ""
    end)
    return ret
  end
  function original(orig)
    local tbl = hex2tbl(orig)
    local len = #tbl
    if len == 0 then
      return
    end
    local used = len
    if len > lim then
      used = lim
    end
    local s = ""
    for i = 1, used do
      if i ~= 1 then
        s = s .. ";"
      end
      local v = tbl[i]
      if v == "??" or v == "**" then
        v = "0~~0"
      end
      s = s .. v .. "r"
    end
    s = s .. "::" .. used
    gg.searchNumber(s, gg.TYPE_BYTE, false, gg.SIGN_EQUAL, memFrom, memTo)
    if len > used then
      for i = used + 1, len do
        local v = tbl[i]
        if v == "??" or v == "**" then
          v = 256
        else
          v = ("0x" .. v) + 0
          if v > 127 then
            v = v - 256
          end
        end
        tbl[i] = v
      end
    end
    local found = gg.getResultCount()
    results = {}
    local count = 0
    local checked = 0
    while not (found <= checked) do
      local all = gg.getResults(8)
      local total = #all
      local start = checked
      if not (total < checked + used) then
        for i, v in ipairs(all) do
          v.address = v.address + myoffset
        end
        gg.loadResults(all)
        while total > start do
          local good = true
          local offset = all[1 + start].address - 1
          if len > used then
            local get = {}
            for i = lim + 1, len do
              get[i - lim] = {
                address = offset + i,
                flags = gg.TYPE_BYTE,
                value = 0
              }
            end
            get = gg.getValues(get)
            for i = lim + 1, len do
              local ch = tbl[i]
              if ch ~= 256 and get[i - lim].value ~= ch then
                good = false
                break
              end
            end
          end
          if good then
            count = count + 1
            results[count] = offset
            checked = checked + used
          else
            local del = {}
            for i = 1, used do
              del[i] = all[i + start]
            end
            gg.removeResults(del)
          end
          start = start + used
        end
      end
    end
  end
  function replaced(repl)
    num = num + 1
    local tbl = _ENV.hex2tbl(repl)
    if src ~= nil then
      local source = _ENV.hex2tbl(src)
      for i, v in _ENV.ipairs(tbl) do
        if v ~= "??" and v ~= "**" and v == source[i] then
          tbl[i] = "**"
        end
      end
      src = nil
    end
    local cnt = #tbl
    local set = {}
    local s = 0
    for _, addr in _ENV.ipairs(results) do
      for i, v in _ENV.ipairs(tbl) do
        if v ~= "??" and v ~= "**" then
          s = s + 1
          set[s] = {
            address = addr + i,
            value = v .. "r",
            flags = _ENV.gg.TYPE_BYTE
          }
        end
      end
    end
    if s ~= 0 then
      _ENV.gg.setValues(set)
    end
    ok = true
  end
  if ok then
    gg.toast("ACTIVE")
  end
  
START = 1

      function START()
        local menu = gg.choice({
          "🌐FIX CLOSED MENU",
          "🌐ANTENA MENU",
          "🌐PERFIL HACK MENU",
          "🌐SHOTS MENU",
          "🌐GHOST MODE MENU",
          "🌐FAST MODE MENU",
          "🌐CONFIG. GAME MENU",
          "🌐LIFE MENU",
          "🌐WALL MENU",
          "🌐PARAQUEDAS MENU",
          "                                    ❎SAIR❎"
        }, nil, "√ȋק  HR GAMES OFICIAL")
        if menu == 1 then
          fixclose()
        end
        if menu == 2 then
          ANTENA()
        end
        if menu == 3 then
          perfil()
        end
        if menu == 4 then
          arma()
        end
        if menu == 5 then
          ghostmod()
        end
        if menu == 6 then
          speed()
        end
        if menu == 7 then
          maphack1()
        end
        if menu == 8 then
          mekit()
        end
        if menu == 9 then
          wall()
        end
        if menu == 10 then
          parak()
        end
        if menu == 12 then
          sair()
        end
        if menu == nil then
          noselect()
        end
        menuk = -1
      end
      function fixclose()
        local menu1 = gg.multiChoice({
          "🌐FIX CLOSE📵",
          "🌐NO FORCE CLOSED✔",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu1 == nil then
          noselect()
        elseif menu1[1] then
            bypassff()
          end
          if menu1[2] then
            bypassff2()
          end
        menuk = -1
      end
      function bypassff()
        gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_C_BSS | gg.REGION_ANONYMOUS | gg.REGION_CODE_APP | gg.REGION_C_DATA)
        gg.searchNumber("0~~0 ", gg.TYPE_AUTO, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("FIX CLOSE ACTIVE")
      end
      function bypassff2()
        function baixar(arquivo)
          local url = "http://patolinobr.hostingerapp.com/domains/patolinobrhostingerappcom/public_html/VIP/" .. arquivo
          local e_txt = gg.makeRequest(url).content
          if e_txt == nil or e_txt == "" then
          else
            io.open(gg.EXT_STORAGE .. "/" .. arquivo, "w"):write(e_txt)
          end
        gg.loadList(gg.EXT_STORAGE .. "/bypass.txt", 0)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.clearResults()
        gg.removeListItems(t)
        gg.loadList(gg.EXT_STORAGE .. "/bypass.txt", 0)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.clearResults()
        gg.removeListItems(t)
        gg.toast("NO FORCE CLOSED ACTIVE")
      end
      function ANTENA()
        antena1mq = 1
        while true do
          if gg.isVisible(true) then
            antena1mq = 1
            gg.setVisible(false)
          end
          if antena1mq == 1 then
            ANTENA1()
          end
        end
      end
      function ANTENA1()
        local menu1 = gg.multiChoice({
          "🌐ANTENA BETA💂",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu1 == nil then
          noselect()
        elseif menu1[1] then
          antenamenud()
        end
        antena1mq = -1
      end
      function at1()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.8607~0.8624", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("0.8607~0.8624", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(10000)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "300"
        end
        gg.setValues(r)
        gg.clearResults()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.8628~0.86299", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("0.8628~0.86299", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(10000)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "300"
        end
        gg.setValues(r)
        gg.clearResults()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.874~0.8745", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("0.874~0.8745", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(10000)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "300"
        end
        gg.setValues(r)
        gg.clearResults()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.8746~0.8747", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("0.8746~0.8747", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(10000)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "300"
        end
        gg.setValues(r)
        gg.clearResults()
        gg.toast("ANTENA HEAD ACTIVE")
      end
      function antenamenud()
        antenabetak = 1
        while true do
          if gg.isVisible(true) then
            antenabetak = 1
            gg.setVisible(false)
          end
          if antenabetak == 1 then
            antenabeta()
          end
        end
      end
      function antenabeta()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR💂",
          "◀️VOLTA◀️"
        }, {
          [1] = atq
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ANTENA1()
        elseif menu[1] == true then
          antenaon()
        else
          antenaoff()
        end
        antenabetak = -1
      end
      function antenaon()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libunity.so")
        myoffset = antenalib
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(1)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "300"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("ANTENA BETA ACTIVE")
        atq = true
      end
      function antenaoff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libunity.so")
        myoffset = antenalib
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(1)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("ANTENA BETA ACTIVE")
        atq = false
      end
      function ghostmod()
        ghosthk = 1
        while true do
          if gg.isVisible(true) then
            ghosthk = 1
            gg.setVisible(false)
          end
          if ghosthk == 1 then
            ghosthk0()
          end
        end
      end
      function ghosthk0()
        local menu2 = gg.multiChoice({
          "🌐GHOST HACKER PRO👻",
          "🌐WHITE BOBY(LOBBY)👴",
          "🌐WHITE BOBY(IN GAME)👴",
          "🌐BLACK BOBY(IN GAME)🕴",
          "🌐ALL FEMALE(LOBBY)👩",
          "🌐ALL MALE(LOBBY)👨",
          "🌐UNDERGROUND TATÚ🦂",
          "🌐UNDERGROUND BELOW🏞",
          "🌐UNDERGROUND CAR🚘",
          "🌐IsDead☠",
          "◀️VOLTA◀️"
        }, nil, "ℹSer invisível é fácilℹ")
        if menu2 == nil then
          noselect()
        end
        if menu2[10] == true then
          Dead()
        end
        if menu2[9] == true then
          undergroundcar()
        end
        if menu2[8] == true then
          underground2()
        end
        if menu2[7] == true then
          underground()
        end
        if menu2[6] == true then
          male()
        end
        if menu2[5] == true then
          female()
        end
        if menu2[4] == true then
          backm()
        end
        if menu2[3] == true then
          white1()
        end
        if menu2[2] == true then
          whitebody0()
        end
        if menu2[1] == true then
          ghosthk1()
        end
        ghosthk = -1
      end
      function ghosthk1()
        ghosthk = 1
        while true do
          if gg.isVisible(true) then
            ghosthk = 1
            gg.setVisible(false)
          end
          if ghosthk == 1 then
            ghosthk10()
          end
        end
      end
      function ghosthk10()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR👻",
          "◀️VOLTA◀️"
        }, {
          [1] = xx
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ghostmod()
        elseif menu[1] == true then
          ghoston()
        else
          ghostoff()
        end
        ghosthk = -1
      end
      function ghoston()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = ghostl
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("GHOST ACTIVE")
        xx = true
      end
      function ghostoff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = ghostl
        original("7F 45 4C 46 01 01 01 00")
        all = gg.getResults(8)
        for i, v in ipairs(all) do
          v.address = v.address + ghostl
        end
        gg.loadResults(t)
        local r = gg.getResults(2)
        r[1].value = "-1.3094071e25"
        r[4].value = "-1.3068388e21"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("GHOST DISACTIVE")
        xx = false
      end
      function whitebody0()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR👴",
          "◀️VOLTA◀️"
        }, {
          [1] = wh
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ghostmod()
        elseif menu[1] == true then
          CorposBrancoON()
        else
          CorposBrancoOFF()
        end
        menuk = -1
      end
      function CorposBrancoON()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = UseHighQualityAvatar
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = White2
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 BB E3")
        gg.clearResults()
        gg.toast("WHITE BOBY ACTIVE")
        wh = false
      end
      function CorposBrancoOFF()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = UseHighQualityAvatar
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1.3094071e25"
        r[4].flags = gg.TYPE_FLOAT
        r[4].value = "-1.3068388e21"
        gg.setValues(r)
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = White2
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 BB E3")
        gg.clearResults()
        gg.toast("WHITE BOBY DISACTIVE")
        wh = true
      end
      function white1()
        gg.setRanges(gg.REGION_C_ALLOC)
        gg.searchNumber("00r;00r;80r;40r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r::20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;80r;40r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r::20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;80r;40r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r::20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;80r;40r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r::20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;80r;40r::4", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;80r;40r::4", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(100000)
        gg.editAll("00r;00r;C6r;42r", gg.TYPE_BYTE)
        gg.clearResults()
        gg.toast("WHITE BOBY IN GAME ACTIVE")
      end
      function backm()
        gg.setRanges(gg.REGION_C_ALLOC)
        gg.searchNumber("4", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("4", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("4", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("4", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("4", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("4", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "-1000"
        end
        gg.setValues(r)
        gg.clearResults()
      end
      function female()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR👧",
          "◀️VOLTA◀️"
        }, {
          [1] = fe
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ghostmod()
        elseif menu[1] == true then
          AllFemininoON()
        else
          AllFemininoOFF()
        end
      end
      function AllFemininoON()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_IsFemale
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("ALL FEMALE ACTIVE")
        fe = true
      end
      function AllFemininoOFF()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_IsFemale
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1.2278593e23"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("ALL FEMALE DISACTIVE")
        fe = false
      end
      function male()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR👦",
          "◀️VOLTA◀️"
        }, {
          [1] = ma
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ghostmod()
        elseif menu[1] == true then
          AllMasculinoON()
        else
          AllMasculinoOFF()
        end
        menuk = -1
      end
      function AllMasculinoON()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_IsFemale
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("ALL MALE ACTIVE")
        ma = true
      end
      function AllMasculinoOFF()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_IsFemale
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1.2278593e23"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("ALL MALE DISACTIVE")
        ma = false
      end
      function underground()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🦂",
          "◀️VOLTA◀️"
        }, {
          [1] = un
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ghostmod()
        elseif menu[1] == true then
          undergroundon()
        else
          undergroundoff()
        end
        menuk = -1
      end
      function undergroundon()
        gg.setRanges(gg.REGION_C_ALLOC)
        gg.searchNumber("14r;AEr;07r;3Fr;00r;00r;00r;00r::8", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("14r;AEr;07r;3Fr;00r;00r;00r;00r::8", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("14r;AEr;07r;3Fr;00r;00r;00r;00r::8", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("14r;AEr;07r;3Fr::4", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("14r;AEr;07r;3Fr::4", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(160)
        gg.editAll("9Ar;99r;99r;3Fr", gg.TYPE_BYTE)
        gg.clearResults()
        gg.toast("UNDERGROUND TATÚ ACTIVE ")
        un = true
      end
      function undergroundoff()
        gg.setRanges(gg.REGION_C_ALLOC)
        gg.searchNumber("9Ar;99r;99r;3Fr;00r;00r;00r;00r::8", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("9Ar;99r;99r;3Fr;00r;00r;00r;00r::8", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("9Ar;99r;99r;3Fr;00r;00r;00r;00r::8", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("9Ar;99r;99r;3Fr::4", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("9Ar;99r;99r;3Fr::4", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(160)
        gg.editAll("14r;AEr;07r;3Fr", gg.TYPE_BYTE)
        gg.clearResults()
        gg.toast("UNDERGROUND TATÚ IMMORTAL DISACTIVE")
        un = false
      end
      function underground2()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🛣",
          "◀️VOLTA◀️"
        }, {
          [1] = und
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ghostmod()
        elseif menu[1] == true then
          undergroundon2()
        else
          undergroundoff2()
        end
        menuk = -1
      end
      function undergroundon2()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = undergroundcar1
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "900"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("UNDERGROUND BELOW ACTIVE")
        und = true
      end
      function undergroundoff2()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = undergroundcar1
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1000"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("UNDERGROUND BELOW DISACTIVE")
        und = false
      end
      function undergroundcar()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = undergroundcar1
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1500"
        gg.setValues(r)
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = undergroundcar2
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1500"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("UNDERGROUND CAR")
      end
      function Dead()
        deadmenuk = 1
        while true do
          if gg.isVisible(true) then
            deadmenuk = 1
            gg.setVisible(false)
          end
          if deadmenuk == 1 then
            deadmenu()
          end
        end
      end
      function deadmenu()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR☠",
          "◀️VOLTA◀️"
        }, {
          [1] = dea
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          ghostmod()
        elseif menu[1] == true then
          IsDead()
        else
          IsDeadOff()
        end
        deadmenuk = -1
      end
      function IsDead()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_IsDead
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("ISDEAD ACTIVE")
        dea = true
      end
      function IsDeadOff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_IsDead
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1.2278185e23"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("ISDEAD DISACTIVE")
        dea = false
      end
      function arma()
        shotmenuk = 1
        while true do
          if gg.isVisible(true) then
            shotmenuk = 1
            gg.setVisible(false)
          end
          if shotmenuk == 1 then
            shotmenu()
          end
        end
      end
      function shotmenu()
        menu6 = gg.multiChoice({
          "🌐AIM MENU⚛",
          "🌐HIT DAMAGE MENU🗡",
          "🌐LESS RECOIL ALL WEAPONS⚙",
          "🌐UNLIMITED MENU⚒",
          "🌐DAMAGE HACK MENU⚕",
          "🌐RELOAD FAST MENU♋",
          "🌐RAIN BULLETS⚜",
          "🌐NO KNOCKDOWN🔢",
          "🌐SHOOT IN WATER🤽",
          "🌐NO FIRE DELAYS♨",
          "🌐SPEED FIRED♒",
          "🌐ONKILL⚔",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu6 == nil then
          noselect()
        else
          if menu6[1] then
            aim()
          end
          if menu6[2] then
            hightdmg()
          end
          if menu6[3] then
            recoil()
          end
          if menu6[4] then
            unlimited()
          end
          if menu6[5] then
            damage()
          end
          if menu6[6] then
            reload()
          end
          if menu6[7] then
            bullets()
          end
          if menu6[8] then
            knockdown()
          end
          if menu6[9] then
            shoot()
          end
          if menu6[10] then
            nofiredelays()
          end
          if menu6[11] then
            loadisfile1()
          end
          if menu6[12] then
            onkiller()
          end
          if menu6[13] then
            START()
          end
        end
        shotmenuk = -1
      end
      function aim()
        aimmenuk = 1
        while true do
          if gg.isVisible(true) then
            aimmenuk = 1
            gg.setVisible(false)
          end
          if aimmenuk == 1 then
            aimmenu()
          end
        end
      end
      function aimmenu()
        local menu60 = gg.multiChoice({
          "🌐AIM LOCK (TESTE)☠",
          "🌐AIMBOT SEMI☣",
          "🌐AIM FIX(PARTIDA)✅",
          "🌐AIM STRAIGHT🔘",
          "◀️VOLTA◀️"
        }, nil, "ℹHabilidades nas miras.ℹ")
        if menu60 == nil then
          noselect()
        else
          if menu60[1] then
            aimlock()
          end
          if menu60[2] then
            aimsemi()
          end
          if menu60[3] then
            aimfix()
          end
          if menu60[4] then
            hest()
          end
          if menu60[5] then
            START()
          end
        end
        aimmenuk = -1
      end
      function aimbot()
        aimlockunk = 1
        while true do
          if gg.isVisible(true) then
            aimlockunk = 1
            gg.setVisible(false)
          end
          if aimlockunk == 1 then
            aimlockun()
          end
        end
      end
      function aimlockun()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR⚛",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          AimBotLockON()
        else
          AimBotLockOFF()
        end
        aimlockunk = -1
      end
      function AimBotLockON()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = aimunlock
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("AIM LOCK ACTIVE")
      end
      function AimBotLockOFF()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = aimunlock
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1.3092761e25"
        r[4].flags = gg.TYPE_FLOAT
        r[4].value = "-3.7052061e20"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("AIM LOCK DISACTIVE")
      end
      function aimsemi()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR☣",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          AimBotSemiON()
        else
          AimBotSemiOFF()
        end
        aimsemimk = -1
      end
      function AimBotSemiON()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = semi
        original("7F 45 4C 46 01 01 01 00")
        replaced("79 04 44 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("AIMBOT SEMI ACTIVE")
      end
      function AimBotSemiOFF()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = semi
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-8.5003137e22"
        gg.setValues(r)
        gg.clearResults()
        gg.setValues(r)
        gg.clearResults()
        gg.toast("AIMBOT SEMI DISATIVE")
      end
      function aimsys()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🏹",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          Aim720ON()
        else
          Aim720OFF()
        end
        aimsystemk = -1
      end
      function Aim720ON()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber(" A4r;70r;FDr;3Er;AEr;47r;01r;3Fr;A4r;70r;FDr;3Er;AEr;47r;01r;3Fr::16", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(16)
        gg.editAll("00r;00r;B4r;C3r;00r;00r;B4r;43r;00r;00r;B4r;C3r;00r;00r;B4r;43r", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("AIM ASSYSTEM 360° ACTIVE")
      end
      function Aim720OFF()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber(" 00r;00r;B4r;C3r;00r;00r;B4r;43r;00r;00r;B4r;C3r;00r;00r;B4r;43r::16", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(16)
        gg.editAll("A4r;70r;FDr;3Er;AEr;47r;01r;3Fr;A4r;70r;FDr;3Er;AEr;47r;01r;3Fr", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("AIM ASSYSTEM 360° ACTIVE")
      end
      function aimfix()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber(" 00r;00r;00r;3Fr;00r;00r;80r;3Fr;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;3Fr::20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(20)
        gg.editAll("00r;00r;A0r;40r;00r;00r;80r;3Fr;00r;00r;00r;00r;00r;00r;00r;00r;00r;00r;A0r;40r", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("AIM FIX ACTIVE")
      end
      function hest()
        miraplanak = 1
        while true do
          if gg.isVisible(true) then
            miraplanak = 1
            gg.setVisible(false)
          end
          if miraplanak == 1 then
            miraplana()
          end
        end
      end
      function miraplana()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🔘",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          hettso1()
        else
          hettso2()
        end
      end
      function hettso1()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = LockUnlimid
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("AUTO HEADSHOT ACTIVE")
      end
      function hettso2()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = LockUnlimid
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "360"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("AUTO HEADSHOT DISACTIVE")
      end
      function hightdmg()
        local menu70 = gg.multiChoice({
          "🌐HIT DAMAGE RATIO 35%🗡",
          "🌐HIT DAMAGE RATIO 200%🗡",
          "🌐HIT DAMAGE RATIO 999999%🗡",
          "◀️VOLTA◀️"
        }, nil, "ℹHabilidades nas miras.ℹ")
        if menu70 == nil then
          noselect()
        else
          if menu70[1] then
            hightdmg1()
          end
          if menu70[2] then
            hightdmg2()
          end
          if menu70[3] then
            hightdmg3()
          end
          if menu70[4] then
            START()
          end
        end
      end
      function hightdmg1()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioHead
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "3.5"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioBody
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "2.5"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioLimb
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1.5"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioVehicle
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1.5"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("HIGH DAMAGE ACTIVE")
      end
      function hightdmg2()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioHead
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "10"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioBody
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "10"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioLimb
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "10"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioVehicle
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "10"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("HIGH DAMAGE ACTIVE")
      end
      function hightdmg3()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioHead
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "499.9999"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioBody
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "499.9999"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioLimb
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "499.9999"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HitDamageRatioVehicle
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "499.9999"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("HIGH DAMAGE ACTIVE")
      end
      function recoil()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR⚙",
          "◀️VOLTA◀️"
        }, {
          [1] = rec
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          recoilon()
        else
          recoiloff()
        end
        menuk = -1
      end
      function recoilon()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = LessRecoil
        original("7F 45 4C 46 01 01 01 00")
        replaced("02 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("LESS RECOIL ACTIVE")
        rec = false
      end
      function recoiloff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = LessRecoil
        original("7F 45 4C 46 01 01 01 00")
        replaced("F0 48 2D E9 10 B0 8D E2")
        gg.clearResults()
        gg.toast("LESS RECOIL DISACTIVE")
        rec = true
      end
      function manual()
        munisao = 1
        while true do
          if gg.isVisible(true) then
            munisao = 1
            gg.setVisible(false)
          end
          if munisao == 1 then
            munick()
          end
        end
      end
      function munick()
        local menu8 = gg.multiChoice({
          "🌐M1012✴",
          "🌐M4A1✴",
          "🌐MP5✴",
          "🌐MP40✴",
          "🌐SCAR✴",
          "🌐AK✴",
          "🌐UMP✴",
          "🌐FAMAS✴",
          "🌐M249✴",
          "🌐SPAS12✴",
          "🌐GROZA✴",
          "🌐XM8✴",
          "🌐M60✴",
          "🌐P90✴",
          "🌐M79✴",
          "🌐SKS✴",
          "🌐VSS✴",
          "🌐AWM✴",
          "🌐SVD✴",
          "🌐KAR98✴",
          "🌐CROSSBROW✴",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu8 == nil then
          noselect()
        else
          if menu8[1] then
            arm1()
          end
          if menu8[2] then
            arm2()
          end
          if menu8[3] then
            arm3()
          end
          if menu8[4] then
            arm4()
          end
          if menu8[5] then
            arm5()
          end
          if menu8[6] then
            arm6()
          end
          if menu8[7] then
            arm7()
          end
          if menu8[8] then
            arm8()
          end
          if menu8[9] then
            arm9()
          end
          if menu8[10] then
            arm10()
          end
          if menu8[11] then
            arm11()
          end
          if menu8[12] then
            arm12()
          end
          if menu8[13] then
            arm13()
          end
          if menu8[14] then
            arm15()
          end
          if menu8[15] then
            arm15()
          end
          if menu8[16] then
            arm16()
          end
          if menu8[17] then
            arm17()
          end
          if menu8[18] then
            arm18()
          end
          if menu8[19] then
            arm19()
          end
          if menu8[20] then
            arm20()
          end
          if menu8[21] then
            arm21()
          end
          if menu8[22] then
            START()
          end
        end
        munisao = -1
      end
      function arm1()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.40000000596;0.40000000596;15;5;10;1;1.5;1;0.44999998808;-1D;0D;1D~6D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~6D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~6D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.clearResults()
          gg.toast("M1012 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm2()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.18000000715;0.18000000715;220~225;0.20000000298;1;0.55000001192;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("M4A1 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm3()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.1099999994;0.1099999994;220~225;0.15999999642;1;0.64999997616;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~100D;::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~100D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("MP5 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm4()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.0700000003;0.0700000003;220~225;0.15000000596;1;0.64999997616;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("MP40 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm5()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.15000000596;0.15000000596;220~225;0.25;1;0.55000001192;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("SCAR ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm6()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.18000000715;0.18000000715;220~225;0.30000001192;1;0.55000001192;-1D;0D;1D~48D::133 ", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("AK ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm7()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.09000000358;0.09000000358;220~225;0.28000000119;1;0.64999997616;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("UMP ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm8()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.11999999732;0.15000000596;220~225;0.20000000298;1;0.55000001192;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("FAMAS ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm9()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.15999999642;0.15999999642;220.0;45.0;80.0;1.0;0.30000001192;-1D;0D;1D~100D::", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~100D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~100D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("M249 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm10()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.33000001311;0.33000001311;25;4;20;1.5;-1D;0D;1D~6D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~6D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~6D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("SPAS12 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arml11()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.31999999285;0.31999999285;220~225;2;1.14999997616;1;0.85000002384;-1D;0D;1D~6D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~6D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~6D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("M500 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm11()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.18000000715;0.18000000715;220~225;0.20000000298;1;0.30000001192;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("GROZA ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm12()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.19;.19;220~225;0.17000000179;1;0.55000001192;-1D;0D;1D~48D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~48D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~48D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
          gg.clearResults()
          gg.toast("XM8 ACTIVE")
          gg.addListItems(t)
        end
      end
      function arm13()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.18000000715;0.18000000715;220~225;0.23999999464;0.07919999957;1;0.30000001192;-1D;0D;1D~60D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~60D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~60D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("M60 ACTIVE")
        gg.addListItems(t)
      end
      function arm14()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.09000000358;0.09000000358;220~225;0.17000000179;0.17000000179;1;0.64999997616;-1D;0D;1D~100D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~100D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~100D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("P90 ACTIVE")
        gg.addListItems(t)
      end
      function arm15()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 3.0;3.0;220;50.0;50.0;1.10000002384;1.0;0.80000001192;-1D;0D;1D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("M79 ACTIVE")
        gg.addListItems(t)
      end
      function arm16()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.55000001192;0.55000001192;220~225;0.25;1.0;0.55000001192;-1D;0D;1D~100D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~100D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~100D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("SKS ACTIVE")
        gg.addListItems(t)
      end
      function arm17()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.25;0.25;220~225;1.20000004768;1.0;0.34999999404;-1D;0D;1D~100D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~100D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~100D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("VSS ACTIVE")
        gg.addListItems(t)
      end
      function arm18()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 1.29999995232;1.29999995232;220;1.0;0.80000001192;-1D;0D;1D~15D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~15D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~15D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("AWM ACTIVE")
        gg.addListItems(t)
      end
      function arm19()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.47999998927;0.47999998927;220~225;0.25;1.0;0.55000001192;-1D;0D;1D~15D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~15D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~15D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("SVD ACTIVE")
        gg.addListItems(t)
      end
      function arm20()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 1;1;0;220~225;1.0;0.60000002384;1.0;0.80000001192;-1D;0D;1D~5D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D~5D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1D~5D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("KAR98 ACTIVE")
        gg.addListItems(t)
      end
      function arm21()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.25;0.25;1.0;100.0;25.0;35.0;0.80000001192;1.0;0.80000001192;-1D;0D;1D::133", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-1D;0D;1D::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(100)
        for i, v in ipairs(t) do
          t[i].value = "2"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("CROSSBROW ACTIVE")
        gg.addListItems(t)
      end
      function unlimited()
        local menu9 = gg.multiChoice({
          "🌐MAGAZINE AMMO(VISUAL)⚒",
          "🌐UNLIMITED AMMO(VISUAL)⚒",
          "🌐UNLIMITED AMMO SELECTION MENU(VISUAL)⚒",
          "🌐MAX BAG CAPACITY(VISUAL)⚒",
          "🌐DROP INVENTORY",
          "🌐MUNIÇÃO INFINITA✴",
          "🌐QUANTIDADE INFINITA⚖",
          "◀️VOLTA◀️"
        }, nil, "ℹtire. os limites de munição, deixando infinitas.ℹ                                                                          ❔Ativar no Lobby ou Partida❔")
        if menu9 == nil then
          noselect()
        else
          if menu9[1] then
            unlimited0()
          end
          if menu9[2] then
            unlimited1()
          end
          if menu9[3] then
            unlimited2()
          end
          if menu9[4] then
            DefaultBagCapacity1()
          end
          if menu9[5] then
            dropinventorys()
          end
          if menu9[6] then
            manual()
          end
          if menu9[7] then
            quantidade()
          end
          if menu9[8] then
            START()
          end
          menuk = -1
        end
      end
      function unlimited0()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR⚒",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          MunicaoION()
        else
          MunicaoIOFF()
        end
      end
      function MunicaoION()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = muniion
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("Magazine Ammo ACTIVE")
      end
      function MunicaoIOFF()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = muniion
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "100"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("Magazine Ammo Disative")
      end
      function DefaultBagCapacity1()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + DefaultBagCapacity
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1050"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("Default Bag Capacity ACTIVE")
      end
      function quantidade()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR⚒",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          quantidadeon()
        else
          quantidadeoff()
        end
      end
      function quantidadeon()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = quantidadedebalas
        original("7F 45 4C 46 01 01 01 00")
        replaced("E7 03 00 E3")
        gg.clearResults()
        gg.toast("QUANTIDADE INFINITA ACTIVE")
      end
      function quantidadeoff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = quantidadedebalas
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-8.5004398e22"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("QUANTIDADE INFINITA DISATIVE")
      end
      function unlimited1()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR⚒",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          MunicaoION1()
        else
          MunicaoIOFF2()
        end
      end
      function MunicaoION1()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = unlimitedhack
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("Munição Infinita ACTIVE")
      end
      function MunicaoIOFF2()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = unlimitedhack
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1.3092761e25"
        r[4].flags = gg.TYPE_FLOAT
        r[4].value = "-3.7052061e20"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("Munição Infinita Disative")
      end
      function unlimited2()
        local menu9 = gg.multiChoice({
          "🌐M1012⚒",
          "🌐M4A1⚒",
          "🌐MP5⚒",
          "🌐MP40⚒",
          "🌐SCAR⚒",
          "🌐AK⚒",
          "🌐UMP⚒",
          "🌐FAMAS⚒",
          "🌐M249⚒",
          "🌐SPAS12⚒",
          "🌐M60⚒",
          "🌐P90⚒",
          "◀️VOLTA◀️"
        }, nil, "ℹRetira o limite de munição na Arma, Deixando ilimitada.ℹ                                                                          ❔Ativar no Lobby ou Partida❔")
        if menu9 == nil then
          noselect()
        else
          if menu9[1] then
            armk1()
          end
          if menu9[2] then
            armk2()
          end
          if menu9[3] then
            armk3()
          end
          if menu9[4] then
            armk4()
          end
          if menu9[5] then
            armk5()
          end
          if menu9[6] then
            armk6()
          end
          if menu9[7] then
            armk7()
          end
          if menu9[8] then
            armk8()
          end
          if menu9[9] then
            armk9()
          end
          if menu9[10] then
            armk10()
          end
          if menu9[11] then
            armk11()
          end
          if menu9[12] then
            armk12()
          end
          if menu9[13] then
            START()
          end
          menuk = -1
        end
      end
      function armk1()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("6D;0.40000000596;0.4000000059615;5;10::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("6", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("M1012 ACTIVE")
      end
      function armk2()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("30D;0.18000000715;0.18000000715;220~225;40;90::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("30", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("AK ACTIVE")
      end
      function armk3()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("30D;0.1099999994;0.1099999994;220~225;13;30::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("30", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("MP5 ACTIVE")
      end
      function armk4()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("20D;0.0700000003;0.0700000003;220~225;11;25::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("20", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("MP40 ACTIVE")
      end
      function armk5()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("30D;0.15000000596;0.15000000596;220~225;30;70::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("30", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("SCAR ACTIVE")
      end
      function armk6()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("30D;0.18000000715;0.18000000715;220~225;38;85::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("30", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("GROZA ACTIVE")
      end
      function armk7()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("30D;0.09000000358;0.09000000358;220~225;16;34::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("30", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("UMP ACTIVE")
      end
      function armk8()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 30D;0.11999999732;0.15000000596;220~225;38;80::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("30", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("FAMAS ACTIVE")
      end
      function armk9()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 100D;0.15999999642;0.15999999642;220~225;45;80::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("100", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("M249 ACTIVE")
      end
      function armk10()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 5D;0.33000001311;0.33000001311;25;4;20::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("5", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("SPAS12 ACTIVE")
      end
      function armk11()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 50D;0.09000000358;0.09000000358;220~225::21", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("50", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("200", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("M60 ACTIVE")
      end
      function damage()
        local menu91 = gg.multiChoice({
          "🌐Damage++ Menu Selection⚕",
          "🌐Damage Hack 15%⚕",
          "◀️VOLTA◀️"
        }, nil, "ℹHabilidades nas miras.ℹ")
        if menu91 == nil then
          noselect()
        else
          if menu91[1] then
            damage1()
          end
          if menu91[2] then
            damage2()
          end
          if menu91[3] then
            START()
          end
        end
      end
      function damage1()
        local menu19 = gg.multiChoice({
          "🌐MP5⚕",
          "🌐SCAR⚕",
          "🌐AK⚕",
          "🌐UMP⚕",
          "🌐M4A1⚕",
          "🌐SKS⚕",
          "🌐VSS⚕",
          "🌐GROZA⚕",
          "🌐MP40⚕",
          "🌐M1012⚕",
          "🌐FAMAS⚕",
          "🌐M249⚕",
          "🌐SPAS12⚕",
          "🌐M500⚕",
          "🌐XM8⚕",
          "🌐M60⚕",
          "🌐P90⚕",
          "◀️VOLTA◀️"
        }, nil, "ℹAumentar em 37% o Dano, capaz de matar qualquer um com 7 tiros.ℹ                                                                          ❔Ativar no Lobby ou Partida.❔")
        if menu19 == nil then
          noselect()
        else
          if menu19[1] then
            arml1()
          end
          if menu19[2] then
            arml2()
          end
          if menu19[3] then
            arml3()
          end
          if menu19[4] then
            arml4()
          end
          if menu19[5] then
            arml5()
          end
          if menu19[6] then
            arml6()
          end
          if menu19[7] then
            arml7()
          end
          if menu19[8] then
            arml8()
          end
          if menu19[9] then
            arml9()
          end
          if menu19[10] then
            arml10()
          end
          if menu19[11] then
            arml11()
          end
          if menu19[12] then
            arml12()
          end
          if menu19[13] then
            arml13()
          end
          if menu19[14] then
            arml14()
          end
          if menu19[15] then
            arml15()
          end
          if menu19[16] then
            arml16()
          end
          if menu19[17] then
            arml17()
          end
          if menu19[18] then
            START()
          end
          menuk = -1
        end
      end
      function arml1()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("23D;0.1099999994;0.1099999994;220~225;13;30;10D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("10", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("23", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ MP5 ACTIVE")
      end
      function arml2()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("28D;0.15000000596;0.15000000596;220~225;30;70;10D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("10", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("28", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ SCAR ACTIVE")
      end
      function arml3()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("37D;0.18000000715;0.18000000715;220~225;38;85;12D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("12", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("37", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ AK ACTIVE")
      end
      function arml4()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("23D;0.09000000358;0.09000000358;220~225;16;34;11D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("11", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("23", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ UMP ACTIVE")
      end
      function arml5()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("28D;0.18000000715;0.18000000715;220~225;40;90;11D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("11", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("28", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ M4A1 ACTIVE")
      end
      function arml6()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("68D;0.55000001192;0.55000001192;220~225;50;96;20D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("20", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("68", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ SKS ACTIVE")
      end
      function arml7()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("25D;0.25;0.25;220~225;50;90;14D::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("14", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("25", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ VSS ACTIVE")
      end
      function arml8()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("37D;0.18000000715;0.18000000715;220~225;40;90;11D;0.20000000298;1.20000004768;0.9;1;0.30000001192::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("11", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("37", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ GROZA ACTIVE")
      end
      function arml9()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("23D;0.0700000003;0.0700000003;220~225;11;25;10D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("10", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("23", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ MP40 ACTIVE")
      end
      function arml10()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("26D;0.40000000596;0.4000000059615;5;10;10D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("10", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("26", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ M1012 ACTIVE")
      end
      function arml11()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 28D;0.11999999732;0.15000000596;220~225;38;80;11D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("11", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("28", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ FAMAS ACTIVE")
      end
      function arml12()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 33D;0.15999999642;0.15999999642;220~225;45;80;15D::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("15", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("33", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ M249 ACTIVE")
      end
      function arml13()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 20D;0.33000001311;0.33000001311;25;4;20;6D::65", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("6", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("20", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ SPACE ACTIVE")
      end
      function arml14()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 45D;0.32;0.32;220~225;60;80;20D::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("20", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("45", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ M500 ACTIVE")
      end
      function arml15()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 30D;0.18999999762;0.18999999762;220~225;42;70;13D", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("13", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("30", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ XM8 ACTIVE")
      end
      function arml16()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 31D;0.18000000715;0.18000000715;220~225;14D::33", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("14", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("31", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ M60 ACTIVE")
      end
      function arml17()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 23D;0.09000000358;0.09000000358;220~225;15D::33", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("14", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(8)
        gg.editAll("23", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("Damage++ P90 ACTIVE")
      end
      function damage2()
        local menu19 = gg.multiChoice({
          "🌐MP5⚕",
          "🌐SCAR⚕",
          "🌐AK⚕",
          "🌐UMP⚕",
          "🌐M4A1⚕",
          "🌐SKS⚕",
          "🌐VSS⚕",
          "🌐GROZA⚕",
          "🌐MP40⚕",
          "🌐M1012⚕",
          "🌐FAMAS⚕",
          "🌐M249⚕",
          "🌐SPAS12⚕",
          "🌐M500⚕",
          "🌐XM8⚕",
          "🌐M60⚕",
          "🌐P90⚕",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu19 == nil then
          noselect()
        else
          if menu19[1] then
            arml1()
          end
          if menu19[2] then
            arml2()
          end
          if menu19[3] then
            arml3()
          end
          if menu19[4] then
            arml4()
          end
          if menu19[5] then
            arml5()
          end
          if menu19[6] then
            arml6()
          end
          if menu19[7] then
            arml7()
          end
          if menu19[8] then
            arml8()
          end
          if menu19[9] then
            arml9()
          end
          if menu19[10] then
            arml10()
          end
          if menu19[11] then
            arml11()
          end
          if menu19[12] then
            arml12()
          end
          if menu19[13] then
            arml13()
          end
          if menu19[14] then
            arml14()
          end
          if menu19[15] then
            arml15()
          end
          if menu19[16] then
            arml16()
          end
          if menu19[17] then
            arml17()
          end
          if menu19[18] then
            START()
          end
        end
      end
      function damage2on()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = damage2
        original("7F 45 4C 46 01 01 01 00")
        replaced("15 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DAMAGE HACK ACTIVE")
      end
      function damage2off()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = damage2
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1.3094071e25"
        r[4].flags = gg.TYPE_FLOAT
        r[4].value = "-1.3068388e21"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DAMAGE HACK DISACTIVE")
      end
      function reload2()
        local menu18 = gg.multiChoice({
          "🌐M1012♋",
          "🌐M4A1♋",
          "🌐MP5♋",
          "🌐MP40♋",
          "🌐SCAR♋",
          "🌐AK♋",
          "🌐UMP♋",
          "🌐FAMAS♋",
          "🌐SPAS12♋",
          "🌐XM8♋",
          "🌐M60♋",
          "🌐P90♋",
          "◀️VOLTA◀️"
        }, nil, "ℹReload Fast faz que recarregar as munições em segundos.ℹ                                                                                                             ❔Ative no Lobby ou Partida.❔")
        if menu18 == nil then
          noselect()
        else
          if menu18[1] then
            armd1()
          end
          if menu18[2] then
            armd2()
          end
          if menu18[3] then
            armd3()
          end
          if menu18[4] then
            armd4()
          end
          if menu18[5] then
            armd5()
          end
          if menu18[6] then
            armd6()
          end
          if menu18[7] then
            armd7()
          end
          if menu18[8] then
            armd8()
          end
          if menu18[9] then
            armd9()
          end
          if menu18[10] then
            armd10()
          end
          if menu18[11] then
            START()
          end
          menuk = -1
        end
      end
      function armd1()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.40000000596;0.4000000059615;5;10;1;1.5;0.5;1;0.44999998808::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("0.5", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("M1012 ACTIVE")
        gg.addListItems(t)
      end
      function armd2()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.18000000715;0.18000000715;220~225;40;90;0.20000000298;1.20000004768;0.89999997616;1;0.55000001192::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("M4A1 ACTIVE")
        gg.addListItems(t)
      end
      function armd3()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.1099999994;0.1099999994;220~225;13;30;0.15999999642;1.10000002384;1.10000002384;1;0.64999997616::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1.1;1::5", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1.1", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("MP5 ACTIVE")
        gg.addListItems(t)
      end
      function armd4()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.0700000003;0.0700000003;220~225;11;25;0.15000000596;1.10000002384;0.89999997616;1;0.64999997616::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("MP40 ACTIVE")
        gg.addListItems(t)
      end
      function armd5()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.15000000596;0.15000000596;220~225;30;70;0.25;1.14999997616;0.80000001192;1;0.55000001192::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("0.8", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("SCAR ACTIVE")
        gg.addListItems(t)
      end
      function armd6()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("0.18000000715;0.18000000715;220~225;38;85;0.30000001192;1.20000004768;0.80000001192;1;0.55000001192::75 ", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".8", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("AK ACTIVE")
        gg.addListItems(t)
      end
      function armd7()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.09000000358;0.09000000358;220~225;16;34;0.28000000119;1.25;1.10000002384;1;0.64999997616::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("1.1", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("UMP ACTIVE")
        gg.addListItems(t)
      end
      function armd8()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.11999999732;0.15000000596;220~225;38;80;0.20000000298;1.20000004768;0.89999997616;1;0.55000001192::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("FAMAS ACTIVE")
        gg.addListItems(t)
      end
      function armd9()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.33000001311;0.33000001311;25;4;20;1.5;1.5;0.69999998808;1;0.44999998808::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".7", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.clearResults()
        gg.toast("SPAS12 ACTIVE")
        gg.addListItems(t)
      end
      function armd10()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.18999999762;0.18999999762;220~225;42;70;0.17000000179;1.20000004768;0.89999997616;1;0.55000001192::75", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.addListItems(t)
        gg.clearResults()
        gg.toast("XM8 ACTIVE")
      end
      function armd11()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.18000000715;0.18000000715;220~225;0.89999997616:61", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.addListItems(t)
        gg.clearResults()
        gg.toast("M60 ACTIVE")
      end
      function armd12()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber(" 0.09000000358;0.09000000358;220~225;0.89999997616:61", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber(".9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.editAll("2.9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(1)
        for i, v in ipairs(t) do
          t[i].value = "2.9"
          t[i].freeze = true
        end
        gg.addListItems(t)
        gg.clearResults()
        gg.toast("P90 ACTIVE")
      end
      function reload()
        local menu100 = gg.multiChoice({
          "🌐RELOAD FAST♋",
          "🌐RELOAD FAST MENU SELECION♋",
          "◀️VOLTA◀️"
        }, nil, "ℹHabilidades nas miras.ℹ")
        if menu100 == nil then
          noselect()
        else
          if menu100[1] then
            reload1()
          end
          if menu100[2] then
            reload2()
          end
          if menu100[3] then
            START()
          end
        end
      end
      function reload1()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = Reloadfast1
        original("7F 45 4C 46 01 01 01 00")
        replaced("12 03 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("Reload Fast ACTIVE")
      end
      function bullets()
        menu = gg.choice({
          "🌐RAIN BULLETS X1⚜",
          "🌐RAIN BULLETS X2⚜",
          "🌐RAIN BULLETS X3⚜",
          "🌐RAIN BULLETS X4⚜",
          "🌐RAIN BULLETS X5⚜",
          "🌐RAIN BULLETS X6⚜",
          "🌐RAIN BULLETS X7⚜",
          "🌐RAIN BULLETS X8⚜",
          "🌐RAIN BULLETS X9⚜",
          "🌐RAIN BULLETS X10⚜",
          "🌐RAIN BULLETS X11⚜",
          "🌐RAIN BULLETS X12⚜",
          "🌐RAIN BULLETS X13⚜",
          "🌐RAIN BULLETS X14⚜",
          "🌐RAIN BULLETS X15⚜",
          "🌐RAIN BULLETS X16⚜",
          "🌐RAIN BULLETS X17⚜",
          "🌐RAIN BULLETS X18⚜",
          "🌐RAIN BULLETS X19⚜",
          "🌐RAIN BULLETS X20⚜",
          "🌐RAIN BULLETS X21⚜",
          "🌐RAIN BULLETS X22⚜",
          "🌐RAIN BULLETS X23⚜",
          "🌐RAIN BULLETS X24⚜",
          "🌐RAIN BULLETS X25⚜",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu == nil then
          noselect()
        end
        if menu == 1 then
          ChuvadeBala1X()
        end
        if menu == 2 then
          ChuvadeBala2X()
        end
        if menu == 3 then
          ChuvadeBala3X()
        end
        if menu == 4 then
          ChuvadeBala4X()
        end
        if menu == 5 then
          ChuvadeBala5X()
        end
        if menu == 6 then
          ChuvadeBala6X()
        end
        if menu == 7 then
          ChuvadeBala7X()
        end
        if menu == 8 then
          ChuvadeBala8X()
        end
        if menu == 9 then
          ChuvadeBala9X()
        end
        if menu == 10 then
          ChuvadeBala10X()
        end
        if menu == 11 then
          ChuvadeBala11X()
        end
        if menu == 12 then
          ChuvadeBala12X()
        end
        if menu == 13 then
          ChuvadeBala13X()
        end
        if menu == 14 then
          ChuvadeBala14X()
        end
        if menu == 15 then
          ChuvadeBala15X()
        end
        if menu == 16 then
          ChuvadeBala16X()
        end
        if menu == 17 then
          ChuvadeBala17X()
        end
        if menu == 18 then
          ChuvadeBala18X()
        end
        if menu == 19 then
          ChuvadeBala19X()
        end
        if menu == 20 then
          ChuvadeBala20X()
        end
        if menu == 21 then
          ChuvadeBala21X()
        end
        if menu == 22 then
          ChuvadeBala22X()
        end
        if menu == 23 then
          ChuvadeBala23X()
        end
        if menu == 24 then
          ChuvadeBala24X()
        end
        if menu == 25 then
          ChuvadeBala25X()
        end
        if menu == 26 then
          START()
        end
      end
      function ChuvadeBala1X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala2X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("02 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala3X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("03 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala4X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("04 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala5X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("05 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala6X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("06 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala7X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("07 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala8X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("08 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala9X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("09 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala10X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("0A 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala11X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("0B 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala12X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("0C 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala13X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("0D 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala14X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("0E 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala15X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("0F 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala16X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("10 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala17X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("17 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala18X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("18 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala19X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("19 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala20X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("1A 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala21X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("1B 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala22X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("1C 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala23X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("1D 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala24X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("1E 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function ChuvadeBala25X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = rain
        original("7F 45 4C 46 01 01 01 00")
        replaced("1F 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("RAIN BULLETS ACTIVE")
      end
      function nofiredelays()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = firedelay
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("NO FIRE DELAYS ACTIVE")
      end
      function knockdown()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetKillCount
        original("7F 45 4C 46 01 01 01 00")
        replaced("?? ?? ?? ?? 1E FF 2F E1")
        gg.clearResults()
        gg.toast("NO KNOCKDOWN ACTIVE")
      end
      function shoot()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_CantSwimmingFire
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SHOOT IN WATER ACTIVE")
      end
      function hitparty()
        local menu10 = gg.multiChoice({
          "🌐HITBODYPART NONE🔫",
          " 🌐HITBODYPART HEAD🔫",
          "🌐HITBODYPART BODY",
          "🌐HITBODYPART LIMB🔫",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu10 == nil then
          noselect()
        else
          if menu10[1] == true then
            EHITBODYPARTNONE()
          end
          if menu10[2] == true then
            EHITBODYPARTHEAD()
          end
          if menu10[3] == true then
            EHITBODYPARTBODY()
          end
          if menu10[4] == true then
            EHITBODYPARTLIMB()
          end
          if menu10[5] == true then
            START()
          end
        end
      end
      function EHITBODYPARTNONE()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = EHitBodyPart
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("HITBODYPART ACTIVE")
      end
      function EHITBODYPARTHEAD()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = EHitBodyPart
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("HITBODYPART ACTIVE")
      end
      function EHITBODYPARTBODY()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = EHitBodyPart
        original("7F 45 4C 46 01 01 01 00")
        replaced("02 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("HITBODYPART ACTIVE")
      end
      function EHITBODYPARTLIMB()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = EHitBodyPart
        original("7F 45 4C 46 01 01 01 00")
        replaced("03 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("HITBODYPART ACTIVE")
      end
      function onkiller()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = onkill
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("ONKILL ACTIVE")
      end
      function mekit()
        medkitmenuk = 1
        while true do
          if gg.isVisible(true) then
            medkitmenuk = 1
            gg.setVisible(false)
          end
          if medkitmenuk == 1 then
            medkitmenu()
          end
        end
      end
      function medkitmenu()
        menu10 = gg.multiChoice({
          "🌐MEDKIT 2.9S⏰",
          "🌐EatMushroomTime 2.9S🕑",
          "🌐UseArmortoolsTime 2.9S🕐",
          "🌐MEDKIT + MUSHROOM + ARMORTOOLSTIME FAST⏲",
          "🌐EP INFINITA(VISUAL)♾",
          "🌐HP INFINITO(VISUAL)♾",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu10 == nil then
          noselect()
        else
          if menu10[1] == true then
            mekit1()
          end
          if menu10[2] == true then
            EatMushroom()
          end
          if menu10[3] == true then
            UseArmortools()
          end
          if menu10[4] == true then
            mekit2()
          end
          if menu10[5] == true then
            ep()
          end
          if menu10[6] == true then
            hp()
          end
        end
        medkitmenuk = -1
      end
      function mekit1()
        gg.setRanges(gg.REGION_C_BSS | gg.REGION_ANONYMOUS)
        gg.searchNumber("4Br;00r;00r;00r;04r;00r;00r;00r;05r;00r;00r;00r;00r;00r;80r;40r::16", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(20)
        local r = gg.getResults(20)
        gg.editAll("4Br;00r;00r;00r;03r;00r;00r;00r;04r;00r;00r;00r;66r;66r;3Er;40r", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("MEKIT 3S ACTIVE")
      end
      function EatMushroom()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + EatMushroomTime
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "2.975"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("EATMUSHROOMTIME ACTIVE")
      end
      function UseArmortools()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + UseArmortoolsTime
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "2.975"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("USEARMORTOOLSTIME ACTIVE")
      end
      function mekit2()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_EatSpeedScale
        original("7F 45 4C 46 01 01 01 00")
        replaced("46 0F 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("MEDKIT + MUSHROOM FAST ACTIVE")
      end
      function ep()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_MaxEP
        original("7F 45 4C 46 01 01 01 00")
        replaced("C8 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_CurEP
        original("7F 45 4C 46 01 01 01 00")
        replaced("C7 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("EP INFINITY ACTIVE")
      end
      function hp()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_MaxHP
        original("7F 45 4C 46 01 01 01 00")
        replaced("C8 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_CurHP
        original("7F 45 4C 46 01 01 01 00")
        replaced("C7 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("HP INFINITY ACTIVE")
      end
      function speed()
        speedmenuk = 1
        while true do
          if gg.isVisible(true) then
            speedmenuk = 1
            gg.setVisible(false)
          end
          if speedmenuk == 1 then
            speedmenu()
          end
        end
      end
      function speedmenu()
        menu10 = gg.multiChoice({
          "🌐SPEED HACK X2⚡",
          "🌐SPEED HACK X5⚡",
          "🌐SPEED DRIVER MENU🚀",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu10 == nil then
          noselect()
        else
          if menu10[1] == true then
            speedhk0()
          end
          if menu10[2] == true then
            speedhk1()
          end
          if menu10[3] == true then
            drive()
          end
        end
        speedmenuk = -1
      end
      function speedhk0()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetSpecialRunSpeedScale
        original("7F 45 4C 46 01 01 01 00")
        replaced("79 0F 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED HACK 2X ACTIVE")
      end
      function speedhk1()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetSpecialRunSpeedScale
        original("7F 45 4C 46 01 01 01 00")
        replaced("99 0F 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED HACK 5X ACTIVE")
      end
      function CrouchSpeed1()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetCrouchSpeed
        original("7F 45 4C 46 01 01 01 00")
        replaced("FF 0F 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED CROUCH ACTIVE")
      end
      function speedhk2()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🚶",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          speedhk2on()
        else
          speedhk2off()
        end
      end
      function speedhk2on()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + DashSpeedScale
        end
        gg.loadResults(t)
        local r = gg.getResults(2)
        r[1].value = "2.02"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SPEED RUN X5 ACTIVE")
      end
      function speedhk2off()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + DashSpeedScale
        end
        gg.loadResults(t)
        local r = gg.getResults(2)
        r[1].value = "1.4"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SPEED RUN X5 Disative")
      end
      function speedhk3()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + CreepSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1.24"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SPEED LYINGDOWN ACTIVE")
      end
      function run()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + HighFallingHeight
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "3333333"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("HIGH FALLING HEIGHT ACTIVE")
      end
      function DieingSpeed1()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + DieingSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.8"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SPEED DIEING ACTIVE")
      end
      function force()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimSpeedRunFist
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimSpeedRunPistol
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimSpeedRunGun
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimSpeedRunAWM
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimSpeedDash
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimSpeedCrouch
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimSpeedCrawl
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimloadisfileWalk
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = ".01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + AnimloadisfileCrouchWalk
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0.01"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("ANIMSPEED ACTIVE")
      end
      function tirolesa()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + StropSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("ZIPLINE SPEED ACTIVE")
      end
      function swimming()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SwimSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "3.5"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SWIMMING SPEED ACTIVE")
      end
      function surf()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SwimSurfSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "4.3"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SURF SPEED ACTIVE")
      end
      function highjump()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetMaxJumpHeight
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(2)
        r[1].value = "-3.5982593e21"
        r[2].value = "-2.0291021e20"
        gg.setValues(r)
        gg.clearResults()
        gg.setValues(r)
        gg.clearResults()
        gg.toast("HIGH JUMP ACTIVE")
      end
      function ShoalSpeedScale1()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + ShoalSpeedScale
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "1"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SHOAL SPEED SCALE ACTIVE")
      end
      function StepOffseton()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + StepOffset
        end
        gg.loadResults(t)
        local r = gg.getResults(2)
        r[1].value = "0.3"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("STEPOFFSET ACTIVE")
      end
      function drive()
        menu201 = gg.multiChoice({
          "🌐DISATIVE DRIVER🚶",
          "🌐JEEP🚃",
          "🌐CAR🚘",
          "🌐MOTO🛵",
          "??VOLTA◀️"
        })
        if menu201[1] then
          drivedisative()
        end
        if menu201[2] then
          jeep()
        end
        if menu201[3] then
          car()
        end
        if menu201[4] then
          moto()
        end
        if menu201[5] then
          speed()
        end
        if menu201 == nil then
          noselect()
        end
        speedmenuk = -1
      end
      function drivedisative()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_DriveSpeedScale
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(2)
        r[1].value = "-8.5002849e22"
        r[2].value = "-2.0291021e20"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SPEED DRIVE DISACTIVE")
      end
      function jeep()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_DriveSpeedScale
        original("7F 45 4C 46 01 01 01 00")
        replaced("97 0F 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED JEEP ACTIVE")
      end
      function car()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_DriveSpeedScale
        original("7F 45 4C 46 01 01 01 00")
        replaced("9E 0F 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED CAR ACTIVE")
      end
      function moto()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_DriveSpeedScale
        original("7F 45 4C 46 01 01 01 00")
        replaced("DD 0F 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED MOTORCYCLE ACTIVE")
      end
      function maphack1()
        menumapk = 1
        while true do
          if gg.isVisible(true) then
            menumapk = 1
            gg.setVisible(false)
          end
          if menumapk == 1 then
            menumap()
          end
        end
      end
      function menumap()
        menu11 = gg.multiChoice({
          "🌐NIGHT MODE✨",
          "🌐NO FOG🌁",
          "🌐NO TREE🎄",
          "🌐VEGETATION MESHES🌾",
          "🌐FOV VIEW📹",
          "🌐ROTATION 360°🎯",
          "🌐MAX LUX MODE🏔",
          "🌐VIEW EAGLE🦅",
          "🌐SENCIBILIDADE🎚",
          "🌐NO GRASS(PARTIDA)🌱",
          "🌐NO LAND(PARTIDA)⛰",
          "◀️VOLTA◀️"
        }, nil, "ℹMude as Formas do Jogo.ℹ")
        if menu11 == nil then
          noselect()
        else
          if menu11[1] then
            night()
          end
          if menu11[2] then
            nofog()
          end
          if menu11[3] then
            notree()
          end
          if menu11[4] then
            notg()
          end
          if menu11[5] then
            viewmode()
          end
          if menu11[6] then
            rotation()
          end
          if menu11[7] then
            lux()
          end
          if menu11[8] then
            eagleview()
          end
          if menu11[9] then
            sensibilidade()
          end
          if menu11[10] then
            nograss()
          end
          if menu11[11] then
            noland()
          end
        end
        menumapk = -1
      end
      function night()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libunity.so")
        myoffset = nightmode
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(1)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("Night Mode ACTIVE")
      end
      function nofog()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_fog
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("NO FOG ACTIVE")
      end
      function nograss()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("6D;100;300::17", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("100", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "-1"
        end
        gg.setValues(r)
        gg.clearResults()
        gg.toast("NO GRASS ACTIVE")
      end
      function notree()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = tree
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-1"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("NO TREE ACTIVE")
      end
      function noland()
        gg.setRanges(gg.REGION_C_ALLOC)
        gg.searchNumber("00r;00r;C4r;42r;00r;00r;80r;3Fr;00r::9", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;C4r;42r;00r;00r;80r;3Fr;00r::9", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;C4r;42r;00r;00r;80r;3Fr;00r::9", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;C4r;42r;00r;00r;80r;3Fr;00r::9", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("00r;00r;C4r;42r;00r;00r;80r;3Fr;00r::9", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.getResults(1000)
        gg.editAll("00r;00r;C4r;42r;00r;00r;80r;BFr;00r", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
        gg.clearResults()
        gg.toast("NO LAND ACTIVE")
      end
      function notg()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = InitVegetationMeshes1
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("VEGETATIONMESHES ACTIVE")
      end
      function viewmode()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = Camera
        original("7F 45 4C 46 01 01 01 00")
        replaced("64 00 44 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("FOV ACTIVE")
      end
      function rotation()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = LockUnlimid
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "360"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("ROTACION ACTIVE")
      end
      function eagleview()
        eagleviewk = 1
        while true do
          if gg.isVisible(true) then
            eagleviewk = 1
            gg.setVisible(false)
          end
          if eagleviewk == 1 then
            eagleview1()
          end
        end
      end
      function eagleview1()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🦅",
          "◀️VOLTA◀️"
        }, {
          [1] = ew
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          eagleviewon()
        else
          eagleviewoff()
        end
        eagleviewk = -1
      end
      function eagleviewon()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_height
        original("7F 45 4C 46 01 01 01 00")
        replaced("C2 01 44 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("EAGLE VIEW ACTIVE")
        ew = false
      end
      function eagleviewoff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_height
        original("7F 45 4C 46 01 01 01 00")
        replaced("70 4C 2D E9 10 B0 8D E2")
        gg.clearResults()
        gg.toast("EAGLE VIEW DISACTIVE")
        ew = true
      end
      function sensibilidade()
        local menu28 = gg.multiChoice({
          "🌐Sensibilidade Rápida🎚",
          "🌐Sensibilidade Media🎚",
          "🌐Sensibilidade Lento🎚",
          "◀️VOLTA◀️"
        }, nil, "ℹAltere a sensibilidade do jogo.ℹ")
        if menu28 == nil then
          noselect()
        else
          if menu28[1] then
            sensibilidade1()
          end
          if menu28[2] then
            sensibilidade2()
          end
          if menu28[3] then
            sensibilidade3()
          end
          if menu28[4] then
            START()
          end
          menuk = -1
        end
      end
      function sensibilidade1()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = Sensibilidady
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(2)
        r[1].value = "200"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SENSIBILIDADE FAST ACTIVE")
      end
      function sensibilidade2()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = Sensibilidady
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(1)
        r[1].value = "250"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SENSIBILIDADE MEDIUN ACTIVE")
      end
      function sensibilidade3()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = Sensibilidady
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(1)
        r[1].value = "350"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("SENSIBILIDADE SLOW ACTIVE")
      end
      function lux()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libunity.so")
        myoffset = lumix
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(3)
        r[1].value = "999"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("MAX LUX MODE ACTIVE")
      end
      function parak()
        paraquedasmenuk = 1
        while true do
          if gg.isVisible(true) then
            paraquedasmenuk = 1
            gg.setVisible(false)
          end
          if paraquedasmenuk == 1 then
            paraquedasmenu()
          end
        end
      end
      function paraquedasmenu()
        menu109 = gg.multiChoice({
          "🌐SKY DIVING V SPEED🏂",
          "🌐SKY DIVING H SPEED⛷",
          "🌐SKY DIVING SPEED DELTA🏂",
          "🌐SKY SURFING V SPEED🏂",
          "🌐SKY SURFING H SPEED⛷",
          "🌐SKY SURFING SPEED DELTA",
          "🌐PARACHUTING V SPEED🏂",
          "🌐PARACHUTING H SPEED⛷",
          "🌐NO PARAQUEDAS⛷",
          "🌐LOCK ENTITY🛩",
          "◀️VOLTA◀️"
        }, nil, "ℹDescer do Paraquedas mais rapido que nunca.ℹ")
        if menu109 == nil then
          noselect()
        else
          if menu109[1] then
            SkyDivingMaxVSpeedhk()
          end
          if menu109[2] then
            SkyDivingMaxHSpeedhk()
          end
          if menu109[3] then
            SkyDivingSpeedDeltahk()
          end
          if menu109[4] then
            SkySurfingMaxVSpeedhk()
          end
          if menu109[5] then
            SkySurfingMaxHSpeedhk()
          end
          if menu109[6] then
            SkySurfingSpeedDeltahk()
          end
          if menu109[7] then
            ParachutingMaxVSpeedhk()
          end
          if menu109[8] then
            ParachutingMaxHSpeedhk()
          end
          if menu109[9] then
            noparaquedashk()
          end
          if menu109[10] then
            lockhk()
          end
        end
        paraquedasmenuk = -1
      end
      function SkyDivingMaxVSpeedhk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkyDivingMinVSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkyDivingMaxVSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SKY DIVING SPEED V ACTIVE")
      end
      function SkyDivingMaxHSpeedhk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkyDivingMaxVSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "25"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkyDivingMaxHSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "25"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SKY DIVING SPEED H ACTIVE")
      end
      function SkyDivingSpeedDeltahk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkyDivingSpeedDelta
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SKY DIVING SPEED DELTA ACTIVE")
      end
      function SkySurfingMaxVSpeedhk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkySurfingMinVSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkySurfingMaxVSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SKYSURFING V SPEED ACTIVE")
      end
      function SkySurfingMaxHSpeedhk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkySurfingMinHSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "25"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkySurfingMaxHSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "25"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SKYSURFING H SPEED ACTIVE")
      end
      function SkySurfingSpeedDeltahk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SkySurfingSpeedDelta
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "35"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("SKY DIVING SPEED DELTA ACTIVE")
      end
      function ParachutingMaxVSpeedhk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + ParachutingMinVSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + ParachutingMaxVSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "-32"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("PARACHUTING V SPEED ACTIVE")
      end
      function ParachutingMaxHSpeedhk()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + ParachutingMinHSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "25"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + ParachutingMaxHSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "25"
        gg.setValues(r)
        gg.loadList("/storage/emulated/0/load_pato.log", gg.LOAD_APPEND)
        gg.clearResults()
        gg.toast("PARACHUTING H SPEED ACTIVE")
      end
      function noparaquedashk()
        paraquedasonoffk = 1
        while true do
          if gg.isVisible(true) then
            paraquedasonoffk = 1
            gg.setVisible(false)
          end
          if paraquedasonoffk == 1 then
            paraquedasonoff()
          end
        end
      end
      function paraquedasonoff()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR⛷",
          "◀️VOLTA◀️"
        }, {
          [1] = par
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          paraquedason()
        else
          paraquedasoff()
        end
        paraquedasonoffk = -1
      end
      end
      function paraquedason()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = noparak
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(1)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "250"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("NO PARAQUEDAS ACTIVE")
        par = true
      end
      function paraquedasoff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = noparak
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(1)
        r[1].value = "1.05"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("NO PARAQUEDAS DISACTIVE")
        par = false
      end
      function lockhk()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🛩",
          "◀️VOLTA◀️"
        }, {
          [1] = true
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          START()
        elseif menu[1] == true then
          lock1()
        else
          lock2()
        end
      end
      function wall()
        wallhkm = 1
        while true do
          if gg.isVisible(true) then
            wallhkm = 1
            gg.setVisible(false)
          end
          function wall0()
            menu15 = gg.choice({
              "🌐Wall Hack Beta🕋",
              "🌐Wall Hack Lite🏢",
              "◀️VOLTA◀️"
            }, nil, "ℹAtravesse Parede com o Wall Hack.ℹ")
            if menu15 == 1 then
              wallhack1()
            end
            if menu15 == 2 then
              wallhack2()
            end
            end
            if menu15 == nil then
              noselect()
            end
            wallhkm = -1
          end
          if wallhkm == 1 then
            wall0()
          end
        end
      end
      function _ENV.wallhack1()
        wallhk1m = 1
        while true do
          if gg.isVisible(true) then
            wallhk1m = 1
            gg.setVisible(false)
          end
          function wallhack0()
            menu = gg.multiChoice({
              "🌐ATIVAR/DESATIVAR🕋",
              "◀️VOLTA◀️"
            }, {
              [1] = wa
            }, "")
            if menu == nil then
              noselect()
            elseif menu[2] == true then
              wall()
            elseif menu[1] == true then
              wallhackon()
            else
              wallhackoff()
            end
            wallhk1m = -1
          end
          if wallhk1m == 1 then
            wallhack0()
          end
        end
      end
      function _ENV.wallhackon()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libunity.so")
        myoffset = wallhk
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(3)
        r[1].value = "-999"
        gg.setValues(r)
        gg.clearResults()
        gg.toast(" WALL HACK ACTIVE ")
        wa = true
      end
      function _ENV.wallhackoff()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libunity.so")
        myoffset = wallhk
        original("7F 45 4C 46 01 01 01 00")
        local r = gg.getResults(3)
        r[1].value = "-2"
        gg.setValues(r)
        gg.clearResults()
        gg.toast("WALL HACK DISACTIVE")
        wa = false
      end
      function _ENV.wallhack2()
        wallhackyk = 1
        while true do
          if gg.isVisible(true) then
            wallhackyk = 1
            gg.setVisible(false)
          end
          if wallhackyk == 1 then
            wallhacky()
          end
        end
      end
      function _ENV.wallhacky()
        menu = gg.multiChoice({
          "🌐ATIVAR/DESATIVAR🏢",
          "◀️VOLTA◀️"
        }, {
          [1] = wa2
        }, "")
        if menu == nil then
          noselect()
        elseif menu[2] == true then
          wall0()
        elseif menu[1] == true then
          wallhackon1()
        else
          wallhackoff1()
        end
        wallhackyk = -1
      end
      function _ENV.wallhackon1()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("2;0;260;0.10000000149;3;4.2038954e-45;4.2038954e-45::30", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("2", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "-99"
        end
        gg.setValues(r)
        gg.clearResults()
        gg.toast("WALL HACK LITE ACTIVE")
        wa2 = true
      end
      function _ENV.wallhackoff1()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("-99;0;260;0.10000000149;3;4.2038954e-45;4.2038954e-45::30", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("-99", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local r = gg.getResults(10000)
        for i, v in ipairs(r) do
          r[i].value = "2"
        end
        gg.setValues(r)
        gg.clearResults()
        gg.toast("WALL HACK LITE DISACTIVE")
        wa2 = false
      end
      function _ENV.loadisfile1()
        local menu = gg.choice({
          "🌐SPEED FIRED 1X⚜",
          "🌐SPEED FIRED 2X⚜",
          "🌐SPEED FIRED 3X⚜",
          "🌐SPEED FIRED 4X⚜",
          "🌐SPEED FIRED 5X⚜",
          "🌐SPEED FIRED 6X⚜",
          "🌐SPEED FIRED 7X⚜",
          "🌐SPEED FIRED 8X⚜",
          "🌐SPEED FIRED 9X⚜",
          "🌐SPEED FIRED 10X⚜",
          "🌐SPEED FIRED 11X⚜",
          "🌐SPEED FIRED 12X⚜",
          "🌐SPEED FIRED 13X⚜",
          "🌐SPEED FIRED 14X⚜",
          "🌐SPEED FIRED 15X⚜",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu == nil then
          noselect()
        end
        if menu == 1 then
          loadisfileratex1()
        end
        if menu == 2 then
          loadisfileratex2()
        end
        if menu == 3 then
          loadisfileratex3()
        end
        if menu == 4 then
          loadisfileratex4()
        end
        if menu == 5 then
          loadisfileratex5()
        end
        if menu == 6 then
          loadisfileratex6()
        end
        if menu == 7 then
          loadisfileratex7()
        end
        if menu == 8 then
          loadisfileratex8()
        end
        if menu == 9 then
          loadisfileratex9()
        end
        if menu == 10 then
          loadisfileratex10()
        end
        if menu == 11 then
          loadisfileratex11()
        end
        if menu == 12 then
          loadisfileratex12()
        end
        if menu == 13 then
          loadisfileratex13()
        end
        if menu == 14 then
          loadisfileratex14()
        end
        if menu == 15 then
          loadisfileratex15()
        end
        if menu == 16 then
          START()
        end
        menuk = -1
      end
      function _ENV.loadisfileratex1()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("06 0E 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex2()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("F2 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex3()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("DE 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex4()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("CA 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex5()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("B6 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex6()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("A2 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex7()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("8E 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex8()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("7A 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex9()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("5C 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex10()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("48 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex11()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("2A 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex12()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("16 0D 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex13()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("F8 0C 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex14()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("D0 0C 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.loadisfileratex15()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = loadisfile
        original("7F 45 4C 46 01 01 01 00")
        replaced("B2 0C 43 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("SPEED FIRED ACTIVE")
      end
      function _ENV.perfil()
        perfilmenuk = 1
        while true do
          if gg.isVisible(true) then
            perfilmenuk = 1
            gg.setVisible(false)
          end
          if perfilmenuk == 1 then
            perfilmenu()
          end
        end
      end
      function _ENV.perfilmenu()
        menu27 = gg.multiChoice({
          "🌐BAN BYPASS MENU",
          "🌐CLEAR ACCOUNT👤",
          "🌐NO IDENTIFICATION🚯",
          "🌐LVL 99(UNLOCK RAQUEADA)🎖",
          "🌐COINS(VISUAL)💲",
          "🌐DIAMANTES(VISUAL)💎",
          "🌐EXP(VISUAL)🥇",
          "🌐HAS ELITE PASSON♣",
          "🌐LIKE INFINITY👍",
          "🌐RANKING INFINITY🏅 ",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu27 == nil then
          noselect()
        else
          if menu27[1] then
            ban()
          end
          if menu27[2] then
            repair()
          end
          if menu27[3] then
            SpectatorCamera()
          end
          if menu27[4] then
            rakeada()
          end
          if menu27[5] then
            coins()
          end
          if menu27[6] then
            dimas()
          end
          if menu27[7] then
            exp()
          end
          if menu27[8] then
            HasElitePasson()
          end
          if menu27[9] then
            like()
          end
          if menu27[10] then
            rank()
          end
        end
        perfilmenuk = -1
      end
      function _ENV.rakeada()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_UserLevel
        original("7F 45 4C 46 01 01 01 00")
        replaced("63 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("UNLOCK RAQUEADA ACTIVE")
      end
      function _ENV.coins()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_UserCoins
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("COINS INFINITOS ACTIVE")
      end
      function _ENV.dimas()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_UserGems
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DIAMANTES INFINITOS ACTIVE")
      end
      function _ENV.exp()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_UserExp
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("EXP ACTIVE")
      end
      function _ENV.HasElitePasson()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = HasElitePass
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_has_elite_pass
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_badge_cnt
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("HAS ELITE PASS ACTIVE")
      end
      function _ENV.like()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_liked
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("LIKED INFINITY ACTIVE")
      end
      function _ENV.rank()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_ranking_points
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_rank
        original("7F 45 4C 46 01 01 01 00")
        replaced("EF 05 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("POINTS RANKING INFINITY ACTIVE")
      end
      function _ENV.ban()
        banmenuk = 1
        while true do
          if gg.isVisible(true) then
            banmenuk = 1
            gg.setVisible(false)
          end
          if banmenuk == 1 then
            banmenu()
          end
        end
      end
      function _ENV.banmenu()
        menu29 = gg.multiChoice({
          "🌐BAN BYPASS SERIAL",
          "🌐BAN BYPASS FINGERPRINT",
          "🌐BAN BYPASS MODEL",
          "🌐BAN BYPASS HARDWARE",
          "🌐BAN BYPASS DEVICE",
          "🌐BAN BYPASS BRAND",
          "🌐BAN BYPASS MANUFACTURER",
          "🌐BAN BYPASS PRODUCT",
          "🌐BAN BYPASS BOOTLOADER",
          "🌐BAN BYPASS SUBSCRIBERID",
          "🌐BAN BYPASS IMEI",
          "🌐BAN BYPASS MEID",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu29 == nil then
          noselect()
        else
          if menu29[1] then
            GetBuildSerialmenu()
          end
          if menu29[2] then
            GetBuildFingerPrintmenu()
          end
          if menu29[3] then
            GetBuildModelmenu()
          end
          if menu29[4] then
            GetBuildHardwaremenu()
          end
          if menu29[5] then
            GetBuildDevicemenu()
          end
          if menu29[6] then
            GetBuildBrandmenu()
          end
          if menu29[7] then
            GetBuildManufacturermenu()
          end
          if menu29[8] then
            GetBuildProductmenu()
          end
          if menu29[9] then
            GetBuildBootloadermenu()
          end
          if menu29[10] then
            GetTelephonyManagerSubscriberIdmenu()
          end
          if menu29[11] then
            GetTelephonyManagerIMEImenu()
          end
          if menu29[12] then
            GetTelephonyManagerMEIDmenu()
          end
          if menu29[13] then
            perfil()
          end
        end
        banmenuk = -1
      end
      function _ENV.GetBuildSerialmenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildSerial
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDSERIAL ACTIVE")
      end
      function _ENV.GetBuildFingerPrintmenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildFingerPrint
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDFINGERPRINT ACTIVE")
      end
      function _ENV.GetBuildModelmenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildModel
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDMODEL ACTIVE")
      end
      function _ENV.GetBuildHardwaremenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildHardware
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDHARDWARE ACTIVE")
      end
      function _ENV.GetBuildDevicemenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildDevice
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDDEVICE ACTIVE")
      end
      function _ENV.GetBuildBrandmenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildBrand
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDBRAND ACTIVE")
      end
      function _ENV.GetBuildManufacturermenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildManufacturer
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDMANUFACTURER ACTIVE")
      end
      function _ENV.GetBuildProductmenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildProduct
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDPRODUCT ACTIVE")
      end
      function _ENV.GetBuildBootloadermenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetBuildBootloader
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS BUILDBOOTLOADER ACTIVE")
      end
      function _ENV.GetTelephonyManagerSubscriberIdmenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetTelephonyManagerSubscriberId
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS SUBSCRIBERID ACTIVE")
      end
      function _ENV.GetTelephonyManagerIMEImenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetTelephonyManagerIMEI
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS IMEI ACTIVE")
      end
      function _ENV.GetTelephonyManagerMEIDmenu()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = GetTelephonyManagerMEID
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("BAN BYPASS MEID ACTIVE")
      end
      function _ENV.repair()
        clearid = gg.alert("ATENÇÃO!!! SE QUER REMOVER SUA CONTA?\n\nCLICK EM \"SIM\" PARA CONTINUAR, CLICK EM \"NÃO\" PARA VOLTAR.", "SIM", "NÃO")
        if clearid == 0 then
          noselect()
        end
        if clearid == 1 then
          accountclear()
        end
        if clearid == 2 then
          perfil()
        end
        repairmenuk = -1
      end
      function _ENV.accountclear()
        os.remove(gg.EXT_STORAGE .. "/com.garena.msdk/guest100067.dat")
        os.remove(gg.EXT_STORAGE .. "/com.garena.msdk")
        os.remove(gg.EXT_STORAGE .. "/Android/data/com.dts.freefireth/files/reportnew.db")
        os.remove(gg.EXT_STORAGE .. "/Android/data/com.dts.freefireth/files/ymrtc_log.txt")
        gg.toast("CLEAR ACCOUNT")
      end
      function _ENV.report()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = onReportClick
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = OnReportCheatSent
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = onReportClick1
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = OnReportCheatSent1
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = OnCheatToggleClick
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = OnReportCheatClick
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = LogReportCheat
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        os.remove(gg.EXT_STORAGE .. "/Android/data/com.dts.freefireth/files/reportnew.db")
        os.remove(gg.EXT_STORAGE .. "/Android/data/com.dts.freefireth/files/ymrtc_log.txt")
      end
      function _ENV.SpectatorCamera()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + LobbyAdAutoScrollTime
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + GachaAdAutoScrollTime
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + GachaClothTabAutoScrollTime
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorCameraHeight
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorCameraHDis
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorCameraAngle
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SPHudNameScale
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SPHudNameFixedRadius
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorNamePlateScaleOffset
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorCameraMoveSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorCamreraRotateSpeed
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorSoundRange
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + SpectatorCameraFastMoveSpeedRatio
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        gg.searchNumber("3.25;1.4~2.06;1.89999997616::9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
        local t = gg.getResults(3)
        gg.addListItems(t)
        local t = gg.getResults(2)
        for i, v in ipairs(t) do
          v.address = v.address + ObserverSwitchDelay
        end
        gg.loadResults(t)
        local r = gg.getResults(4)
        r[1].flags = gg.TYPE_FLOAT
        r[1].value = "0"
        gg.setValues(r)
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_AccountID
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = get_UserLoginData
        original("7F 45 4C 46 01 01 01 00")
        replaced("00 00 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("NO IDENTIFICAÇION ACTIVE")
      end
      function _ENV.dropinventorys()
        menu = gg.choice({
          "🌐DROP INVENTORY X1",
          "🌐DROP INVENTORY X2",
          "🌐DROP INVENTORY X3",
          "🌐DROP INVENTORY X4",
          "🌐DROP INVENTORY X5",
          "🌐DROP INVENTORY X6",
          "🌐DROP INVENTORY X7",
          "🌐DROP INVENTORY X8??",
          "🌐DROP INVENTORY X9",
          "🌐DROP INVENTORY X10",
          "🌐DROP INVENTORY X11",
          "🌐DROP INVENTORY X12",
          "🌐DROP INVENTORY X13",
          "🌐DROP INVENTORY X14",
          "🌐DROP INVENTORY X15",
          "🌐DROP INVENTORY X16",
          "🌐DROP INVENTORY X17",
          "🌐DROP INVENTORY X18",
          "🌐DROP INVENTORY X19",
          "🌐DROP INVENTORY X20",
          "🌐DROP INVENTORY X21",
          "🌐DROP INVENTORY X22",
          "🌐DROP INVENTORY X23",
          "🌐DROP INVENTORY X24",
          "🌐DROP INVENTORY X25",
          "🌐DROP INVENTORY X26",
          "🌐DROP INVENTORY X27",
          "🌐DROP INVENTORY X28",
          "🌐DROP INVENTORY X29??",
          "🌐DROP INVENTORY X30",
          "◀️VOLTA◀️"
        }, nil, "")
        if menu == nil then
          noselect()
        end
        if menu == 1 then
          drop1X()
        end
        if menu == 2 then
          drop2X()
        end
        if menu == 3 then
          drop3X()
        end
        if menu == 4 then
          drop4X()
        end
        if menu == 5 then
          drop5X()
        end
        if menu == 6 then
          drop6X()
        end
        if menu == 7 then
          drop7X()
        end
        if menu == 8 then
          drop8X()
        end
        if menu == 9 then
          drop9X()
        end
        if menu == 10 then
          drop10X()
        end
        if menu == 11 then
          drop11X()
        end
        if menu == 12 then
          drop12X()
        end
        if menu == 13 then
          drop13X()
        end
        if menu == 14 then
          drop14X()
        end
        if menu == 15 then
          drop15X()
        end
        if menu == 16 then
          drop16X()
        end
        if menu == 17 then
          drop17X()
        end
        if menu == 18 then
          drop18X()
        end
        if menu == 19 then
          drop19X()
        end
        if menu == 20 then
          drop20X()
        end
        if menu == 21 then
          drop21X()
        end
        if menu == 22 then
          drop22X()
        end
        if menu == 23 then
          drop23X()
        end
        if menu == 24 then
          drop24X()
        end
        if menu == 25 then
          drop25X()
        end
        if menu == 26 then
          drop26X()
        end
        if menu == 27 then
          drop27X()
        end
        if menu == 28 then
          drop28X()
        end
        if menu == 29 then
          drop29X()
        end
        if menu == 30 then
          drop30X()
        end
        if menu == 31 then
          START()
        end
      end
      function _ENV.drop1X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("01 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop2X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("02 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop3X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("03 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop4X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("04 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop5X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("05 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop6X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("06 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop7X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("07 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop8X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("08 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop9X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("09 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop10X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("0A 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop11X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("0B 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop12X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("0C 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop13X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("0D 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop14X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("0E 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop15X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("0F 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop16X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("10 10 A0 E3 1E FF 2F E1")
        gg.setValues(r)
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop17X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("11 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop18X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("12 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop19X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("13 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop20X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("14 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop21X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("15 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop22X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("16 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop23X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("17 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop24X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("18 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop25X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("19 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop26X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("1A 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop27X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("1B 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop28X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("1C 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop29X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("1D 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.drop30X()
        gg.loadList(gg.EXT_STORAGE .. "/libs.log", gg.LOAD_APPEND)
        local t = gg.getListItems()
        gg.loadResults(t)
        gg.removeListItems(t)
        gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA)
        name("libil2cpp.so")
        myoffset = drop
        original("7F 45 4C 46 01 01 01 00")
        replaced("1F 10 A0 E3 1E FF 2F E1")
        gg.clearResults()
        gg.toast("DROP INVENTORY ACTIVE")
      end
      function _ENV.noselect()
        gg.toast("Voce não selecionou nada.")
      end
      function _ENV.GameVarDef()
        RunSpeed = 0
        DashSpeedScale = 4
        CrouchSpeed = 8
        CreepSpeed = 12
        DieingSpeed = 16
        StropSpeed = 20
        StropUseCooldown = 24
        StropFOV = 28
        StropFOVFadeDuration = 32
        StropEnable = 36
        ShoalSpeedScale = 40
        SimGravityY = 44
        MaxJumpHeight = 48
        HighFallingHeight = 52
        StandingColliderHeight = 56
        CrouchingColliderHeight = 60
        MovingCrouchingColliderHeight = 64
        FreeMoveAngularSpeed = 68
        InCarColliderHeight = 72
        SkyDivingMinVSpeed = 76
        SkyDivingMaxVSpeed = 80
        SkyDivingMinHSpeed = 84
        SkyDivingMaxHSpeed = 88
        SkyDivingSpeedDelta = 92
        SkyDivingRotationSpeed = 96
        SkyDivingTimeToOpenParachute = 100
        SkySurfingMinVSpeed = 104
        SkySurfingMaxVSpeed = 108
        SkySurfingMinHSpeed = 112
        SkySurfingMaxHSpeed = 116
        SkySurfingRotationSpeed = 120
        SkySurfingSpeedDelta = 124
        SkyDashingRotationSpeed = 128
        SkySurfingStanceButtonOffHeight = 132
        ParachutingMinHSpeed = 136
        ParachutingMinVSpeed = 140
        ParachutingMaxHSpeed = 144
        ParachutingMaxVSpeed = 148
        ParachutingMaxAngleTilt = 152
        ParachutingMinAngleTilt = 156
        ParachutingTiltSpeed = 160
        ParachutingMaxAngleRoll = 164
        ParachutingMinAngleRoll = 168
        ParachutingRollSpeed = 172
        ParachutingTurningRadius = 176
        ParachutingOpenDuration = 180
        DefaultBagCapacity = 184
        HitDamageRatioHead = 188
        HitDamageRatioBody = 192
        HitDamageRatioLimb = 196
        HitDamageRatioVehicle = 200
        SkyDivingCameraUpOffset = 204
        SkyDivingCameraBackOffset = 208
        OnBoardCameraUpOffset = 212
        OnBoardCameraBackOffset = 216
        SkySurfingCameraUpOffset = 220
        SkySurfingCameraBackOffset = 224
        ParachutingCameraUpOffset = 228
        ParachutingCameraBackOffset = 232
        SkyDivingCameraShakeFactor = 236
        ParachutingCameraShakeDuring = 240
        ParachutingCameraShakeFactor = 244
        LandingCameraShakeDuration = 248
        LandingCameraShakeFactor = 252
        GroupInviteCoolDown = 256
        AnimSpeedRunFist = 260
        AnimSpeedRunPistol = 264
        AnimSpeedRunGun = 268
        AnimSpeedRunAWM = 272
        AnimSpeedDash = 276
        AnimSpeedCrouch = 280
        AnimSpeedCrawl = 284
        AnimloadisfileWalk = 288
        AnimloadisfileCrouchWalk = 292
        AlarmSoundChangeRadius = 296
        AlarmSoundStartSecound = 300
        AlarmSoundDuringSecound = 304
        GunFireBoneDeltaAngeX = 308
        GunFireBoneDeltaAngeX_Crouch = 312
        GunFireBoneDeltaAngeZ_Crouch = 316
        IKBoneRotateSpeed = 320
        VehicleHitSoundMinSpeedSqr = 324
        EnableGameVoice = 328
        ReleaseMicWhenMute = 332
        EnableExitCommModeWhenHeadsetPlugin = 333
        RemoveDeadTeammatesOnMap = 334
        DurationDeadTeammatesOnMap = 336
        ShowTeammateFiringOnMap = 340
        ShowEnemyFiringOnMap = 341
        VegetationNewViewDistance = 344
        DeadFlySpeedByCar = 348
        AnimSpeedSwim = 352
        CarCrashSpeedScale = 356
        CarCrashAngle = 360
        VehicleKillPersonMinSpeedSqr = 364
        CarCrashDamageScaleToPlayer = 368
        CarCrashDamageScaleToTeamate = 372
        CarCrashDamageScaleToVehicle = 376
        CarCrashDamageScaleToPlayerInVehicle = 380
        CarCrashDamageScaleWhenHitWall = 384
        CarCrashProtectTimeForHitPlayer = 388
        CarCrashProtectTimeForHitCar = 392
        CarCrashProtectTimeForHitWall = 396
        UseNewCarCrash = 400
        SwapWeaponCD = 404
        EnableRebateCard = 408
        SilenceWeaponHintRange = 412
        ForceBlackBloodRegions = 416
        OptionalBlackBloodRegions = 420
        DisableWebViewWindow = 424
        DisableWebViewScaling = 425
        DisableWebViewCookie = 426
        UavRange = 428
        UavModelDisplayRange = 432
        UavRevealTime = 436
        SwimSpeed = 440
        SwimSurfSpeed = 444
        CharacterRecvShadow = 448
        SwimDashScale = 452
        EnableLightmapInLowQuality = 456
        EnableMTP = 457
        EnableSkySurfing = 458
        EatMushroomTime = 460
        UseArmortoolsTime = 464
        EnableClimb = 468
        EnableMoveDirectionCheckInClimb = 469
        CrossOverAnimTime = 472
        CrossOverJumpTimeDefault = 476
        _ENV.CrossOverFallTimeDefault = 480
        _ENV.ClimbCameraDuration = 484
        _ENV.EnableGacha = 488
        _ENV.AskChangeSeatCoolDown = 492
        _ENV.WaitingForConfirmationTimeout = 496
        _ENV.GunTrace3PMinDistanceSqr = 500
        _ENV.GunTrace3PTimeInterval = 504
        _ENV.GunTrace3PMaxDistance = 508
        _ENV.EnableCustomRoom = 512
        _ENV.EnableCustomRoomAuthority = 513
        _ENV.EnableLUTHighQuality = 514
        _ENV.EnableLUTMidQuality = 515
        _ENV.VehicleSkyDivingCameraUpOffset = 516
        _ENV.VehicleSkyDivingCameraBackOffset = 520
        _ENV.VehicleParachutingCameraUpOffset = 524
        _ENV.VehicleParachutingCameraBackOffset = 528
        _ENV.VehicleSkyDivingMinVSpeed = 532
        _ENV.VehicleSkyDivingMaxVSpeed = 536
        _ENV.VehicleSkyDivingMinHSpeed = 540
        _ENV.VehicleSkyDivingMaxHSpeed = 544
        _ENV.VehicleSkyDivingRotationSpeed = 548
        _ENV.VehicleParachutingMinHSpeed = 552
        _ENV.VehicleParachutingMaxHSpeed = 556
        _ENV.VehicleParachutingMinVSpeed = 560
        _ENV.VehicleParachutingMaxVSpeed = 564
        _ENV.VehicleParachutingRollSpeed = 568
        _ENV.EnableShootTraceAdjustment = 572
        _ENV.ShootTraceAdjustmentDistanceThreshold = 576
        _ENV.RejoinMatchWaitingForSteaming = 580
        _ENV.SlopeLimit = 584
        _ENV.StepOffset = 588
        _ENV.SkinWidth = 592
        _ENV.CCTRadiusNormal = 596
        _ENV.CCTRadiusCreep = 600
        _ENV.CreepSlopeLimit = 604
        _ENV.CreepStepOffset = 608
        _ENV.CreepColliderHeight = 612
        _ENV.BoardSurfingColliderHeight = 616
        _ENV.LobbyAdAutoScrollTime = 620
        _ENV.GachaAdAutoScrollTime = 624
        _ENV.GachaClothTabAutoScrollTime = 628
        _ENV.SpectatorCameraHeight = 632
        _ENV.SpectatorCameraHDis = 636
        _ENV.SpectatorCameraAngle = 640
        _ENV.SPHudNameScale = 644
        _ENV.SPHudNameFixedRadius = 648
        _ENV.SPHudNameFreeRadius = 652
        _ENV.SpectatorNamePlateScaleOffset = 656
        _ENV.FireSoundMiddleRange = 660
        _ENV.FireSoundLongRange = 664
        _ENV.BulletDropSoundDelay = 668
        _ENV.GuestPlayLadderMatchLevelLimit = 672
        _ENV.OildrumMaxDurability = 676
        _ENV.OildrumExplodeRadius = 680
        _ENV.OildrumExplodeMaxDamage = 684
        _ENV.OildrumExplodeMinDamage = 688
        _ENV.OildrumExplodeThreshold = 692
        _ENV.SmokedrumUsePrepareTime = 696
        _ENV.SkyDivingForceToOpenParachuteHeight = 700
        _ENV.SpeedRoyalBGMEnable = 704
        _ENV.SpeedRoyalBGMDelay = 708
        _ENV.StropFallingDamageMax = 712
        _ENV.EnableTreasureMap = 716
        _ENV.EnableBountyContract = 717
        _ENV.DisplayLocalizedPriceForIAP = 718
        _ENV.AlwaysFetchAllPrices = 719
        _ENV.ForceExecuteLoadIAPItems = 720
        _ENV.SpectatorCameraMoveSpeed = 724
        _ENV.SpectatorCameraFastMoveSpeedRatio = 728
        _ENV.SpectatorCamreraRotateSpeed = 732
        _ENV.SpectatorSoundRange = 736
        _ENV.UMAMeshOptimize = 740
        _ENV.AirlineStartDistance = 744
        _ENV.FootballRadius = 748
        _ENV.FootballRadiusGrowUp = 752
        _ENV.FootballRadiusMax = 756
        _ENV.FootballBackOffsetFactor = 760
        _ENV.FootballUpOffsetFactor = 764
        _ENV.FootballDuration = 768
        _ENV.FootballStartMinSpeed = 772
        _ENV.FootballStartMaxSpeed = 776
        _ENV.FootballSpeedYFloor = 780
        _ENV.FootballSpeedBounceFade = 784
        _ENV.FootballSpeedBounceFadeAfterGoals = 788
        _ENV.FootballSpeedBounceFadeXZ = 792
        _ENV.FootballLauncherHAngleMax = 796
        _ENV.FootballLauncherVAngleMax = 800
        _ENV.FootballAdjustAccForward = 804
        _ENV.FootballAdjustAccRight = 808
        _ENV.MTPDefenceLevel = 812
        _ENV.CarePackageMaxNum = 816
        _ENV.VehicleMissileUsingPlayerAimUI = 820
        _ENV.LeavesNotchForAndroid = 821
        _ENV.NotchForAndroidThreshold = 824
        _ENV.NotchSizeForAndroid = 828
        _ENV.NotchSizeForiOS = 832
        _ENV.EnableVibrateFeature = 836
        _ENV.NeedSignatureInfo = 837
        _ENV.PanicButtonForLocalNotification = 838
        _ENV.DaysOfNotifyForAll = 840
        _ENV.DaysOfNotifyForRebateCards = 844
        _ENV.DaysOfNotifyForFreeGacha = 848
        _ENV.ShowIAPBundleForIOSReview = 852
        _ENV.MinutesOfNotifyBeforeIAPBundleEnds = 856
        _ENV.MaxMinutesOfDelayForRebateCardsNotify = 860
        _ENV.MaxMinutesOfDelayForFreeGachaNotify = 864
        _ENV.DaysFromLastLoginForFriendReunion = 868
        _ENV.FriendReunionUrl = 872
        _ENV.Ping1 = 876
        _ENV.Ping2 = 880
        _ENV.PingColor = 884
        _ENV.PingCount = 888
        _ENV.PingMaxValue = 892
        _ENV.ObserverSwitchDelay = 896
        _ENV.TeamDefeatedDelay = 900
        _ENV.MissileTraceLength = 904
        _ENV.ScanAirLineTransparency = 908
        _ENV.SkinOnQualitySwitch = 912
        _ENV.VehicleJoyStick_Range = 916
        _ENV.VehicleJoyStick_ThrottleAndBrakeDeadZoneAngle = 920
        _ENV.VehicleJoyStick_TurnDeadZoneAngleStart = 924
        _ENV.VehicleJoyStick_TurnDeadZoneAngleEnd = 928
        _ENV.VehicleJoyStick_LeftBaseVector_x = 932
        _ENV.VehicleJoyStick_LeftBaseVector_z = 936
        _ENV.APIToken = 940
        _ENV.ShowEPTopPlayerOnAirplane = 944
        _ENV.ShowEPRankingOnInHud = 945
        _ENV.CanSwimSurfing = 946
        _ENV.PingTimeout = 948
        _ENV.VehicleSkinHideDelay = 952
        _ENV.ShowSkinOnQualityMiddle = 956
        _ENV.UseAsyncSceneUnload = 957
        _ENV.UseNewUnloadType = 958
        _ENV.UnloadType = 960
        _ENV.UnloadMaxScene = 964
        _ENV.UnloadMaxFreeMemory = 968
        _ENV.UnloadMaxFreeMemoryIOS = 972
        _ENV.UnloadMaxUsedMemory = 976
        _ENV.UnloadMaxWaitTime = 980
        _ENV.UnloadMaxFreeMemFreq = 984
        _ENV.AlarmtAvailMemorySize = 988
        _ENV.CustomRoomSimulationInfoLevel = 992
        _ENV.EnableUMAGC = 996
        _ENV.ShowEPOnWaitland = 997
        _ENV.ShowEPAvatarNormal = 998
        _ENV.ShowEPOnWaitForLow = 999
        _ENV.CardCloseTime = 1000
        _ENV.ClanGroupInviteIconShowTime = 1004
        _ENV.ClanGroupInviteCoolDownTime = 1008
        _ENV.LogoutSDKOnBindSuccess = 1012
        _ENV.PickupInstantTime = 1016
        _ENV.MallPurchaseMaxCount = 1020
        _ENV.ShowHighFrameRateSetting = 1024
        _ENV.IOSTextureHDSupport = 1025
        _ENV.IsRedEnvelopeEnable = 1026
        _ENV.RedEnvelopeMaxPlantNumPerMatch = 1028
        _ENV.EnableSparkEvent = 1032
        _ENV.VisibleFlagInWaitingRoom = 1040
        _ENV.VisibleFlagInWaitingRoomLow = 1048
        _ENV.VisibleFlagInWaitingRoomLowest = 1056
        _ENV.EnableFlagAutoStartDownload = 1064
        _ENV.OptionalDownloadMaxThreads = 1068
        _ENV.EnableRimLighting = 1072
        _ENV.PetVisibleRange = 1076
        _ENV.PetPlayButtonCD = 1080
        _ENV.PetWanderSpeed = 1084
        _ENV.PetRunSpeed = 1088
        _ENV.MinutesBetweenSendingCachedEventLogs = 1092
        _ENV.SpawnEventBonusAI = 1096
        _ENV.CanEatMushroomDuringTransform = 1097
        _ENV.EnableSnowFlake = 1098
        _ENV.EnableMultiThreadDownload = 1099
        _ENV.ClanPointsRankRequestIntervalTime = 1100
        _ENV.RTShadowDistance = 1104
        _ENV.RTShadowDistanceOnAndroid = 1108
        _ENV.ModifyGrassUtrlaLODDist = 1112
        _ENV.PreloadCountPerFrame = 1116
        _ENV.LessRecoil = 20424048
        _ENV.get_IsFemale = 8430936
        _ENV.get_CantSwimmingFire = 8604416
        _ENV.GetSpecialRunSpeedScale = 8495404
        _ENV.get_EatSpeedScale = 8679712
        _ENV.get_MaxEP = 8426772
        _ENV.get_CurEP = 8608376
        _ENV.get_MaxHP = 8479948
        _ENV.get_CurHP = 8608764
        _ENV.loadisfile = 7919356
        _ENV.GetCrouchSpeed = 12538400
        _ENV.GetMaxJumpHeight = 12529896
        _ENV.get_is_night_mode = 37074176
        _ENV.get_fog = 32662196
        _ENV.get_height = 28539356
        _ENV.GetBuildSerial = 23909232
        _ENV.GetBuildFingerPrint = 23916272
        _ENV.GetBuildModel = 23916544
        _ENV.GetBuildHardware = 23916816
        _ENV.GetBuildDevice = 23917088
        _ENV.GetBuildBrand = 23917360
        _ENV.GetBuildManufacturer = 23917632
        _ENV.GetBuildProduct = 23917904
        _ENV.GetBuildBoard = 23918176
        _ENV.GetBuildBootloader = 23918448
        _ENV.GetTelephonyManagerSubscriberId = 23918720
        _ENV.GetTelephonyManagerIMEI = 23909504
        _ENV.GetTelephonyManagerMEID = 23909776
        _ENV.ghostl = 8076348
        _ENV.ghostl2 = 8083052
        _ENV.ghostn = 8079348
        _ENV.UseHighQualityAvatar = 8554172
        _ENV.SetTexture = 31400324
        _ENV.White2 = 22013376
        _ENV.SetTextureImpl = 31402464
        _ENV.nightmode = 1712752
        _ENV.tree = 19999876
        _ENV.Sensibilidady = 8570820
        _ENV.Camera = 20056228
        _ENV.undergroundcar1 = 30612756
        _ENV.undergroundcar2 = 30613372
        _ENV.GetKillCount = 8591024
        _ENV.unlimitedhack = 9600508
        _ENV.muniion = 8229944
        _ENV.Reloadfast1 = 8232288
        _ENV.LockUnlimid = 12004048
        _ENV.firedelay = 20664028
        _ENV.noparak = 8414376
        _ENV.lumix = 1699012
        _ENV.rain = 8251868
        _ENV.semi = 8234188
        _ENV.drop = 36861304
        _ENV.antenalib = 2765972
        _ENV.wallhk = 3983312
        _ENV.aimunlock = 10304552
        _ENV.EHitBodyPart = 36878044
        _ENV.InitVegetationMeshes1 = 20015752
        _ENV.damage1 = 9592448
        _ENV.damage2 = 9600188
        _ENV.damage3 = 9617052
        _ENV.quantidadedebalas = 7978720
        _ENV.pentequantidade = 9576784
        _ENV.aimlock = 10304552
        _ENV.get_IsDead = 26964596
        _ENV.atiraauto = 8251884
        _ENV.atiraauto2 = 8252396
        _ENV.get_DriveSpeedScale = 8682748
        _ENV.get_UserCoins = 17909612
        _ENV.get_UserGems = 17909628
        _ENV.get_UserLevel = 17799816
        _ENV.get_UserExp = 17909856
        _ENV.onkill = 17777432
        _ENV.onReportClick = 23219984
        _ENV.OnReportCheatSent = 23220544
        _ENV.onReportClick1 = 23213200
        _ENV.OnReportCheatSent1 = 23213760
        _ENV.OnCheatToggleClick = 29605956
        _ENV.OnReportCheatClick = 14862488
        _ENV.LogReportCheat = 33797052
        _ENV.HasElitePass = 17909968
        _ENV.get_has_elite_pass = 33394224
        _ENV.get_badge_cnt = 33394240
        _ENV.get_liked = 28888784
        _ENV.get_ranking_points = 33394192
        _ENV.get_account_id = 33751852
        _ENV.get_account_id1 = 33393984
        _ENV.get_level = 33394024
        _ENV.get_rank = 28888672
        _ENV.get_AccountID = 26253364
        _ENV.get_UserLoginData = 17909508
        _ENV.get_PlayerID = 33392040
        _ENV.bypass = 434328
      end
      _ENV.GameVarDef()
      function _ENV.sair()
        gg.clearResults()
        t = gg.getListItems()
        gg.removeListItems(t)
        os.remove(gg.EXT_STORAGE .. "/Pato.log")
        os.remove(gg.EXT_STORAGE .. "/libs.log")
        os.exit()
      end
      if menuk == 1 then
        START()
      end
 end