---
-- php数组函数
-- @module php.array

--- 预定义常量
-- @table array
-- @field CASE_LOWER 用在`array_change_key_case()`中将数组的键名转换成小写字母。默认值
-- @field CASE_UPPER 用在`array_change_key_case()`中将数组的键名转换成大写字母
-- @field COUNT_NORMAL 用在 count() 中，不递归，默认值
-- @field COUNT_RECURSIVE 用在 count() 中递归计算数组元素

local array = {
    CASE_LOWER = 0,
    CASE_UPPER = 1,
    COUNT_NORMAL = 0,
    COUNT_RECURSIVE = 1,
}

--- 返回数组中部分的或所有的键名
-- @function array_keys
-- @param array 一个数组，包含了要返回的键
-- @param search_value 如果指定了这个参数，只有包含这些值的键才会返回
-- @param strict 判断在搜索的时候是否该使用严格的比较（===）
-- @return array
-- @todo 23参数待实现
function array:array_keys(array, search_value, strict)
    local result = {}
    for k, v in pairs(array) do
        table.insert(result, k)
    end
    return result
end

--- 返回字符串键名全为小写或大写的数组
-- @function array_change_key_case
-- @param input 需要操作的数组
-- @param case 可以在这里用两个常量，CASE_UPPER 或 CASE_LOWER（默认值）
-- @return array 返回一个键全是小写或者全是大写的数组；如果输入值（input）不是一个数组，那么返回false
function array:array_change_key_case(input, case)
    case = php:defaultValue(case, self.CASE_LOWER)
    local func
    if self.CASE_LOWER == case then func = string.lower end
    if self.CASE_UPPER == case then func = string.upper end
    local result = {}
    for k, v in pairs(input) do
        result[func(k)] = v
    end
    return result
end

--- 将一个数组分割成多个
-- @function array_chunk
-- @param input 需要操作的数组
-- @param size 每个数组的单元数目
-- @param preserve_keys 设为 true，保留输入数组中原来的键名。如果你指定了false，那每个结果数组将用从1开始的新数字索引。默认值是false
-- @return array 得到的数组是一个多维数组中的单元1，每一维包含了 size 个元素
-- @todo 如果最后一组不够size个，现在会被舍弃
function array:array_chunk(input, size, preserve_keys)
    local result = {}
    local count = 0
    local inside = {}
    preserve_keys = php:defaultValue(preserve_keys, false)
    for k, v in pairs(input) do
        count = count + 1
        if false == preserve_keys then
            table.insert(inside, v)
        else
            inside[k] = v
        end
        if count == size then
            table.insert(result, inside)
            count = 0
            inside = {}
        end
    end
    return result
end

--- 返回数组中指定的一列
-- @function array_column
-- @param input 需要取出数组列的多维数组（或结果集）
-- @param column_key 需要返回值的列，它可以是索引数组的列索引，或者是关联数组的列的键。 也可以是nil，此时将返回整个数组（配合index_key参数来重置数组键的时候，非常管用）
-- @param index_key 作为返回数组的索引/键的列，它可以是该列的整数索引，或者字符串键值
-- @return array 从多维数组中返回单列数组
function array:array_column(input, column_key, index_key)
    if nil == column_key then return input end
    local result = {}
    for i, row in pairs(input) do
        if not self:array_key_exists(column_key, row) then return {} end
        if nil == index_key then
            table.insert(result, row[column_key])
        else
            if nil == row[index_key] then return {} end
            result[row[index_key]] = row[column_key]
        end
    end
    return result
end

--- 创建一个数组，用一个数组的值作为其键名，另一个数组的值作为其值
-- @function array_combine
-- @param keys 将被作为新数组的键。非法的值将会被转换为字符串类型（string）
-- @param values 将被作为数组的值
-- @return array 返回合并的array，如果两个数组的单元数不同则返回false
function array:array_combine(keys, values)
    if #keys ~= #values then return false end
    local result = {}
    for i = 1, #keys do
        result[tostring(keys[i])] = values[i]
    end
    return result
end

--- 检查给定的键名或索引是否存在于数组中
-- @function array_key_exists
-- @param key 要检查的键
-- @param search 一个数组，包含待检查的键
-- @return array 成功时返回true， 或者在失败时返回false
function array:array_key_exists(key, search)
    local exist = false
    for k, v in pairs(search) do
        if k == key then
            exist = true
            break
        end
    end
    return exist
end

--- 计算数组中所有值的和
-- @function array_sum
-- @param array 输入的数组
-- @return array 所有值的和以整数或浮点数的结果返回，除了数字格式的字符串和数字，其他被认作0
function array:array_sum(array)
    local result = 0
    for k, v in pairs(array) do
        result = result + php:defaultValue(tonumber(v), 0)
    end
    return result
end

--- 计算数组中的单元数目或对象中的属性个数
-- @function count
-- @param var 数组或者对象
-- @param mode 如果可选的 mode 参数设为 COUNT_RECURSIVE（或 1），count() 将递归地对数组计数。对计算多维数组的所有单元尤其有用。mode 的默认值是 0。count() 识别不了无限递归
-- @return number 返回 var 中的单元数目
-- @todo 第二个参数暂未实现
function array:count(var, mode)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

return array
