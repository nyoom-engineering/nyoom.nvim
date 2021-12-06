local present, neorg = pcall(require, "neorg")
if not present then
   return
end

neorg.setup {
   -- Tell Neorg what modules to load
   load = {
      ["core.defaults"] = {}, -- Load all the default modules
      ["core.norg.concealer"] = {}, -- Allows for use of icons
      ["core.norg.dirman"] = { -- Manage your directories with Neorg
         config = {
            workspaces = {
               my_workspace = "~/org/neorg",
            },
         },
      },
      ["core.norg.completion"] = {
         config = {
            engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
         },
      },
      ["core.keybinds"] = { -- Configure core.keybinds
         config = {
            default_keybinds = true, -- Generate the default keybinds
            neorg_leader = "<Leader>o", -- This is the default if unspecified
         },
      },
      ["core.integrations.telescope"] = {}, -- Enable the telescope module
   },
}
