local gmatch = string.gmatch
local concat = table.concat
local sub = string.sub
local rep = string.rep
local json = require "cjson.safe".encode

return function(tbl, linefeed, indent, after_colon)
    local s, err = json(tbl)
    if not s then
        return s, err
    end
    local i, j, k  = 1, 0, 0
    local r, p = {}, nil
    local lf = linefeed or "\n"
    local id = indent or "\t"
    local ac = after_colon or " "
    local al = sub(ac, -1) == "\n"
    for c in gmatch(s, ".") do
        if c == "{" then
            if p == ":" then
                r[i] = concat{ "{", lf }
            else
                r[i] = concat{ rep(id, j), "{", lf }
            end
            j = j + 1
        elseif c == "}" then
            j = j - 1
            if p == "{" then
                i = i - 1
                r[i] = concat{ rep(id, j), "{}" }
            else
                r[i] = concat{ lf, rep(id, j), "}" }
            end
        elseif c == "," then
            r[i] = concat{ ",", lf }
            k = -1
        elseif c == ":" then
            r[i] = concat{ ":", ac }
            if al then
                i = i + 1
                r[i] = rep(id, j)
            end
        elseif c == "[" then
            if p == ":" then
                r[i] = concat{ "[", lf }
            else
                r[i] = concat{ rep(id, j), "[", lf }
            end
            j = j + 1
        elseif c == "]" then
            j = j - 1
            if p == "[" then
                i = i - 1
                r[i] = concat{ rep(id, j), "[]" }
            else
                r[i] = concat{ lf, rep(id, j), "]" }
            end
        else
            if j ~= k then
                r[i] = concat{ rep(id, j) }
                i = i + 1
                k = j
            end
            r[i] = c
        end
        p = c
        i = i + 1
    end
    return concat(r)
end
