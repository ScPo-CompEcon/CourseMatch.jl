module CourseMatch

	VERSION = VersionNumber(0,0,2)

using JuMP, Cbc, CSV, DataFrames, SparseArrays, Dates
using DataStructures, Distributions, DataFramesMeta


# includes
include("student.jl")
include("demand.jl")

# exports




end # module
