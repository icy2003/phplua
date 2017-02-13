---
-- php字符串函数
-- @module php.string

--- 使用一个字符串分割另一个字符串
-- @function defaultValue
-- @param delimiter 边界上的分隔字符
-- @param string 输入的字符串
-- @param limit
--
-- - 如果设置了 limit 参数并且是正数，则返回的数组包含最多 limit 个元素，而最后那个元素将包含 string 的剩余部分。
-- - 如果 limit 参数是负数，则返回除了最后的 -limit 个元素外的所有元素。
-- - 如果 limit 是 0，则会被当做 1
--
-- @return array 此函数返回由字符串组成的数组，每个元素都是 string 的一个子串，它们被字符串 delimiter 作为边界点分割出来
function string:explode(delimiter, string, limit)
    input = tostring(string)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    if nil == limit then return arr end
    limit = math.floor(limit)
    if 0 == limit then limit = 1 end
    local result = {}
    for index, part in ipairs(arr)
        if 0 < limit and index <= limit then table.insert(result, part) end
        if 0 > limit and index >= #arr - limit then table.insert(result, part) end
    end
    return result
end

return string
