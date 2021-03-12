using HDF5
using DataFrames
using CSV
using ProgressMeter
using ZipFile

include("file_pointers.jl")

SCED_keys = [
    "Resource_Name"
    "SCED_Time_Stamp"
    "LDL"
    "HDL"
    "HSL"
    "LSL"
    "Ancillary_Service_REGUP"
    "Ancillary_Service_REGDN"
    "Ancillary_Service_RRS"
    "Ancillary_Service_NSRS"
    "Telemetered_Net_Output"
    "Base_Point"
    "Resource_Type"
    "Telemetered_Resource_Status"
    "Start_Up_Cold_Offer"
    "Start_Up_Hot_Offer"
    "Start_Up_Inter_Offer"
    "Min_Gen_Cost"
]

SCED_keys_types = [
    String
    String
    Float64
    Float64
    Float64
    Float64
    Float64
    Float64
    Float64
    Float64
    Float64
    Float64
    String
    String
    Float64
    Float64
    Float64
    Float64
]

for i = 1:10
    push!(SCED_keys, "Submitted_TPO_MW$i")
    push!(SCED_keys_types, Float64)
    push!(SCED_keys, "Submitted_TPO_Price$i")
    push!(SCED_keys_types, Float64)
end

const type_map = Dict(SCED_keys .=> SCED_keys_types)

const fuels = ["CLLIG", "GSSUP", "GSREH", "GSNONR", "NUC", "SCLE90", "SCGT90", "CCGT90", "CCLE90"]
const exclusions = ["OUT"]

function get_csv_file_names(dir::String)
    file_array = readdir(dir)
    csv_files = [joinpath(dir, f) for f in file_array if occursin(r"(.csv)", f)]
    return csv_files
end

function get_empty_df()
    return DataFrame(SCED_keys[2:end] .=> fill(Any[], length(SCED_keys)-1))
end

function parse_sced_disclosures(zip_file::String)
    data = Dict{String,DataFrame}()
    open(zip_file, "r") do file_
    files_in_zip = ZipFile.Reader(file_)
    p = Progress(length(files_in_zip.files))
    for (ix, file) in enumerate(files_in_zip.files)
        if !occursin("csv", file.name)
           continue
        end
        res = CSV.File(file,
            types = type_map,
            select = SCED_keys,
            normalizenames = true,
        )
        for row in res
            if row.Resource_Type ∉ fuels || row.Telemetered_Resource_Status ∈ exclusions
                continue
            end
            data[row.Resource_Name] = get(
                data,
                row.Resource_Name,
                get_empty_df(),
            )
            keys = SCED_keys[2:end]
            push!(data[row.Resource_Name], Dict(keys .=> (getproperty(row, v) for v in Symbol.(keys))))
        end
        next!(p; showvalues = [(:file_count, ix)])
    end
end
    return data
end

sced_data = parse_sced_disclosures(thermal_sced_data)

function write_sced_to_hdf(input, file_name)
    h5open(file_name, "w") do file
        p = Progress(length(keys(input)))
        for (k, v) in input
            g = create_group(file, k)
            for col in names(v)
                if col in ["Resource_Name", "Resource_Type"]
                    continue
                end
                types_in_vector = typeof.((v[!, col]))
                if Float64 in types_in_vector
                    vals = Vector{Float64}(replace(x -> ismissing(x) ? NaN : x, v[!, col]))
                    g[col, shuffle=(), deflate=3] = vals
                elseif String in types_in_vector
                    vals = Vector{String}(replace(x -> ismissing(x) ? "NaN" : x, v[!, col]))
                    g[col] = vals
                elseif all(types_in_vector .== Missing)
                    continue
                else
                    @error "no match, $file, $col"
                end
            end
           next!(p)
        end
    end
end

write_sced_to_hdf(sced_data, joinpath(dirname(thermal_sced_data), "sced_data.h5"))
