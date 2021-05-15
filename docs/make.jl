using Documenter, VarBCFiles

makedocs(sitename="VarBCFiles")

deploydocs(
    repo = "github.com/Hirlam/VarBCFiles.jl.git",
    devbranch = "main"
)
