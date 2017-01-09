---
-- php变量函数
-- @module php.var

local var = {}

--- 检测变量是否设置
-- @function isset
-- @param value 要检查的变量
-- @return boolean
-- @usage php.var:isset(a)
function var:isset(value)
    return not value == nil
end

--- 检查一个变量是否为空
-- @function empty
-- @param value 待检查的变量
-- @return boolean 区别于php：php里0表示false，但是lua里是true，所以，这里以if语句里的真假作为依据
function var:empty(value)
    return value == nil or value == false
end

--- 打印变量的相关信息
-- 后面两个参数是扩展的
-- @function var_dump
-- @param data 你要打印的变量
-- @param max_level 最大层级
-- @param prefix 前缀
function var:var_dump(data, max_level, prefix)
    if type(prefix) ~= "string" then
        prefix = ""
    end
    if type(data) ~= "table" then
        print(prefix .. tostring(data))
    else
        print(data)
        if max_level ~= 0 then
            local prefix_next = prefix .. "    "
            print(prefix .. "{")
            for k,v in pairs(data) do
                io.stdout:write(prefix_next .. k .. " = ")
                if type(v) ~= "table" or (type(max_level) == "number" and max_level <= 1) then
                    print(v)
                else
                    if max_level == nil then
                        self:var_dump(v, nil, prefix_next)
                    else
                        self:var_dump(v, max_level - 1, prefix_next)
                    end
                end
            end
            print(prefix .. "}")
        end
    end
end

return var

