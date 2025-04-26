#!/bin/sh
#SBATCH -t 0-$1
#SBATCH -n 1
#SBATCH --mem 8192M
#SBATCH --licenses sps

TUTO_FOLD=$2
FAL_FOLD=/sps/nemo/sw/Falaise/install_develop/
CONF_FAL=$FAL_FOLD/share/Falaise-4.1.0/resources/snemo/demonstrator/reconstruction/
CONF_SEN=/sps/nemo/scratch/kfilonen/Falaise/MiModule/testing_products/
TK_FOLD=$6
SN_FOLD=/sps/nemo/scratch/kfilonen/SNCuts/build/
FR_FOLD=/sps/nemo/scratch/kfilonen/Falaise/Francois/

if [ -f ${THRONG_DIR}/config/supernemo_profile.bash ]; then
	source ${THRONG_DIR}/config/supernemo_profile.bash
fi
snswmgr_load_setup falaise@5.1.5

flsimulate \
      --verbosity "fatal" \
      --mount-directory "flrecoex02@${FR_FOLD}" \
      --config "${TUTO_FOLD}/Simu_$4.conf" \
      --number-events $5 \
      --output-file "$TUTO_FOLD/$3/Simu_$4.brio"

flreconstruct \
      --verbosity "debug" \
      --mount-directory "flrecoex02@${TUTO_FOLD}" \
      --config "${TUTO_FOLD}/francois1_$4.conf" \
      --input-file "$TUTO_FOLD/$3/Simu_$4.brio" \
      --output-file "$TUTO_FOLD/$3/Reco_$4.brio"

# flsimulate \
#       --verbosity "fatal" \
#       --config "$FR_FOLD/flsimulate-ex02.conf" \
#       --number-events 100 \
#       --output-file "$TUTO_FOLD/$3/Simu_$4.brio"

# flreconstruct -i $TUTO_FOLD/$3/Simu_$4.brio \
#               -p $CONF_FAL/official-2.0.0.conf \
#               -o $TUTO_FOLD/$3/Reco_$4.brio

# rm $TUTO_FOLD/$3/Simu_$4.brio 

# flreconstruct -i $TUTO_FOLD/$3/Reco_$4.brio -p $TK_FOLD/build/TKReconstructPipeline.conf -o $TUTO_FOLD/$3/TK_TTD_$4.brio

# flreconstruct -i $TUTO_FOLD/$3/Simu_$4.brio -p $TK_FOLD/testing/test2/pipeline.conf -o $TUTO_FOLD/$3/TK_TTD_$4.brio

# # rm $TUTO_FOLD/$3/Reco_$4.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_TTD_$4.brio -p $TK_FOLD/PTD_tracking.conf -o $TUTO_FOLD/$3/TK_PTD_$4.brio
# # rm $TUTO_FOLD/$3/TK_TTD_$4.brio
              
# cd $TUTO_FOLD/$3/

# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_$4.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5.root

###################################################################################################################################
###################################################################################################################################
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_$4.brio -p $SN_FOLD/eps1.conf -o TK_PTD_SN_$4_eps1.brio
# # rm $TUTO_FOLD/$3/TK_PTD_$4.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4_eps1.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5_eps1.root

# flreconstruct -i TK_PTD_SN_$4_eps1.brio -p $SN_FOLD/eps2.conf -o TK_PTD_SN_$4_eps2.brio
# # rm $TUTO_FOLD/$3/TK_PTD_SN_$4_eps1.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4_eps2.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5_eps2.root

# flreconstruct -i TK_PTD_SN_$4_eps2.brio -p $SN_FOLD/eps3.conf -o TK_PTD_SN_$4_eps3.brio
# # rm $TUTO_FOLD/$3/TK_PTD_SN_$4_eps2.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4_eps3.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5_eps3.root

# flreconstruct -i TK_PTD_SN_$4_eps3.brio -p $SN_FOLD/eps4.conf -o TK_PTD_SN_$4_eps4.brio
# # rm $TUTO_FOLD/$3/TK_PTD_SN_$4_eps3.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4_eps4.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5_eps4.root

# flreconstruct -i TK_PTD_SN_$4_eps4.brio -p $SN_FOLD/eps5.conf -o TK_PTD_SN_$4_eps5.brio
# # rm $TUTO_FOLD/$3/TK_PTD_SN_$4_eps4.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4_eps5.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5_eps5.root

# flreconstruct -i TK_PTD_SN_$4_eps5.brio -p $SN_FOLD/eps6.conf -o TK_PTD_SN_$4_eps6.brio
# # rm $TUTO_FOLD/$3/TK_PTD_SN_$4_eps5.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4_eps6.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5_eps6.root

# flreconstruct -i TK_PTD_SN_$4_eps6.brio -p $SN_FOLD/eps7.conf -o TK_PTD_SN_$4_eps7.brio
# # rm $TUTO_FOLD/$3/TK_PTD_SN_$4_eps6.brio
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4_eps7.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf
# mv Default.root $4_$5_eps7.root

# # rm $TUTO_FOLD/$3/TK_PTD_SN_$4_eps7.brio
###################################################################################################################################
###################################################################################################################################

# rm $TUTO_FOLD/$3/TK_PTD_$4.brio
            
# flreconstruct -i $TUTO_FOLD/$3/TK_PTD_SN_$4.brio \
#               -p $CONF_SEN/p_MiModule_v00.conf

# rm $TUTO_FOLD/$3/TK_PTD_SN_$4.brio
            
# mv Default.root $4_$5.root