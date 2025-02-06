local async = require("blink.cmp.lib.async")

local nerdfont_items
local config

---Include the trigger character when accepting a completion.
---@param context blink.cmp.Context
local function transform(items, context)
	return vim.tbl_map(function(entry)
		return vim.tbl_deep_extend("force", entry, {
			kind = require("blink.cmp.types").CompletionItemKind.Text,
			textEdit = {
				range = {
					start = { line = context.cursor[1] - 1, character = context.bounds.start_col - 2 },
					["end"] = { line = context.cursor[1] - 1, character = context.cursor[2] },
				},
			},
		})
	end, items)
end

---@type blink.cmp.Source
local M = {}

function M.new(opts)
	local self = setmetatable({}, { __index = M })
	config = vim.tbl_deep_extend("keep", opts or {}, {
		insert = true,
	})
	if not nerdfont_items then
		nerdfont_items = require("blink-nerdfont.items").get()
	end
	return self
end

---@param context blink.cmp.Context
function M:get_completions(context, callback)
	local task = async.task.empty():map(function()
		local is_char_trigger = vim.list_contains(
			self:get_trigger_characters(),
			context.line:sub(context.bounds.start_col - 1, context.bounds.start_col - 1)
		)
		callback({
			is_incomplete_forward = true,
			is_incomplete_backward = true,
			items = is_char_trigger and transform(nerdfont_items, context) or {},
			context = context,
		})
	end)
	return function()
		task:cancel()
	end
end

---`newText` is used for `ghost_text`, thus it is set to the nerdfont icon name.
---Change `newText` to the actual nerdfont icon when accepting a completion.
function M:resolve(item, callback)
	local resolved = vim.deepcopy(item)
	if config.insert then
		resolved.textEdit.newText = resolved.insertText
	end
	return callback(resolved)
end

function M:get_trigger_characters()
	return { ":" }
end

return M
