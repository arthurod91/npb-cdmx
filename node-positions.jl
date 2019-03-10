#=
This is a program to calculate the position of the node for
the districts of transit
=#

struct District_of_transit
    #= A list with the population-employment densities of each of the AGEBs
    that make up the district (this data can also be considered as a identifier
    for each AGEB)
    =#
    ageb_pop_density::Vector{Float64}
    ageb_emp_density::Vector{Float64}
    # The coordinates of each of the vertices of the AGEBs
    coords_vertices::Vector{Vector{Vector{Float64}}}

    # All of the next attributes are subject of calculation
    ageb_centroids::Vector{Vector{Float64}}
    ageb_areas::Vector{Float64}
    # This is the total population-employment of the AGEBs
    ageb_totals::Vector{Float64}
    district_node_coords::Vector{Float64}
end

# getters and setters
vertices_of_agebs(d::District_of_transit)=d.coords_vertices
pop_densities_of_agebs(d::District_of_transit)=d.ageb_pop_density
emp_densities_of_agebs(d::District_of_transit)=d.ageb_emp_density

add_centroid_of_ageb!(d::District_of_transit,centroid_coords::Vector{Float64}) = push!(d.ageb_centroids,centroid_coords)
add_area_of_ageb!(d::District_of_transit,area::Float64) = push!(d.ageb_areas,area)
add_total_of_ageb!(d::District_of_transit,total::Float64) = push!(d.ageb_totals,total)
set_node_coords!(d::District_of_transit,node_coords::Vector{Float64}) = d.district_node_coords = node_coords

function centroid(list_of_vertex_coords)
    c = 1/size(list_of_vertex_coords,1) * sum(list_of_vertex_coords,dims=1)
end

# For this algorithm the list of vertices must be ordered
function area(list_of_vertex_coords)
    a = 0.
    for i in 1:size(list_of_vertex_coords,1)-1
        a += list_of_vertex_coords[i][1] * list_of_vertex_coords[i+1][2] - list_of_vertex_coords[i][2] * list_of_vertex_coords[i+1][1]
    end
    a += list_of_vertex_coords[end][1] * list_of_vertex_coords[1][2] - list_of_vertex_coords[end][2] * list_of_vertex_coords[1][1]
    area = a/2
end

function node(d::District_of_transit)
    number_of_agebs = size(pop_densities_of_agebs(d))
    for i in 1:number_of_agebs
        vertices_of_i = vertices_of_agebs(d)[i]
        rᵢ = centroid(vertices_of_i)
        add_centroid_of_ageb!(d,rᵢ)
        aᵢ = area(vertices_of_i)
        add_area_of_ageb!(d,aᵢ)

        # Have to talk about the calculation of ageb_totals
