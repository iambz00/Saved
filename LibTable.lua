--[[
    LibTable

    A library to make HTML-like table structure.
    Part of SavedClassic

1. Load Library, Create Instance, Manipulate Shape, Options, Callbacks
    local LibTable = LibStub("LibTable")
    local tbl = LibTable:CreateTable(frameName, parentFrame, size?, options?, callbacks?)
    -- Returns tbl object, instance of "Frame" object

    tbl:Resize(size)
    tbl:SetOption(options)
    tbl:SetCallback(callbacks)

    size = {
        rows: num of rows,
        cols: num of columns,
        widths: table of col width in order - last num for all rest cols
        heights: table of row height in order - last num for all rest rows
        borders = {
            top, right, bottom, left : each border size
        }
    }
    options = {
        [function] = [args],    -- Do tbl:function(args) if args is table, unpack it
        SetUserPlaced = true,   -- tbl:SetUserPlaced(true)
        SetMovable = true,      -- Also makes Frame Left-Draggable
        SetPoint = { "CENTER", UIParent, "CENTER", 0, 0 }, -- tbl:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

      * ESCClosable = true,     -- (Custom) Make Frame ESC-Closable
    }
    callbacks = {
        [event] = [script],     -- Do tbl:SetScript(event, script)
        OnEnter = function(...) Do something end,
    }

2. Manipulate Cell and Data
    tbl:SetTable(tbl)
    tbl:SetTableData(tbl)

    Sets text(shown) and data(hidden) from from 
    if nil, text = "" and data = nil

    tbl:SetRange(rows, cols, text)
    tbl:SetRangeData(rows, cols, data)
    tbl:SetRangeJustify(rows, cols, method)
    tbl:SetRangeOption(rows, cols, optiontbl)
    tbl:SetRangeCallback(rows, cols, callbacktbl)
    tbl:RangeFunction(rows, cols, function)

    'range' consists of rows and cols
    where rows/cols contains row/col numbers (table or one number)
    if rows = true, range become whole row
    if cols = true, range become whole column
    options and callbacks are like above
    But a cell is "FontSring", so options differ from above

3. Access certain cell by row and col
    tbl.tr[row].td[col] == _G[tbl:GetName().."Row"..row.."Col"..col]
]]

local library = "LibTable"
assert(LibStub, format("%s requires LibStub", library))

---@class LibTable
local lib, oldminor = LibStub:NewLibrary(library, 1)
if not lib then return end
oldminor = oldminor or 0

local DEFAULT_WIDTH = 32
local DEFAULT_HEIGHTS = 18
local DEFAULT_SIZE = {
    rows = 1,
    cols = 2,
    widths = DEFAULT_WIDTH,
    heights = DEFAULT_HEIGHTS,
}

lib.tables = lib.tables or { }

function LibTable_SetOption(tbl, options)
    tbl.ESCClosable = tbl.ESCClosable or function()
        table.insert(UISpecialFrames, tbl:GetName())
    end
    if options.SetMovable then
        tbl:SetScript("OnMouseDown", tbl.StartMoving)
        tbl:SetScript("OnMouseUp", tbl.StopMovingOrSizing)
    end
    for func, arg in pairs(options) do
        if type(arg) == "table" then
            tbl[func](tbl, unpack(arg))
        else
            tbl[func](tbl, arg)
        end
    end
    return tbl
end

