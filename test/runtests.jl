using CourseMatch
using Test

@testset "create students" begin

	k = 3
	n = 1
	stds = CourseMatch.make_students(3,n = n)  # k courses, 1 student
	@test length(stds) == 1
	@test stds[1].allocation == zeros(Int,k)


end

@testset "clearing errors" begin
	x = [1 0 1;
	     1 0 1;
	     1 0 1;
	     0 0 1;
	     1 1 0;
	     1 1 1]
	q = [4; 3; 3]
	p = [30; 0; 50]
	@test z(x,q,p) == sqrt(5)
end


# @testset "demand function tests" begin
#     @testset "unimodal preferences 1 student" begin

# 	    p = rand(k)  # price
# 	    pref = [sparse(1:k,1:k,[100;0;0])] #one class prefered
# 	    budg = [100] #arbitrary budget
# 	    req = [1] #1 class is required
# 	    stds[1].preferences = sparse(1:k,1:k,[100;0;0])
# 	    stds[1].budget = 100
# 	    stds[1].req_FC = 1

# 	    CourseMatch.demand!(p, stds[1])
# 	    @test stds[1].allocation == [1, 0 , 0]
#     end

  #   @testset "unimodal preferences 2 students" begin
	 #    p = rand(3)
	 #    pref = []
	 #    push!(pref,sparse(1:3,1:3,[100;0;0]))
	 #    push!(pref,sparse(1:3,1:3,[0;100;0]))
	 #    budg = [100;100] #arbitrary budget
	 #    req = [1;1] #1 class is required
	 #    solution = CourseMatch.demand(p, pref, budg, req)
	 #    @test solution[:ind_demands] == [1 0 0;0 1 0]
	 #    @test solution[:course_demand] == [1 1 0]
	 #    @test solution[:total] == 2
  #   end

  #   @testset "unaffordable most preferred course" begin
	 #    p = rand(3)
	 #    p[1] = 101  # high price on course 1
	 #    pref = [sparse(1:3,1:3,[100;50;0])] #one class prefered
	 #    budg = [100] #arbitrary budget
	 #    req = [1] #1 class is required
	 #    solution = CourseMatch.demand(p, pref, budg, req)
	 #    @test solution[:ind_demands] == [0 1 0]
	 #    @test solution[:course_demand] == [0 1 0]
	 #    @test solution[:total] == 1
 	# end

  #   @testset "unaffordable most preferred course 2 students" begin
	 #    p = rand(3)
	 #    p[1] = 101  # high price on course 1
	 #    pref = []
	 #    push!(pref,sparse(1:3,1:3,[100;50;0]))
	 #    push!(pref,sparse(1:3,1:3,[100;0;50]))
	 #    budg = [100;100] #arbitrary budget
	 #    req = [1;1] #1 class is required
	 #    solution = CourseMatch.demand(p, pref, budg, req)
	 #    @test solution[:ind_demands] == [0 1 0;0 0 1]
	 #    @test solution[:course_demand] == [0 1 1]
	 #    @test solution[:total] == 2
 	# end

  #   @testset "substitutable classes" begin
  #   	#Here I have one student, 3 available classes, and it is required to enroll in two classes in total. The student as a stric ordering on the three classes
  #   	#but they have a strong preference over not taking their two most preferred ones together such that they prefer o take their preferred one
  #   	#and their least preferred one. The test checks if the demand functions does indeed select
  #   	#the most preferred combination of courses in this context.
  #   	# p = rand(3)
  #   	# pref = [[100 -100 0 ; -100 50 0; 0 0 0]]
  #   	# budg = [100] #arbitrary budget
  #   	# req = [2] #2 classes are required
  #   	# solution = CourseMatch.demand(p, pref, budg, req)
  #   	# @test solution[:ind_demands][1] == [1, 0, 1]
  #   	# @test solution[:total] == [1, 0, 1]
 	# end
  #   @testset "identical students" begin
	 #    #Here I have two strictly identical students, 3 available classes, and it is required to enroll in one classes n total. The test checks if the demand
	 #    #functions does indeed give the same demand for the two students.
	 #    # p = rand(3)
	 #    # pref = Matrix(diagm(rand(0:100, 3)))
	 #    # pref = [pref, pref]
	 #    # budg = rand(150:200, 1)[1]
	 #    # budg = [budg, budg]
	 #    # req = [1, 1] #1 class is required
	 #    # solution = CourseMatch.demand(p, pref, budg, req)
	 #    # @test solution[:ind_demands][1] == solution[:ind_demands][2]
	 #    # @test solution[:total] == 2*solution[:ind_demands][2]
 	# end
# end
