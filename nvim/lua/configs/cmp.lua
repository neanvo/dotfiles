local cmp = require("cmp")
local defaults = require("cmp.config.default")()
local luasnip = require("luasnip")

local function has_words_before()
	if vim.bo.buftype == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

return {
	preselect = cmp.PreselectMode.Item,
	sorting = defaults.sorting,
	completion = {
		completeopt = "menu,menuone",
	},
	experimental = {
		ghost_text = {
			hl_group = "Comment",
		},
	},
	window = {
		completion = {
			side_padding = 1,
			winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
			scrollbar = false,
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", priority = 50 },
		{ name = "path", priority = 40 },
		{ name = "luasnip", priority = 30 },
    { name = "crates", priority = 20 },
		{
			name = "lazydev",
			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
		},
	}, {
		{ name = "buffer", priority = 50, keyword_length = 3 },
		{
			name = "tmux",
			priority = 10,
			keyword_length = 3,
			option = { all_panes = true, label = "tmux" },
		},
	}),
	mapping = cmp.mapping.preset.insert({
		-- <CR> accepts currently selected item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					print(cmp.get_active_entry())
					cmp.confirm({ select = false })
				elseif cmp.visible() and not cmp.get_active_entry() then
					cmp.confirm({ select = true })
				else
					print(cmp.get_active_entry())
					fallback()
				end
			end,
			s = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			-- Do not set command mode, it will interfere with noice popmenu.
		}),
		["<S-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.select_next_item({ count = 5 }),
		["<C-u>"] = cmp.mapping.select_prev_item({ count = 5 }),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-c>"] = function(fallback)
			cmp.close()
			fallback()
		end,
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = function(entry, vim_item)
			local icons = require("configs.utils.icons")
			if entry.source.name == "git" then
				vim_item.kind = icons.git
			else
				local symbol = icons.kinds[vim_item.kind]
				if symbol ~= nil then
					vim_item.kind = symbol .. " " .. vim_item.kind
				end
			end

			return vim_item
		end,
	},
}
