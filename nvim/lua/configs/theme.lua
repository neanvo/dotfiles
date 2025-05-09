local M = {}

local theme = {
	base00 = "#292d3e",
	base01 = "#444267",
	base02 = "#32374d",
	base03 = "#676e95",
	base04 = "#8796b0",
	base05 = "#d3d3d3",
	base06 = "#efefef",
	base07 = "#ffffff",
	base08 = "#f07178",
	base09 = "#ffa282",
	base0A = "#ffcb6b",
	base0B = "#c3e88d",
	base0C = "#89ddff",
	base0D = "#82aaff",
	base0E = "#c792ea",
	base0F = "#ff5370",

	whiter_white = "#ffffff", -- custom
	white = "#d2e2fc", -- custom
	darker_black = "#232738",
	black = "#292D3E", --  nvim bg
	black2 = "#2f3344",
	one_bg = "#333748",
	one_bg2 = "#3c4051",
	one_bg3 = "#444859",
	grey = "#515566",
	grey_fg = "#5b5f70",
	grey_fg2 = "#65697a",
	light_grey = "#6d7182",
	red = "#f07178",
	baby_pink = "#606475",
	pink = "#ff5370", -- base16
	line = "#3f4354", -- for lines like vertsplit
	green = "#c3e88d", --base16
	dirty_green = "#5a6748",
	vibrant_green = "#96e88d", -- custom
	bg_green = "#203d2f",
	nord_blue = "#8fb7ff",
	blue = "#82aaff", -- base16
	dirty_blue = "#313f5c",
	yellow = "#ffcb6b", -- base16
	dirty_yellow = "#695c44",
	sun = "#ffd373",
	purple = "#c792ea", -- base16
	dark_purple = "#b383d2", --custom
	dark_purple2 = "#703696", --custom
	teal = "#89ffe6", -- custom
	orange = "#ffa282", -- base16
	cyan = "#89ddff", -- base16
	dirty_cyan = "#37505a",
	statusline_bg = "#2d3142",
	lightbg = "#3c4051",
	pmenu_bg = "#82aaff", -- custom
	folder_bg = "#82aaff",
}

M.theme = theme