function LibTable_Resize(tbl, size)
    tbl.size = size or tbl.size
    size.widths = size.widths or DEFAULT_WIDTH
    size.heights = size.heights or DEFAULT_HEIGHTS
    if type(size.widths) == "number" then size.widths = { size.widths } end
    if type(size.heights) == "number" then size.heights = { size.heights } end
    local name = tbl:GetName()
    size.borders = size.borders or { top = 4, right = 24, bottom = 8, left = 12 }
    local totalwidth = size.borders.left + size.borders.right
    local totalheight = size.borders.top + size.borders.bottom
    for row = 1, size.rows do
        size.heights[row] = size.heights[row] or size.heights[#size.heights]    -- last for rests
        totalheight = totalheight + size.heights[row]
    end
    for col = 1, size.cols do
        size.widths[col] = size.widths[col] or size.widths[#size.widths]    -- last for rests
        totalwidth = totalwidth + size.widths[col]
    end
    tbl:SetSize(totalwidth, totalheight)

    -- Consists of tr, td like HTML table
    tbl.tr = tbl.tr or {}
    for row = 1, size.rows do
        local tr = tbl.tr[row] or CreateFrame("Button", name.."Row"..row, tbl)
        tr:SetSize(1, size.heights[row])
        if row == 1 then    -- if 1st row
            tr:SetPoint("TOPLEFT", size.borders.left, - size.borders.top)
        else
            tr:SetPoint("TOPLEFT", tbl.tr[row-1], "BOTTOMLEFT")
        end
        tr.td = tr.td or {}
        local xoffset = 0
        for col = 1, size.cols do
            local td = tr.td[col] or tr:CreateFontString(tr:GetName().."Col"..col, "ARTWORK", "GameFontNormal")
            xoffset = xoffset + (size.widths[col-1] or 0)
            td:SetPoint("LEFT", xoffset, 0)
            td.row = row
            td.col = col
            tr.td[col] = td
        end
        tbl.tr[row] = tr
    end
    return tbl
end

function LibTable_SetCallback(tbl, callbacks)
    tbl.callbacks = callbacks
    for event, script in pairs(callbacks) do
        tbl:SetScript(event, script)
    end
    return tbl
end

function LibTable_SetTable(tbl, mode, vtbl)
    -- Data exceed range are clipped
    for row = 1, #tbl.tr do
        for col = 1, #tbl.tr[row].td do
            if mode == "value" then
                local value = vtbl[row] and vtbl[row][col]
                if value then   -- Nil DOESN'T change value
                    tbl.tr[row].td[col]:SetText(value)
                end
            elseif mode == "data" then
                -- Nil changes data
                tbl.tr[row].td[col].data = vtbl[row] and vtbl[row][col]
            end
        end
    end
end

function LibTable_SetTableData(tbl, itbl)
    -- Data exceed range are clipped
    for row = 1, #tbl.tr do
        for col = 1, #tbl.tr[row].td do
        end
    end
end

function LibTable_SetRange(tbl, mode, rows, cols, value)
    if type(rows) == "number" then rows = { rows } end
    if type(cols) == "number" then cols = { cols } end
    if type(rows) == "boolean" and rows then
        rows = {}
        for row = 1, tbl.size.rows do table.insert(rows, row) end
    end
    if type(cols) == "boolean" and cols then
        cols = {}
        for col = 1, tbl.size.cols do table.insert(cols, col) end
    end
    for _, row in pairs(rows) do
        for _, col in pairs(cols) do
            if row <= tbl.size.rows and col <= tbl.size.cols then
                local cell = tbl.tr[row].td[col]
                if mode == "text" then
                    if value then   -- nil DOESN'T change value
                        cell:SetText(value)
                    end
                elseif mode =="data" then
                    -- nil changes data
                    cell.data = value
                elseif mode == "callbacks" then
                    for event, script in pairs(value) do
                        cell:SetScript(event, script)
                    end
                elseif mode == "options" then
                    for func, arg in pairs(value) do
                        if type(arg) == "table" then
                            cell[func](cell, unpack(arg))
                        else
                            cell[func](cell, arg)
                        end
                    end
                elseif mode == "justify" then
                    LibTable_Cell_Justify(tbl, row, col, strlower(value))
                elseif mode == "functions" and type(value) == "function" then
                    value(tbl, cell)
                end
            end
        end
    end
    return tbl
end

function LibTable_Cell_Justify(tbl, row, col, method)
    local cell = tbl.tr[row].td[col]
    local xoffset = tbl.size.borders.left
    for c = 1, col do
        xoffset = xoffset + tbl.size.widths[c]
    end
    if method == "left" then
        cell:SetPoint("LEFT", xoffset, 0)
        cell:SetJustifyH("LEFT")
    elseif method == "center" then
        xoffset = xoffset + math.floor(tbl.size.widths[col] / 2)
        cell:SetPoint("CENTER", tbl.tr[row], "LEFT", xoffset, 0)
    elseif method == "right" then
        local totalwidth, _ = tbl:GetSize()
        xoffset = xoffset + tbl.size.widths[col]
        cell:SetPoint("RIGHT", totalwidth - tbl.size.borders.right - xoffset, 0)
        cell:SetJustifyH("RIGHT")
    end
end

---Create Table Instance
---
---@param name string
---@param parent table
---@param size table?
---@param options table<string, any>?
---@param callbacks table<string, any>?
---@return table
function lib:CreateTable(name, parent, size, options, callbacks)
    name = name or (library.."CustomTable"..(#lib.tables + 1))
    parent = parent or UIParent
    size = size or DEFAULT_SIZE
    options = options or {}
    callbacks = callbacks or {}
    local tbl = CreateFrame("Frame", name, parent, "TooltipBorderedFrameTemplate")

    tbl.Resize       =  function(...) return LibTable_Resize(...) end
    tbl.SetOption    =  function(...) return LibTable_SetOption(...) end
    tbl.SetCallback  =  function(...) return LibTable_SetCallback(...) end
    tbl.SetTable     =  function(stbl, vtbl) return LibTable_SetTable(stbl, "value", vtbl) end
    tbl.SetTableData =  function(stbl, dtbl) return LibTable_SetTable(stbl, "data", dtbl) end
    tbl.SetRange     =  function(stbl, rows, cols, text) return LibTable_SetRange(stbl, "text", rows, cols, text) end
    tbl.SetRangeData =  function(stbl, rows, cols, data) return LibTable_SetRange(stbl, "data", rows, cols, data) end
    tbl.SetRangeJustify = function(stbl, rows, cols, method) return LibTable_SetRange(stbl, "justify", rows, cols, method) end
    tbl.SetRangeOption = function(stbl, rows, cols, optiontbl) return LibTable_SetRange(stbl, "options", rows, cols, optiontbl) end
    tbl.SetRangeCallback = function(stbl, rows, cols, callbacktbl) return LibTable_SetRange(stbl, "callbacks", rows, cols, callbacktbl) end
    tbl.RangeFunction = function(stbl, rows, cols, func) return LibTable_SetRange(stbl, "functions", rows, cols, func) end

    tbl:Resize(size):SetOption(options):SetCallback(callbacks)

    table.insert(lib.tables, tbl)
    return tbl
end

function lib:Test()
    local test = self:CreateTable(library.."TestTable", UIParent, { rows = 4, cols = 5, widths = {24,64,32}, heights = 18 },
        { SetPoint = "CENTER", SetMovable = true, })
    test:SetTable({
        {"*",library,"Test","Table",""},
        {"a","|cffff3333b|r","c","d","e"},
        {1,2,3,4,5},
        {"가","나","다","라","마"},
    })
    test:Show()
    return test
end