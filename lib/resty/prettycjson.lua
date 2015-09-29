local json = require "cjson.safe".encode
local concat = table.concat
local sub = string.sub
local rep = string.rep
return function(tbl, lf, id, ac)
    local s, e = json(tbl)
    if not s then return s, e end
    lf, id, ac = lf or "\n", id or "\t", ac or " "
    local i, j, k, r, p, q  = 1, 0, 0, {}, nil, nil
    local al = sub(ac, -1) == "\n"
    local n = #s
    for x = 1, n do
        local c = sub(s, x, x)
        if not q and (c == "{" or c == "[") then
            r[i] = p == ":" and concat{ c, lf } or concat{ rep(id, j), c, lf }
            j = j + 1
        elseif not q and (c == "}" or c == "]") then
            j = j - 1
            if p == "{" or p == "[" then
                i = i - 1
                r[i] = concat{ rep(id, j), p, c }
            else
                r[i] = concat{ lf, rep(id, j), c }
            end
        elseif not q and c == "," then
            r[i] = concat{ c, lf }
            k = -1
        elseif not q and c == ":" then
            r[i] = concat{ c, ac }
            if al then
                i = i + 1
                r[i] = rep(id, j)
            end
        else
            if c == '"' or c == "'" then
                if p ~= "\\" then
                    if q == c then
                        q = nil
                    elseif not q then
                        q = c
                    end
                end
            end
            if j ~= k then
                r[i] = rep(id, j)
                i, k = i + 1, j
            end
            r[i] = c
        end
        p, i = c, i + 1
    end
    return concat(r)
end
