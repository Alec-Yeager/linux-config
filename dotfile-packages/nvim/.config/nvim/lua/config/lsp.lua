local reference_timer = vim.uv.new_timer()
local reference_method = "textDocument/documentHighlight"

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
	callback = function(args)
		local buf = args.buf
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or not client:supports_method(reference_method) then
			return
		end

		-- Highlight the symbol under the cursor once the cursor has settled.
		-- Uses its own timer because lowering 'updatetime' would also make
		-- the nohlsearch package clear search highlights almost immediately.
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "InsertLeave", "BufLeave" }, {
			group = vim.api.nvim_create_augroup("my.lsp.references." .. buf, { clear = true }),
			buffer = buf,
			callback = function()
				vim.lsp.buf.clear_references()
				reference_timer:stop()
				reference_timer:start(
					150,
					0,
					vim.schedule_wrap(function()
						local still_here = vim.api.nvim_get_current_buf() == buf and vim.fn.mode() == "n"
						if still_here and #vim.lsp.get_clients({ bufnr = buf, method = reference_method }) > 0 then
							vim.lsp.buf.document_highlight()
						end
					end)
				)
			end,
		})
	end,
})
