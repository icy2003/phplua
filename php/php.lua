---
-- php函数lua化
--
-- - 实现了php里实用的函数
-- - php里类似于gettype（获取变量类型）这种函数，lua本身就有type，所以就不写了
-- - 有些函数对原来的（php里的）函数进行了扩展，或者为了适应lua而写，会对相应的地方做说明
-- - 使用方式：`php = require('php')`，然后你就可以按照下面的方式调用所有的函数
-- - 调用方式：如array模块里的array_keys函数：`php.array:array_keys(table)`
-- - 当前模块说明，这里的函数并不一定是php里的函数，可能只是我写的一些常用代码块
--
-- @module php
-- @author forsona
-- @license BSD-2
--

--- 本库拥有的模块
-- @table php
-- @field var var模块
-- @field array array模块
php   = php or {
    var = require('var'),
    array = require('array')
}
--- 为变量设置默认值
-- @function defaultValue
-- @param var 变量
-- @param defaultValue 默认值
-- @return var 如果var为nil，则var将被设置为defaultValue，并返回
function php:defaultValue(var, defaultValue)
    if nil == var then var = defaultValue end
    return var
end

-- test:
-- php.var:var_dump(php.array:count({'a',['aa']=3,1,1,1,2,3,4}))
return php
