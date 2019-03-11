
"Hard code study programs"
programs() = [:MIE,:Law,:Sociology]

"Hard Code course IDs"
function courses()
    course = ["$j$i" for j in ["FC","TC1","TC2","OP1"], i in 1:3]
    course = vcat(course[:], ["OP2$i" for i in 1:2]...)
    DataFrame(course_id = 1:length(course), course_name = course)
end


"return a dict where all slots in a week are the keys, and the the values indicate which day of the week. Notice that now courses are on day 3, i.e. wednesday."
function slots_week(n=20,k=4)
    d = OrderedDict{Int,String}()
    f = round(Int,n/k)
    for ik in 1:k
        for i in 1:f 
            d[i + (ik-1)*f] = ik > 2 ? Dates.dayname(ik + 1) : Dates.dayname(ik)
        end
    end
    d
end

function make_timesheet()
    dc = hcat(courses(), DataFrame(slot = [1,1,6,2,7,7,8,9,10,11,5,12,16,14]))
    d = hcat(DataFrame(program = repeat(programs(),inner=size(courses(),1) )), vcat(dc,dc,dc))
    sl = slots_week()
    dslots = DataFrame(slot = collect(keys(sl)), day = collect(values(sl)))
    join(d,dslots, on = :slot)
end


"""
    students_programs(;N=120)

Create a random dataset of student-program affilitions
"""
function students_programs(;N=120)
    w = rand(length(programs()))
    wgts = OrderedDict(zip(programs(),w ./ sum(w))) 
    labs = collect(keys(wgts))
    g = Categorical(collect(values(wgts)))   
    pr = labs[ rand(g, N) ]
    yr = rand(1:2,N)
    DataFrame(id = 1:N,program = pr, year = yr)

 
end

function make_students(n_courses;n=120)

    # list of students    
    s_prog = students_programs(N = n)

    # time slots of courses
    timesheet = make_timesheet()

    # conflicts of course times
    timesheet_c = timesheet_conflicts(timesheet)

    # output a dict
    s = Dict(i => 
                Student(n_courses,
                    preferences = spzeros(n_courses,n_courses),
                    program = s_prog[i,:program],
                    year = s_prog[i,:year],
                    constraints = Constraints(n_courses, conflicts = sparse(timesheet_c[s_prog[i,:program]])),
                    req_FC = 1,
                    req_TC = 2,
                    req_EL = 1,
                    budget = rand()*100
                    ) 
            for i in 1:n)
    s
end


"takes a timesheet and produces a sparse matrix with scheduling conflicts for each study program"
function timesheet_conflicts(ts::DataFrame)
    o = Dict()
    for p in programs()
        td = @where(ts, :program .== p)
        sl = td[:slot]
        tmp = zeros(Int,size(td,1),size(td,1))
        for i in 1:size(tmp,1)
            for j in 1:size(tmp,2)
                tmp[i,j] = sl[i] == sl[j] ? 1 : 0
            end
        end
        o[p] = tmp
    end
    return o
end


"""
# constraints 

`C` is the number of courses.

* `clash`: a sparse matrix C x C that flags with 1 if the ith element HAS a clash with jth element. 0 otherwise.
* `mandatory`: a vector C x 1. the i-th element is 1 if the course must be taken, 0 otherwise
* `notTCprogram`: a vector C x 1. the i-th element is 1 if the course is NOT in the TC of the students's program
* `notTCsemester`: a vector C x 1. the i-th element is 1 if the course is NOT in the TC of the students's semester
* `isTC`: a vector C x 1. the i-th element is 1 if the course IS in the TC of the students
* `notFCprogram`: a vector C x 1. the i-th element is 1 if the course is NOT in the FC of the students's program
* `notFCsemester`: a vector C x 1. the i-th element is 1 if the course is NOT in the FC of the students's semester
* `isFC`: a vector C x 1. the i-th element is 1 if the course IS in the FC of the students
* `notELprogram`: a vector C x 1. the i-th element is 1 if the course is NOT in the EL (electives) of the students's program
* `notELsemester`: a vector C x 1. the i-th element is 1 if the course is NOT in the EL of the students's semester
* `isEL`: a vector C x 1. the i-th element is 1 if the course IS in the EL of the students

"""
mutable struct Constraints
    clash         :: SparseMatrixCSC{Int,Int}
    mandatory     :: Vector{Bool}
    notTCprogram  :: Vector{Bool}
    notTCsemester :: Vector{Bool}
    isTC          :: Vector{Bool}
    notFCprogram  :: Vector{Bool}
    notFCsemester :: Vector{Bool}
    isFC          :: Vector{Bool}
    notELprogram  :: Vector{Bool}
    notELsemester :: Vector{Bool}
    isEL          :: Vector{Bool}
    function Constraints(n;conflicts = spzeros(n,n)) 
        this = new()
        this.clash = conflicts
        this.mandatory     = falses(n)
        this.notTCprogram  = falses(n)
        this.notTCsemester = falses(n)
        this.isTC          = falses(n)
        this.notFCprogram  = falses(n)
        this.notFCsemester = falses(n)
        this.isFC          = falses(n)
        this.notELprogram  = falses(n)
        this.notELsemester = falses(n)
        this.isEL          = falses(n)
        return this
    end
end

"random constraints"
function rand_constraints(N)
    if N<2
        error("N must be > 2")
    end
    clash = sparse(collect(1:2),collect(1:2),ones(Int,2),N,N)
    mandatory = rand([true false],N)
    notTCprogram = rand([true false false false false false],N)
    notTCsemester = rand([true false false false false false],N)
    isTC = rand([true false],N)
    notFCprogram = rand([true false false false false false],N)
    notFCsemester = rand([true false false false false false],N)
    isFC = rand([true false],N)
    notELprogram = rand([true false false false false false],N)
    notELsemester = rand([true false false false false false],N)
    isEL = rand([true false],N)
    return Constraints(clash,mandatory,notTCprogram,notTCsemester,isTC,notFCprogram,notFCsemester,isFC,notELprogram,notELsemester,isEL)
end


"""
# Student

## Fields

- `price` : a column vector of dimension C x 1, which i-th element is the price that was assigned to class i.
- `preferences` : an array containing S elements, and such that its n-th element is the (sparse) matrix representing student n preferences. Each of the matrices contained in that array should be a squared matrix of dimension C.
- `budget` : a column vector of dimension N x 1, which n-th element is the budget that was allocated to the n-th student.
- `constraints`: an instance of a [`Constraints`](@ref)
- `req_TC` : number of TC courses that the student is required to take
- `req_FC` : number of FC courses that the student is required to take
- `req_EL` : number of EL courses that the student is required to take
"""
mutable struct Student
    preferences :: SparseMatrixCSC{Int64, Int64}
    program :: Symbol
    year :: Int64
    constraints :: Constraints
    req_FC :: Int64
    req_TC :: Int64
    req_EL :: Int64
    budget :: Float64
    allocation :: Array{Int64,1}

    function Student(N = 10;preferences = spzeros(N,N),
                     program = :MIE,
                     year::Int = 1,
                     constraints = Constraints(N),
                     req_FC::Int = 1,
                     req_TC::Int = 2,
                     req_EL::Int = 1,
                     budget = rand()*100)
        new(
            preferences,
            program,
            year,
            constraints,
            req_FC,
            req_TC,
            req_EL,
            budget,
            zeros(N))
    end
end

