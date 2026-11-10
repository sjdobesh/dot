return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
    -- stylua: ignore start
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<leader><up>", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<leader><down>", function() mc.lineAddCursor(1) end)
        set({"n", "x"}, "<leader><leader><up>", function() mc.lineSkipCursor(-1) end)
        set({"n", "x"}, "<leader><leader><down>", function() mc.lineSkipCursor(1) end)

        -- Add a new cursor by matching word/selection
        set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)
        set("n", "<c-leftdrag>", mc.handleMouseDrag)
        set("n", "<c-leftrelease>", mc.handleMouseRelease)

        -- Disable and enable cursors.
        set({"n", "x"}, "<leader><esc>", mc.toggleCursor)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            layerSet({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
            layerSet({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<left>", mc.prevCursor)
            layerSet({"n", "x"}, "<right>", mc.nextCursor)

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(1, "MultiCursorCursor", { reverse = true })
        hl(1, "MultiCursorVisual", { link = "Visual" })
        hl(1, "MultiCursorSign", { link = "SignColumn"})
        hl(1, "MultiCursorMatchPreview", { link = "Search" })
        hl(1, "MultiCursorDisabledCursor", { reverse = true })
        hl(1, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(1, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
,
}
