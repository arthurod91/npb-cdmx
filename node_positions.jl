struct District_of_transit
    # A list with the population-employment densities of each of the AGEBs
    # that make up the district (it can also be considered as a identifier
    # for each AGEB)
    ageb_pop_density::Vector{Float64}
    ageb_emp_density::Vector{Float64}
    # The coordinates of each of the vertices of the AGEBs
    coords_vertices::Vector{Vector{NTuple{2,Float64}}}

    # All of the next attributes are subject of calculation
    ageb_centroids::Vector{Ntuple{2,Float64}}
    ageb_areas::Vector{Float64}
    # This is the total population-employment of the AGEBs
    ageb_totals::Vector{Float64}
    district_node_coords::Ntuple{2,Float64}
end

# using Makie

function centroid(vertex_coords,ref_coords::Array{Float64,2}=[0. 0.])
    c = ref_coords + 1/size(vertex_coords,1) * sum(vertex_coords,dims=1)
    # scene = Scene()
    # scatter!(scene,vertex_coords)
    # scatter!(scene,c,color=:red)
end

function node(district_ageb_matrix,ref_coords::Array{Float64,2}=[0. 0.])
    for i in district_ageb_matrix[:,:,1]
        ri = centroid(district_ageb_matrix[])