M.setup = function()
	require("palenightfall").setup({
		color_overrides = {
			background = theme.black,
			foreground = theme.white,
			diff_add_background = theme.dirty_green,
			purple = theme.purple,
			orange = theme.orange,
		},
		highlight_overrides = {
			Boolean = { fg = theme.base09 },
			Character = { fg = theme.base08 },
			Conditional = { fg = theme.base0E },
			Constant = { fg = theme.base08 },
			Define = { fg = theme.base0E, sp = "none" },
			Delimiter = { fg = theme.base0F },
			Float = { fg = theme.base09 },
			Variable = { fg = theme.base05 },
			Function = { fg = theme.base0D },
			Identifier = { fg = theme.base08, sp = "none" },
			Include = { fg = theme.base0D },
			Keyword = { fg = theme.base0E },
			Label = { fg = theme.base0A },
			Number = { fg = theme.base09 },
			Operator = { fg = theme.base05, sp = "none" },
			PreProc = { fg = theme.base0A },
			Repeat = { fg = theme.base0A },
			Special = { fg = theme.base0C },
			SpecialChar = { fg = theme.base0F },
			Statement = { fg = theme.base08 },
			StorageClass = { fg = theme.base0A },
			String = { fg = theme.base0B },
			Structure = { fg = theme.base0E },
			Tag = { fg = theme.base0A },
			Todo = { fg = theme.base0A, bg = theme.base01 },
			Type = { fg = theme.base0A, sp = "none" },
			Typedef = { fg = theme.base0A },

			-- Treesitter
			["@variable"] = { fg = theme.base05 },
			["@variable.builtin"] = { fg = theme.base09 },
			["@variable.parameter"] = { fg = theme.base08 },
			["@variable.member"] = { fg = theme.base08 },
			["@variable.member.key"] = { fg = theme.base08 },

			["@module"] = { fg = theme.base08 },
			-- ["@module.builtin"] = { fg = theme.base08 },

			["@constant"] = { fg = theme.base08 },
			["@constant.builtin"] = { fg = theme.base09 },
			["@constant.macro"] = { fg = theme.base08 },

			["@string"] = { fg = theme.base0B },
			["@string.regex"] = { fg = theme.base0C },
			["@string.escape"] = { fg = theme.base0C },
			["@character"] = { fg = theme.base08 },
			-- ["@character.special"] = { fg = theme.base08 },
			["@number"] = { fg = theme.base09 },
			["@number.float"] = { fg = theme.base09 },

			["@annotation"] = { fg = theme.base0F },
			["@attribute"] = { fg = theme.base0A },
			["@error"] = { fg = theme.base08 },

			["@keyword.exception"] = { fg = theme.base08 },
			["@keyword"] = { fg = theme.base0E },
			["@keyword.function"] = { fg = theme.base0E },
			["@keyword.return"] = { fg = theme.base0E },
			["@keyword.operator"] = { fg = theme.base0E },
			["@keyword.import"] = { link = "Include" },
			["@keyword.conditional"] = { fg = theme.base0E },
			["@keyword.conditional.ternary"] = { fg = theme.base0E },
			["@keyword.repeat"] = { fg = theme.base0A },
			["@keyword.storage"] = { fg = theme.base0A },
			["@keyword.directive.define"] = { fg = theme.base0E },
			["@keyword.directive"] = { fg = theme.base0A },

			["@function"] = { fg = theme.base0D },
			["@function.builtin"] = { fg = theme.base0D },
			["@function.macro"] = { fg = theme.base08 },
			["@function.call"] = { fg = theme.base0D },
			["@function.method"] = { fg = theme.base0D },
			["@function.method.call"] = { fg = theme.base0D },
			["@constructor"] = { fg = theme.base0C },

			["@operator"] = { fg = theme.base05 },
			["@reference"] = { fg = theme.base05 },
			["@punctuation.bracket"] = { fg = theme.base0F },
			["@punctuation.delimiter"] = { fg = theme.base0F },
			["@symbol"] = { fg = theme.base0B },
			["@tag"] = { fg = theme.base0A },
			["@tag.attribute"] = { fg = theme.base08 },
			["@tag.delimiter"] = { fg = theme.base0F },
			["@text"] = { fg = theme.base05 },
			["@text.emphasis"] = { fg = theme.base09 },
			["@text.strike"] = { fg = theme.base0F, strikethrough = true },
			["@type.builtin"] = { fg = theme.base0A },
			["@definition"] = { sp = theme.base04, underline = true },
			["@scope"] = { bold = true },
			["@property"] = { fg = theme.base08 },

			-- markup
			["@markup.heading"] = { fg = theme.base0D },
			["@markup.raw"] = { fg = theme.base09 },
			["@markup.link"] = { fg = theme.base08 },
			["@markup.link.url"] = { fg = theme.base09, underline = true },
			["@markup.link.label"] = { fg = theme.base0C },
			["@markup.list"] = { fg = theme.base08 },
			["@markup.strong"] = { bold = true },
			["@markup.underline"] = { underline = true },
			["@markup.italic"] = { italic = true },
			["@markup.strikethrough"] = { strikethrough = true },
			["@markup.quote"] = { bg = theme.black2 },

			["@comment"] = { fg = theme.grey_fg },
			["@comment.todo"] = { fg = theme.grey, bg = theme.white },
			["@comment.warning"] = { fg = theme.black2, bg = theme.base09 },
			["@comment.note"] = { fg = theme.black, bg = theme.blue },
			["@comment.danger"] = { fg = theme.black2, bg = theme.red },

			["@diff.plus"] = { fg = theme.green },
			["@diff.minus"] = { fg = theme.red },
			["@diff.delta"] = { fg = theme.light_grey },

			-- LSP
			["@lsp.type.class"] = { link = "Structure" },
			["@lsp.type.decorator"] = { link = "Function" },
			["@lsp.type.enum"] = { link = "Type" },
			["@lsp.type.enumMember"] = { link = "Constant" },
			["@lsp.type.function"] = { link = "@function" },
			["@lsp.type.interface"] = { link = "Structure" },
			["@lsp.type.macro"] = { link = "@macro" },
			["@lsp.type.method"] = { link = "@function.method" },
			["@lsp.type.namespace"] = { link = "@module" },
			["@lsp.type.parameter"] = { link = "@variable.parameter" },
			["@lsp.type.property"] = { link = "@property" },
			["@lsp.type.struct"] = { link = "Structure" },
			["@lsp.type.type"] = { link = "@type" },
			["@lsp.type.typeParamater"] = { link = "TypeDef" },
			["@lsp.type.variable"] = { link = "@variable" },
			["@event"] = { fg = theme.base08 },
			["@modifier"] = { fg = theme.base08 },
			["@regexp"] = { fg = theme.base0F },

			Added = { fg = theme.green },
			Removed = { fg = theme.red },
			Changed = { fg = theme.yellow },
			MatchWord = { bg = theme.grey, fg = theme.white },
			Pmenu = { bg = theme.one_bg },
			PmenuSbar = { bg = theme.one_bg },
			PmenuSel = { bg = theme.pmenu_bg, fg = theme.black },
			PmenuThumb = { bg = theme.grey },
			MatchParen = { link = "MatchWord" },
			Comment = { fg = theme.grey_fg },
			CursorLineNr = { fg = theme.white },
			LineNr = { fg = theme.grey },
			FloatBorder = { fg = theme.blue },
			FloatTitle = { fg = theme.white, bg = theme.grey },
			NormalFloat = { bg = theme.darker_black },
			NvimInternalError = { fg = theme.red },
			WinSeparator = { fg = theme.line },
			Normal = { fg = theme.base05, bg = theme.base00 },
			DevIconDefault = { fg = theme.red },
			Bold = { bold = true },
			Debug = { fg = theme.base08 },
			Directory = { fg = theme.base0D },
			Error = { fg = theme.base00, bg = theme.base08 },
			ErrorMsg = { fg = theme.base08, bg = theme.base00 },
			Exception = { fg = theme.base08 },
			FoldColumn = { fg = theme.base0C, bg = theme.base01 },
			Folded = { fg = theme.light_grey, bg = theme.black2 },
			IncSearch = { fg = theme.base01, bg = theme.base09 },
			Italic = { italic = true },
			Macro = { fg = theme.base08 },
			ModeMsg = { fg = theme.base0B },
			MoreMsg = { fg = theme.base0B },
			Question = { fg = theme.base0D },
			Search = { fg = theme.base01, bg = theme.base0A },
			Substitute = { fg = theme.base01, bg = theme.base0A, sp = "none" },
			SpecialKey = { fg = theme.base03 },
			TooLong = { fg = theme.base08 },
			UnderLined = { underline = true },
			Visual = { bg = theme.base02 },
			VisualNOS = { fg = theme.base08 },
			WarningMsg = { fg = theme.base08 },
			WildMenu = { fg = theme.base08, bg = theme.base0A },
			Title = { fg = theme.base0D, sp = "none" },
			Conceal = { bg = "NONE" },
			Cursor = { fg = theme.base00, bg = theme.base05 },
			NonText = { fg = theme.base03 },
			SignColumn = { fg = theme.base03, sp = "NONE" },
			ColorColumn = { bg = theme.black2 },
			CursorColumn = { bg = theme.base01, sp = "none" },
			CursorLine = { bg = theme.black2 },
			QuickFixLine = { bg = theme.base01, sp = "none" },
			SpellBad = { undercurl = true, sp = theme.base08 },
			SpellLocal = { undercurl = true, sp = theme.base0C },
			SpellCap = { undercurl = true, sp = theme.base0D },
			SpellRare = { undercurl = true, sp = theme.base0E },
			healthSuccess = { bg = theme.green, fg = theme.black },
			LazyH1 = { bg = theme.green, fg = theme.black },
			LazyButton = { bg = theme.one_bg, fg = theme.light_grey },
			LazyH2 = { fg = theme.red, bold = true, underline = true },
			LazyReasonPlugin = { fg = theme.red },
			LazyValue = { fg = theme.teal },
			LazyDir = { fg = theme.base05 },
			LazyUrl = { fg = theme.base05 },
			LazyCommit = { fg = theme.green },
			LazyNoCond = { fg = theme.red },
			LazySpecial = { fg = theme.blue },
			LazyReasonFt = { fg = theme.purple },
			LazyOperator = { fg = theme.white },
			LazyReasonKeys = { fg = theme.teal },
			LazyTaskOutput = { fg = theme.white },
			LazyCommitIssue = { fg = theme.pink },
			LazyReasonEvent = { fg = theme.yellow },
			LazyReasonStart = { fg = theme.white },
			LazyReasonRuntime = { fg = theme.nord_blue },
			LazyReasonCmd = { fg = theme.sun },
			LazyReasonSource = { fg = theme.cyan },
			LazyReasonImport = { fg = theme.white },
			LazyProgressDone = { fg = theme.green },

			CmpItemAbbr = { fg = theme.white },
			CmpItemAbbrMatch = { fg = theme.blue, bold = true },
			CmpDoc = { bg = theme.darker_black },
			CmpDocBorder = { fg = theme.dark_purple, bg = "NONE" },
			CmpPmenu = { bg = theme.black2 },
			CmpSel = { link = "PmenuSel", bold = true },
			CmpItemKindConstant = { fg = theme.base09 },
			CmpItemKindFunction = { fg = theme.base0D },
			CmpItemKindIdentifier = { fg = theme.base08 },
			CmpItemKindField = { fg = theme.base08 },
			CmpItemKindVariable = { fg = theme.base0E },
			CmpItemKindSnippet = { fg = theme.red },
			CmpItemKindText = { fg = theme.base0B },
			CmpItemKindStructure = { fg = theme.base0E },
			CmpItemKindType = { fg = theme.base0A },
			CmpItemKindKeyword = { fg = theme.base07 },
			CmpItemKindMethod = { fg = theme.base0D },
			CmpItemKindConstructor = { fg = theme.blue },
			CmpItemKindFolder = { fg = theme.base07 },
			CmpItemKindModule = { fg = theme.base0A },
			CmpItemKindProperty = { fg = theme.base08 },
			CmpItemKindEnum = { fg = theme.blue },
			CmpItemKindUnit = { fg = theme.base0E },
			CmpItemKindClass = { fg = theme.teal },
			CmpItemKindFile = { fg = theme.base07 },
			CmpItemKindInterface = { fg = theme.green },
			CmpItemKindColor = { fg = theme.white },
			CmpItemKindReference = { fg = theme.base05 },
			CmpItemKindEnumMember = { fg = theme.purple },
			CmpItemKindStruct = { fg = theme.base0E },
			CmpItemKindValue = { fg = theme.cyan },
			CmpItemKindEvent = { fg = theme.yellow },
			CmpItemKindOperator = { fg = theme.base05 },
			CmpItemKindTypeParameter = { fg = theme.base08 },
			CmpItemKindCopilot = { fg = theme.green },
			CmpItemKindCodeium = { fg = theme.vibrant_green },
			CmpItemKindTabNine = { fg = theme.baby_pink },
			CmpItemKindSuperMaven = { fg = theme.yellow },
			CmpItemMenu = { fg = theme.light_grey, italic = true },

			IblIndent = { fg = theme.one_bg2 },
			IblWhitespace = { fg = theme.line },

			DevIconc = { fg = theme.blue },
			DevIconcss = { fg = theme.blue },
			DevIcondeb = { fg = theme.cyan },
			DevIconDockerfile = { fg = theme.cyan },
			DevIconhtml = { fg = theme.baby_pink },
			DevIconjpeg = { fg = theme.dark_purple },
			DevIconjpg = { fg = theme.dark_purple },
			DevIconjs = { fg = theme.sun },
			DevIconkt = { fg = theme.orange },
			DevIconlock = { fg = theme.red },
			DevIconlua = { fg = theme.blue },
			DevIconmp3 = { fg = theme.white },
			DevIconmp4 = { fg = theme.white },
			DevIconout = { fg = theme.white },
			DevIconpng = { fg = theme.dark_purple },
			DevIconpy = { fg = theme.cyan },
			DevIcontoml = { fg = theme.blue },
			DevIconts = { fg = theme.teal },
			DevIconttf = { fg = theme.white },
			DevIconrb = { fg = theme.pink },
			DevIconrpm = { fg = theme.orange },
			DevIconvue = { fg = theme.vibrant_green },
			DevIconwoff = { fg = theme.white },
			DevIconwoff2 = { fg = theme.white },
			DevIconxz = { fg = theme.sun },
			DevIconzip = { fg = theme.sun },
			DevIconZig = { fg = theme.orange },
			DevIconMd = { fg = theme.blue },
			DevIconTSX = { fg = theme.blue },
			DevIconJSX = { fg = theme.blue },
			DevIconSvelte = { fg = theme.red },
			DevIconJava = { fg = theme.orange },
			DevIconDart = { fg = theme.cyan },

			diffOldFile = { fg = theme.baby_pink },
			diffNewFile = { fg = theme.blue },
			DiffAdd = { fg = theme.blue },
			DiffAdded = { fg = theme.green },
			DiffChange = { fg = theme.light_grey },
			DiffChangeDelete = { fg = theme.red },
			DiffModified = { fg = theme.orange },
			DiffDelete = { fg = theme.red },
			DiffRemoved = { fg = theme.red },
			DiffText = { fg = theme.white, bg = theme.black2 },

			gitcommitOverflow = { fg = theme.base08 },
			gitcommitSummary = { fg = theme.base0B },
			gitcommitComment = { fg = theme.base03 },
			gitcommitUntracked = { fg = theme.base03 },
			gitcommitDiscarded = { fg = theme.base03 },
			gitcommitSelected = { fg = theme.base03 },
			gitcommitHeader = { fg = theme.base0E },
			gitcommitSelectedType = { fg = theme.base0D },
			gitcommitUnmergedType = { fg = theme.base0D },
			gitcommitDiscardedType = { fg = theme.base0D },
			gitcommitBranch = { fg = theme.base09, bold = true },
			gitcommitUntrackedFile = { fg = theme.base0A },
			gitcommitUnmergedFile = { fg = theme.base08, bold = true },
			gitcommitDiscardedFile = { fg = theme.base08, bold = true },
			gitcommitSelectedFile = { fg = theme.base0B, bold = true },

			LeapLabel = { fg = theme.black, bg = theme.purple, bold = true, nocombine = true },

			LspReferenceText = { fg = theme.darker_black, bg = theme.white },
			LspReferenceRead = { fg = theme.darker_black, bg = theme.white },
			LspReferenceWrite = { fg = theme.darker_black, bg = theme.white },
			DiagnosticHint = { fg = theme.purple },
			DiagnosticError = { fg = theme.red },
			DiagnosticWarn = { fg = theme.yellow },
			DiagnosticInfo = { fg = theme.green },
			LspSignatureActiveParameter = { fg = theme.black, bg = theme.green },
			RenamerTitle = { fg = theme.black, bg = theme.red },
			RenamerBorder = { fg = theme.red },
			LspInlayHint = { bg = theme.black2, fg = theme.light_grey },

			SagaBorder = { fg = theme.purple, bg = theme.darker_black },
			SagaNormal = { bg = theme.darker_black },

			MasonHeader = { bg = theme.red, fg = theme.black },
			MasonHighlight = { fg = theme.blue },
			MasonHighlightBlock = { fg = theme.black, bg = theme.green },
			MasonHighlightBlockBold = { link = "MasonHighlightBlock" },
			MasonHeaderSecondary = { link = "MasonHighlightBlock" },
			MasonMuted = { fg = theme.light_grey },
			MasonMutedBlock = { fg = theme.light_grey, bg = theme.one_bg },

			-- Neogit
			NeogitGraphAuthor = { fg = theme.orange },
			NeogitGraphRed = { fg = theme.red },
			NeogitGraphWhite = { fg = theme.white },
			NeogitGraphYellow = { fg = theme.yellow },
			NeogitGraphGreen = { fg = theme.green },
			NeogitGraphCyan = { fg = theme.cyan },
			NeogitGraphBlue = { fg = theme.blue },
			NeogitGraphPurple = { fg = theme.purple },
			NeogitGraphGray = { fg = theme.grey },
			NeogitGraphOrange = { fg = theme.orange },
			NeogitGraphBoldOrange = { fg = theme.orange, bold = true },
			NeogitGraphBoldRed = { fg = theme.red, bold = true },
			NeogitGraphBoldWhite = { fg = theme.white, bold = true },
			NeogitGraphBoldYellow = { fg = theme.yellow, bold = true },
			NeogitGraphBoldGreen = { fg = theme.green, bold = true },
			NeogitGraphBoldCyan = { fg = theme.cyan, bold = true },
			NeogitGraphBoldBlue = { fg = theme.blue, bold = true },
			NeogitGraphBoldPurple = { fg = theme.purple, bold = true },
			NeogitGraphBoldGray = { fg = theme.grey, bold = true },

			NeogitHunkMergeHeader = { fg = theme.black2, bg = theme.grey, bold = true },
			NeogitHunkMergeHeaderHighlight = { fg = theme.black, bg = theme.cyan, bold = true },
			NeogitHunkMergeHeaderCursor = { fg = theme.black, bg = theme.cyan, bold = true },
			NeogitHunkHeader = { fg = theme.black, bg = theme.grey, bold = true },
			NeogitHunkHeaderHighlight = { fg = theme.black, bg = theme.dark_purple, bold = true },
			NeogitHunkHeaderCursor = { fg = theme.black, bg = theme.dark_purple, bold = true },

			NeogitDiffContext = { bg = theme.one_bg },
			NeogitDiffContextHighlight = { bg = theme.black2 },
			NeogitDiffContextCursor = { bg = theme.one_bg },
			NeogitDiffAdditions = { fg = theme.green },
			NeogitDiffAdd = { fg = theme.green, bg = theme.green },
			NeogitDiffAddHighlight = { fg = theme.green, bg = theme.green },
			NeogitDiffAddCursor = { bg = theme.one_bg, fg = theme.green },
			NeogitDiffDeletions = { fg = theme.red },
			NeogitDiffDelete = { bg = theme.red, fg = theme.red },
			NeogitDiffDeleteHighlight = { bg = theme.red, fg = theme.red },
			NeogitDiffDeleteCursor = { bg = theme.one_bg, fg = theme.red },

			NeogitPopupSwitchKey = { fg = theme.purple },
			NeogitPopupOptionKey = { fg = theme.purple },
			NeogitPopupConfigKey = { fg = theme.purple },
			NeogitPopupActionKey = { fg = theme.purple },

			NeogitFilePath = { fg = theme.blue, italic = true },
			NeogitCommitViewHeader = { bg = theme.cyan, fg = theme.black },
			NeogitDiffHeader = { bg = theme.one_bg2, fg = theme.blue, bold = true },
			NeogitDiffHeaderHighlight = { bg = theme.one_bg2, fg = theme.orange, bold = true },
			NeogitBranch = { fg = theme.blue, bold = true },
			NeogitBranchHead = { fg = theme.blue, bold = true, underline = true },
			NeogitRemote = { fg = theme.green, bold = true },
			NeogitUnmergedInto = { fg = theme.purple, bold = true },
			NeogitUnpushedTo = { fg = theme.purple, bold = true },
			NeogitUnpulledFrom = { fg = theme.purple, bold = true },

			NeogitChangeModified = { fg = theme.blue, bold = true, italic = true },
			NeogitChangeAdded = { fg = theme.green, bg = theme.green, bold = true, italic = true },
			NeogitChangeDeleted = { fg = theme.red, bold = true, italic = true },
			NeogitChangeRenamed = { fg = theme.purple, bold = true, italic = true },
			NeogitChangeUpdated = { fg = theme.orange, bold = true, italic = true },
			NeogitChangeCopied = { fg = theme.cyan, bold = true, italic = true },
			NeogitChangeUnmerged = { fg = theme.yellow, bold = true, italic = true },
			NeogitChangeNewFile = { fg = theme.green, bold = true, italic = true },
			NeogitSectionHeader = { fg = theme.red, bold = true },

			NeogitTagName = { fg = theme.yellow },
			NeogitTagDistance = { fg = theme.cyan },
			NeogitFloatHeader = { bg = theme.black, bold = true },
			NeogitFloatHeaderHighlight = { bg = theme.black2, fg = theme.cyan, bold = true },

			NotifyERRORBorder = { fg = theme.red },
			NotifyERRORIcon = { fg = theme.red },
			NotifyERRORTitle = { fg = theme.red },
			NotifyWARNBorder = { fg = theme.orange },
			NotifyWARNIcon = { fg = theme.orange },
			NotifyWARNTitle = { fg = theme.orange },
			NotifyINFOBorder = { fg = theme.green },
			NotifyINFOIcon = { fg = theme.green },
			NotifyINFOTitle = { fg = theme.green },
			NotifyDEBUGBorder = { fg = theme.grey },
			NotifyDEBUGIcon = { fg = theme.grey },
			NotifyDEBUGTitle = { fg = theme.grey },
			NotifyTRACEBorder = { fg = theme.purple },
			NotifyTRACEIcon = { fg = theme.purple },
			NotifyTRACETitle = { fg = theme.purple },

			NvimTreeEmptyFolderName = { fg = theme.folder_bg },
			NvimTreeEndOfBuffer = { fg = theme.darker_black },
			NvimTreeFolderIcon = { fg = theme.folder_bg },
			NvimTreeFolderName = { fg = theme.folder_bg },
			NvimTreeFolderArrowOpen = { fg = theme.folder_bg },
			NvimTreeFolderArrowClosed = { fg = theme.grey_fg },
			NvimTreeGitDirty = { fg = theme.red },
			NvimTreeIndentMarker = { fg = theme.one_bg2 },
			NvimTreeNormal = { bg = theme.darker_black },
			NvimTreeNormalNC = { bg = theme.darker_black },
			NvimTreeOpenedFolderName = { fg = theme.folder_bg },
			NvimTreeGitIgnored = { fg = theme.light_grey },
			NvimTreeWinSeparator = { fg = theme.darker_black, bg = theme.darker_black },
			NvimTreeWindowPicker = { fg = theme.red, bg = theme.black2 },
			NvimTreeCursorLine = { bg = theme.black },
			NvimTreeGitNew = { fg = theme.yellow },
			NvimTreeGitDeleted = { fg = theme.red },
			NvimTreeSpecialFile = { fg = theme.yellow, bold = true },
			NvimTreeRootFolder = { fg = theme.red, bold = true },

			TabLineSel = { fg = theme.black, bg = theme.purple, bold = true },
			TabLine = { fg = theme.white_white },
			TabLineFill = { bg = theme.black },
			TabLineWin = { fg = theme.white, bg = theme.lightbg },

			RainbowDelimiterRed = { fg = theme.red },
			RainbowDelimiterYellow = { fg = theme.yellow },
			RainbowDelimiterBlue = { fg = theme.blue },
			RainbowDelimiterOrange = { fg = theme.orange },
			RainbowDelimiterGreen = { fg = theme.green },
			RainbowDelimiterViolet = { fg = theme.purple },
			RainbowDelimiterCyan = { fg = theme.cyan },

			RenderMarkdownH1Bg = { fg = theme.blue, bg = theme.dirty_blue, bold = true },
			RenderMarkdownH2Bg = { fg = theme.yellow, bg = theme.dirty_yellow, bold = true },
			RenderMarkdownH3Bg = { fg = theme.green, bg = theme.dirty_green, bold = true },
			RenderMarkdownH4Bg = { fg = theme.cyan, bg = theme.dirty_cyan, bold = true },

			TelescopePromptPrefix = { fg = theme.red, bg = theme.black },
			TelescopeSelection = { bg = theme.black2, fg = theme.white },
			TelescopeResultsDiffAdd = { fg = theme.green },
			TelescopeResultsDiffChange = { fg = theme.yellow },
			TelescopeResultsDiffDelete = { fg = theme.red },
			TelescopeMatching = { bg = theme.one_bg, fg = theme.blue },

			TodoBgFix = { fg = theme.black2, bg = theme.red, bold = true },
			TodoBgHack = { fg = theme.black2, bg = theme.orange, bold = true },
			TodoBgNote = { fg = theme.black2, bg = theme.white, bold = true },
			TodoBgPerf = { fg = theme.black2, bg = theme.purple, bold = true },
			TodoBgTest = { fg = theme.black2, bg = theme.purple, bold = true },
			TodoBgTodo = { fg = theme.black2, bg = theme.yellow, bold = true },
			TodoBgWarn = { fg = theme.orange, bold = true },
			TodoFgFix = { fg = theme.red },
			TodoFgHack = { fg = theme.orange },
			TodoFgNote = { fg = theme.white },
			TodoFgPerf = { fg = theme.purple },
			TodoFgTest = { fg = theme.purple },
			TodoFgTodo = { fg = theme.yellow },
			TodoFgWarn = { fg = theme.orange },
			TodoSignFix = { link = "TodoFgFix" },
			TodoSignHack = { link = "TodoFgHack" },
			TodoSignNote = { link = "TodoFgNote" },
			TodoSignPerf = { link = "TodoFgPerf" },
			TodoSignTest = { link = "TodoFgTest" },
			TodoSignTodo = { link = "TodoFgTodo" },
			TodoSignWarn = { link = "TodoFgWarn" },

			TroubleCount = { fg = theme.pink },
			TroubleCode = { fg = theme.white },
			TroubleWarning = { fg = theme.orange },
			TroubleSignWarning = { link = "DiagnosticWarn" },
			TroubleTextWarning = { fg = theme.white },
			TroublePreview = { fg = theme.red },
			TroubleSource = { fg = theme.cyan },
			TroubleSignHint = { link = "DiagnosticHint" },
			TroubleTextHint = { fg = theme.white },
			TroubleHint = { fg = theme.orange },
			TroubleSignOther = { link = "DiagnosticNormal" },
			TroubleSignInformation = { fg = theme.white },
			TroubleTextInformation = { fg = theme.white },
			TroubleInformation = { fg = theme.white },
			TroubleError = { fg = theme.red },
			TroubleTextError = { fg = theme.white },
			TroubleSignError = { link = "DiagnosticError" },
			TroubleText = { fg = theme.white },
			TroubleFile = { fg = theme.yellow },
			TroubleFoldIcon = { link = "Folded" },
			TroubleNormal = { fg = theme.white },
			TroubleLocation = { fg = theme.red },
			TroubleIndent = { link = theme.Comment },

			CodeActionMenuWarningMessageText = { fg = theme.white },
			CodeActionMenuWarningMessageBorder = { fg = theme.red },
			CodeActionMenuMenuIndex = { fg = theme.blue },
			CodeActionMenuMenuKind = { fg = theme.green },
			CodeActionMenuMenuTitle = { fg = theme.white },
			CodeActionMenuMenuDisabled = { link = "Comment" },
			CodeActionMenuMenuSelection = { fg = theme.blue },
			CodeActionMenuDetailsTitle = { fg = theme.white },
			CodeActionMenuDetailsLabel = { fg = theme.yellow },
			CodeActionMenuDetailsPreferred = { fg = theme.green },
			CodeActionMenuDetailsDisabled = { link = "Comment" },
			CodeActionMenuDetailsUndefined = { link = "Comment" },

			-- Dap
			DapBreakpoint = { fg = theme.red },
			DapBreakpointCondition = { fg = theme.yellow },
			DapLogPoint = { fg = theme.cyan },
			DapStopped = { fg = theme.baby_pink },

			-- DapUI
			DAPUIScope = { fg = theme.cyan },
			DAPUIType = { fg = theme.dark_purple },
			DAPUIValue = { fg = theme.cyan },
			DAPUIVariable = { fg = theme.white },
			DapUIModifiedValue = { fg = theme.orange },
			DapUIDecoration = { fg = theme.cyan },
			DapUIThread = { fg = theme.green },
			DapUIStoppedThread = { fg = theme.cyan },
			DapUISource = { fg = theme.lavender },
			DapUILineNumber = { fg = theme.cyan },
			DapUIFloatBorder = { fg = theme.cyan },

			DapUIWatchesEmpty = { fg = theme.baby_pink },
			DapUIWatchesValue = { fg = theme.green },
			DapUIWatchesError = { fg = theme.baby_pink },

			DapUIBreakpointsPath = { fg = theme.cyan },
			DapUIBreakpointsInfo = { fg = theme.green },
			DapUIBreakPointsCurrentLine = { fg = theme.green, bold = true },
			DapUIBreakpointsDisabledLine = { fg = theme.grey_fg2 },

			DapUIStepOver = { fg = theme.blue },
			DapUIStepOverNC = { fg = theme.blue },
			DapUIStepInto = { fg = theme.blue },
			DapUIStepIntoNC = { fg = theme.blue },
			DapUIStepBack = { fg = theme.blue },
			DapUIStepBackNC = { fg = theme.blue },
			DapUIStepOut = { fg = theme.blue },
			DapUIStepOutNC = { fg = theme.blue },
			DapUIStop = { fg = theme.red },
			DapUIStopNC = { fg = theme.red },
			DapUIPlayPause = { fg = theme.green },
			DapUIPlayPauseNC = { fg = theme.green },
			DapUIRestart = { fg = theme.green },
			DapUIRestartNC = { fg = theme.green },
			DapUIUnavailable = { fg = theme.grey_fg },
			DapUIUnavailableNC = { fg = theme.grey_fg },

			BubenName = { fg = theme.green, bg = theme.lightbg },
			BubenChain = { fg = theme.blue, bg = theme.lightbg },
			BubenSeparator = { fg = theme.base05, bg = theme.lightbg },
			BubenTitle = { fg = theme.blue, bg = theme.lightbg },

			WhichKey = { fg = theme.blue },
			WhichKeySeparator = { fg = theme.light_grey },
			WhichKeyDesc = { fg = theme.red },
			WhichKeyGroup = { fg = theme.green },
			WhichKeyValue = { fg = theme.green },
		},
	})
end

return M
