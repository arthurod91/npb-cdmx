struct District_of_transit
    # A list with the population-employment densities of each of the AGEBs
    # that make up the district (this data can also be considered as a identifier
    # for each AGEB)
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

function centroid(list_of_vertex_coords)
    c = 1/size(list_of_vertex_coords,1) * sum(list_of_vertex_coords,dims=1)
end

# For this algorithm the list must be ordered
function area(list_of_vertex_coords)
    a = 0.
    for i in 1:size(list_of_vertex_coords,1)-1
        a += list_of_vertex_coords[i][1] * list_of_vertex_coords[i+1][2] - list_of_vertex_coords[i][2] * list_of_vertex_coords[i+1][1]
    end
    a += list_of_vertex_coords[end][1] * list_of_vertex_coords[1][2] - list_of_vertex_coords[end][2] * list_of_vertex_coords[1][1]
    area = a/2
end
