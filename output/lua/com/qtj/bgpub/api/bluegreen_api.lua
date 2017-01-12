-- 蓝绿发布 API 接口层.
--
-- Author: qintianjie
-- Date:   2017-01-05

local modulename = "api.bluegreen"
local _M = {}
_M._VERSION = '1.0.0'

local bluegreen_biz    = require("biz.bluegreen_biz")
local collection_utils = require("utils.collection_utils")
local config_base 	   = require("configbase")
local switch_enum      = config_base.switch_enum

-- 根据传入的 service_name ，从 redis 取相关规则数据，设置到 shared dict 中
-- conf = {["s_key":xxx]} : s_key ==> 传入的服务名，可以逗号分隔为多个
_M.ruleset = function ( self, conf )
	-- local service_keys = conf.s_key
	local ok, err = bluegreen_biz.ruleset(conf)
	return ok, err
end

_M.ruledelete = function ( self, conf )
	-- local service_keys = conf.s_key
	local ok, err = bluegreen_biz.ruledelete(conf)
	return ok, err
end

_M.switchupdate = function ( self, conf )
	if collection_utils.containKey(switch_enum, conf.switch_value) then
		local ok, err = bluegreen_biz.switchupdate(conf)
		return ok, err
	else
		return "-1", "switch value invalid."
	end
end


return _M