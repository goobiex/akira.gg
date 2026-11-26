return function(fetchSource, compileSource)
    assert(type(fetchSource) == "function", "Pass your simulated client's authenticated GitHub fetch function")
    local compile = compileSource or loadstring
    assert(type(compile) == "function", "The simulated client must provide loadstring")

    local source = fetchSource(
        "https://api.github.com/repos/goobiex/akira.gg/contents/Akira.gg.lua.txt?ref=0d65fcb3e53b22acd6209171c813e2082b211dcd",
        {Accept = "application/vnd.github.raw+json"}
    )
    assert(type(source) == "string" and #source > 0, "Expected the raw Akira.gg source from GitHub")
    local chunk, compileError = compile(source, "Akira.gg")
    assert(type(chunk) == "function", compileError or "Could not compile Akira.gg")
    return chunk()
end
