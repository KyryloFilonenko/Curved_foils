#@format=datatools::configuration::variant
#@format.version=1.0
#@organization=snemo
#@application=falaise

[registry="geometry"]
layout = "Basic"
layout/if_basic/magnetic_field = false
layout/if_basic/source_layout = "RealisticSNRS1"
layout/if_basic/source_calibration = false
layout/if_basic/shielding = true
calo_film_thickness = 25 um
tracking_gas_material = "Nemo3"

[registry="vertexes"]
generator = "real_snrs1_source_full_foils_se82_bulk"

[registry="primary_events"]
# generator = "Bi214_Po214"
generator = "Se82.0nubb"

[registry="simulation"]
physics_mode = "Constructors"
physics_mode/if_constructors/em_model = "standard"
production_cuts = true
output_profile = "all_details"
