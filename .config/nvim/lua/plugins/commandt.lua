return {
    {
        "wincent/command-t",
        main = "wincent.commandt",
        build = "cd lua/wincent/commandt/lib && make",
        init = function ()
            vim.g.CommandTPreferredImplementation = 'lua'
        end
    }
}
