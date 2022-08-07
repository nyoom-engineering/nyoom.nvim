FENNEL_COMPILER = [[hotpot]]
if FENNEL_COMPILER == [[hotpot]] then
    require [[hotpot]].setup()
    require [[init]]
elseif FENNEL_COMPILER == [[aniseed]] then
    require [[impatient]]
    vim.g["aniseed#env"] = true
else
    error [[Unknown compiler]]
end
